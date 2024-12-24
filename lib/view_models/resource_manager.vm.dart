import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../app/utils.dart';
import '../constants/app_api.dart';
import '../models/resource/resource_model.dart';
import '../models/resource/resource_picker_model.dart';
import '../models/response/response_result.dart';
import '../requests/resource/resource.request.dart';
import '../widget/pop_up.dart';

class ResourceMangerViewModel extends BaseViewModel {
  late BuildContext _context;
  ValueChanged<String>? _onChoseSuccess;

  final ResourceRequest _resourceRequest = ResourceRequest();
  final ImagePicker _picker = ImagePicker();
  final _navigationService = appLocator<NavigationService>();

  bool _folderIsExist = false;

  int _totalSizeFolder = 0;
  int get totalSizeFolder => _totalSizeFolder;

  final List<ResourcePickerModel> _listFilePicker = [];
  List<ResourcePickerModel> get listFilePicker => _listFilePicker;

  final List<ResourceModel> _listResource = [];
  List<ResourceModel> get listResource => _listResource;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  Future<void> initialise() async {
    setBusy(true);

    _folderIsExist = await _resourceRequest.checkDirectoryExist();
    if (_folderIsExist) {
      await _handleGetTotalSizeFolder();
      await _getResourceFileFromFolder();
    }

    setBusy(false);
  }

  @override
  void dispose() {
    _listFilePicker.clear();
    _listResource.clear();

    super.dispose();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void setChoseSuccess(ValueChanged<String>? onChoseSuccess) {
    _onChoseSuccess = onChoseSuccess;
  }

  Future<void> refreshResourceFileFromFolder() async {
    if (_folderIsExist) {
      setBusy(true);
      await _getResourceFileFromFolder();
      setBusy(false);
    }
  }

  Future<void> _getResourceFileFromFolder() async {
    List<String> listPath =
        await _resourceRequest.getFilesFromDirectoryResource();
    _listResource.clear();
    _listResource.addAll(listPath
        .map((path) => ResourceModel(
              fileUrl: path.replaceFirst('.', Api.hostApi),
              fileType: isImageUrl(path) ? 'image' : 'video',
              fileName: path.split('/').last,
            ))
        .toList());

    for (var item in _listResource) {
      item.fileSize =
          await _resourceRequest.getSizeOfFileResource(item.fileUrl);
    }
  }

  Future<void> onAddVideoFromStorageTaped() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    _updateVideoPicker(file);
  }

  Future<void> onAddImagesFromStorageTaped() async {
    List<XFile> files = [];

    if (_onChoseSuccess == null) {
      files = await _picker.pickMultiImage();
    } else {
      XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        files.add(file);
      }
    }

    _updateImagesPicker(files);
  }

  void onUploadSingleFileTaped(ResourcePickerModel filePicker) {
    if (filePicker.cancelToken == null) {
      if (_checkFileNameDuplicate(filePicker)) {
        showErrorString(
          error:
              'Tên file bị trùng, vui lòng xóa tài nguyên có sẵn hoặc đổi tên file đã chọn',
          context: _context,
        );
      } else {
        _handleUploadFileToFolderResource(
          filePicker,
          showPopup: true,
        );
      }
    } else {
      _handleCancelUploadFileToFolderResource(filePicker);
    }
  }

  void onUploadAllFileTaped() {
    if (_handleUploadAllFile()) {
      showErrorString(
        error:
            'Có lỗi xảy ra đối với một số file, hãy thử tải lên lại chúng sau',
        context: _context,
      );
    }
  }

  void onDeleteFileResourceTaped(String fileName) {
    showPopupTwoButton(
      title: 'Bạn có chắc chắn xóa file này?',
      context: _context,
      isError: true,
      onLeftTap: () => _handleDeleteFileResource(fileName),
    );
  }

  void onDeleteFilePickerTaped(int id) {
    _listFilePicker.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toReviewPage(String path, int videoType, bool isImage) {
    _navigationService.navigateToReviewVideoPage(
      urlFile: path,
      videoType: videoType,
      isImage: isImage,
    );
  }

  void setIsUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  /// return true when at least 1 file name duplicated
  bool _handleUploadAllFile() {
    Set<String?> listName = {};
    int duplicationCount = 0;

    for (var item in _listFilePicker) {
      if (!_checkFileNameDuplicate(item) &&
          !listName.contains(item.file?.name)) {
        _handleUploadFileToFolderResource(item);
        listName.add(item.file?.name);
      } else {
        duplicationCount += 1;
      }
    }

    return duplicationCount > 0;
  }

  Future<void> _handleGetTotalSizeFolder() async {
    _totalSizeFolder = await _resourceRequest.getSizeOfDirectoryResource();
    notifyListeners();
  }

  Future<void> _handleDeleteFileResource(String fileName) async {
    switch (await _resourceRequest.deleteFileFromDirectoryResource(fileName)) {
      case ResultSuccess success:
        if (success.value) {
          _onDeleteFileResourceSuccess(fileName);
        }
        break;
      case ResultError error:
        showResultError(context: _context, error: error);
        break;
    }
  }

  void _onDeleteFileResourceSuccess(String fileName) {
    int index = _listResource.indexWhere((model) => model.fileName == fileName);

    if (index > -1) {
      _listResource.removeAt(index);
      notifyListeners();
    }
    _handleGetTotalSizeFolder();

    showPopupSingleButton(
      title: 'Đã xóa thành công $fileName',
      context: _context,
    );
  }

  void _handleCancelUploadFileToFolderResource(ResourcePickerModel filePicker) {
    if (filePicker.progress < 95) {
      filePicker.cancelToken?.cancel();
      filePicker.cancelToken = null;
      filePicker.progress = 0;
      notifyListeners();
    }

    _setBusyWhenActionDone(idNotCheck: filePicker.id);
  }

  void _setBusyWhenActionDone({int? idNotCheck}) {
    int listUploading = 0;
    for (var item in _listFilePicker) {
      if (item.id != idNotCheck) {
        if (item.cancelToken != null) {
          listUploading += 1;
        }
      }
    }
    setIsUploading(listUploading != 0);
  }

  Future<void> _handleUploadFileToFolderResource(ResourcePickerModel filePicker,
      {bool showPopup = false}) async {
    if (!_folderIsExist) {
      bool uploadNext = await _resourceRequest.createDirectory();
      _folderIsExist = uploadNext;
    }

    if (_folderIsExist) {
      setIsUploading(true);
      ResponseResult<String?> uploadResponse =
          await _resourceRequest.uploadFile(filePicker, (onProgress) {
        filePicker.progress = onProgress;
        notifyListeners();
      });

      switch (uploadResponse) {
        case ResultSuccess success:
          if (success.value != null) {
            if (_onChoseSuccess != null) {
              _onChoseSuccess!
                  .call(success.value.replaceFirst('.', Api.hostApi));
              _navigationService.back();
            } else {
              _onUploadFileSuccess(filePicker, success.value, showPopup);
            }
          }
          break;
        case ResultError error:
          if (showPopup && _context.mounted) {
            showResultError(context: _context, error: error);
          }
          break;
      }

      _setBusyWhenActionDone(idNotCheck: filePicker.id);
      _handleGetTotalSizeFolder();
    }
  }

  void _onUploadFileSuccess(
      ResourcePickerModel filePicker, String filePath, bool showPopup) {
    int index = _listFilePicker.indexOf(filePicker);
    String fileName = filePath.split('/').last;

    if (index > -1) {
      _listFilePicker.removeAt(index);
      notifyListeners();
    }

    _listResource.add(ResourceModel(
      fileUrl: filePath.replaceFirst('.', Api.hostApi),
      fileType: isImageUrl(filePath) ? 'image' : 'video',
      fileName: fileName,
      fileSize: filePicker.fileSize,
    ));

    if (showPopup) {
      showPopupSingleButton(
        title: 'Đã tải lên $fileName thành công',
        context: _context,
      );
    }
  }

  Future<void> _updateVideoPicker(XFile? file) async {
    if (file != null) {
      DateTime now = DateTime.now();
      int fileSize = await file.length();

      if (_onChoseSuccess != null) {
        _listFilePicker.clear();
      }

      _listFilePicker.add(ResourcePickerModel(
        file: file,
        type: 'video',
        fileSize: fileSize,
        id: now.millisecondsSinceEpoch,
      ));
      notifyListeners();
    }
  }

  Future<void> _updateImagesPicker(List<XFile> files) async {
    if (files.isNotEmpty) {
      int now = DateTime.now().millisecondsSinceEpoch;
      if (_onChoseSuccess != null) {
        int fileSize = await files[0].length();
        _listFilePicker.clear();
        _listFilePicker.add(ResourcePickerModel(
          file: files[0],
          type: 'image',
          fileSize: fileSize,
          id: now,
        ));
      } else {
        for (var file in files) {
          int fileSize = await file.length();
          _listFilePicker.add(ResourcePickerModel(
            file: file,
            type: 'image',
            fileSize: fileSize,
            id: now,
          ));
          now += 1;
        }
      }
      notifyListeners();
    }
  }

  /// return true when file name duplicated
  bool _checkFileNameDuplicate(ResourcePickerModel filePicker) {
    for (var item in _listResource) {
      if (item.fileName == filePicker.file?.name) {
        return true;
      }
    }
    return false;
  }
}
