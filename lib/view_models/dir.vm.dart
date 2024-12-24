import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../app/app_string.dart';
import '../models/device/device_model.dart';
import '../models/dir/dir_model.dart';
import '../requests/command/command.request.dart';
import '../requests/device/device.request.dart';
import '../requests/dir/dir.request.dart';
import '../view/device/device_page.dart';

class DirViewModel extends BaseViewModel {
  late BuildContext _context;

  final DirRequest _dirRequest = DirRequest();
  final DeviceRequest _deviceRequest = DeviceRequest();
  final CommandRequest _commandRequest = CommandRequest();

  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
  final TextEditingController folderNameController = TextEditingController();
  final TextEditingController changeFolderNameController =
      TextEditingController();
  final FocusNode folderNameFocusNode = FocusNode();
  final FocusNode changeFolderNameFocusNode = FocusNode();

  bool _isEditingFolderName = false;
  bool get isEditingFolderName => _isEditingFolderName;

  int? _idFolderChangeName;
  int? get idFolderChangeName => _idFolderChangeName;

  bool _isChangeFolderName = false;
  bool get isChangeFolderName => _isChangeFolderName;

  final List<Dir> _listDir = [];
  List<Dir> get listDir => _listDir;

  final List<Dir> _listShareDir = [];
  List<Dir> get listShareDir => _listShareDir;

  final List<Dir> _listShareDirByCustomer = [];
  List<Dir> get listShareDirByCustomer => _listShareDirByCustomer;

  final List<Device> _listSharedDevices = [];
  List<Device> get listSharedDevices => _listSharedDevices;

  final List<Device> _listSharedDevicesByCustomer = [];
  List<Device> get listSharedDevicesByCustomer => _listSharedDevicesByCustomer;

  final List<Device> _listExternalDevices = [];
  List<Device> get listExternalDevices => _listExternalDevices;

  double _currentSheetSize = 0.5;
  double get currentSheetSize => _currentSheetSize;

  double _topHeightFraction = 0.5;
  double get topHeightFraction => _topHeightFraction;

  final Dir defaultDir = Dir(
    dirId: -1,
    dirName: 'Không có',
    customerId: -1,
    dirType: '',
    createdBy: -1,
    createdDate: '',
    lastModifyBy: '',
    lastModifyDate: '',
    deleted: '',
    isOwner: true,
  );

  Dir currentDir = Dir(
    dirId: 0,
    dirName: '',
    customerId: 0,
    dirType: '',
    createdBy: 0,
    createdDate: '',
    lastModifyBy: '',
    lastModifyDate: '',
    deleted: '',
  );

  Future<void> initialise() async {
    setBusy(true);

    await getMyDir();
    await getShareDir();
    await getSharedDevices();
    await getSharedDirectoriesByCustomer();
    await getSharedDevicesByCustomer();
    await getExternalDevices();

    setBusy(false);
  }

  @override
  void dispose() {
    folderNameController.dispose();

    _listDir.clear();
    _listShareDir.clear();
    _listSharedDevices.clear();
    _listExternalDevices.clear();

    super.dispose();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> refreshExternalDevices() async {
    setBusy(true);
    await getExternalDevices();
    setBusy(false);
  }

  Future<void> refreshSharedDevices() async {
    setBusy(true);
    await getSharedDevices();
    setBusy(false);
  }

  Future<void> refreshSharedDevicesByCustomer() async {
    setBusy(true);
    await getSharedDevicesByCustomer();
    setBusy(false);
  }

  Future<void> refreshDir() async {
    setBusy(true);

    await getMyDir();
    await getShareDir();
    await getSharedDirectoriesByCustomer();

    setBusy(false);
  }

  void updateSheetSize(double size) {
    _currentSheetSize = size;
    notifyListeners();
  }

  void onChangeFraction(DragUpdateDetails details, double maxHeight) {
    _topHeightFraction += details.delta.dy / maxHeight;
    _topHeightFraction = _topHeightFraction.clamp(0.2, 0.8);
    notifyListeners();
  }

  Future<void> getMyDir() async {
    _listDir.clear();
    _listDir.addAll(await _dirRequest.getMyDir());
    for (var dir in _listDir) {
      dir.isOwner = true;
    }
  }

  void clearEditAndChangeNameFolder() {
    changeEditingFolderName(false);
    changeChangeFolderName(false);
  }

  void changeEditingFolderName(bool isEditing) {
    _isEditingFolderName = isEditing;

    if (isEditing) {
      folderNameFocusNode.requestFocus();
      _isChangeFolderName = false;
    } else {
      folderNameFocusNode.unfocus();
    }

    notifyListeners();
  }

  void changeChangeFolderName(bool isChange, {int? idFolder}) {
    _isChangeFolderName = isChange;
    _idFolderChangeName = idFolder;

    changeFolderNameController.clear();
    if (isChange) {
      Dir? dir = _listDir
          .where((element) => element.dirId == _idFolderChangeName)
          .firstOrNull;

      changeFolderNameFocusNode.requestFocus();
      changeFolderNameController.text = dir?.dirName ?? '';
      _isEditingFolderName = false;
    } else {
      changeFolderNameFocusNode.unfocus();
    }

    notifyListeners();
  }

  Future<void> onCreateNewFolderTaped() async {
    var name = folderNameController.text;
    if (name.isNotEmpty) {
      currentDir.dirName = name;
      currentDir.dirType = 'New Type';
      await createDir();
    }

    clearEditAndChangeNameFolder();
  }

  Future<void> onUpdateFolderTaped() async {
    var name = changeFolderNameController.text;
    Dir? dir = _listDir
        .where((element) => element.dirId == _idFolderChangeName)
        .firstOrNull;
    if (name.isNotEmpty && dir != null) {
      dir.dirName = name;

      if (await _dirRequest.updateDir(dir)) {
        await refreshDir();
      }
    }

    clearEditAndChangeNameFolder();
  }

  Future<void> getShareDir() async {
    _listShareDir.clear();
    _listShareDir.addAll(await _dirRequest.getShareDir());
  }

  Future<void> getSharedDevices() async {
    _listSharedDevices.clear();
    _listSharedDevices
        .addAll(await _deviceRequest.getDeviceCustomerSharedById());
    notifyListeners();
  }

  Future<void> getSharedDevicesByCustomer() async {
    _listSharedDevicesByCustomer.clear();
    _listSharedDevicesByCustomer
        .addAll(await _deviceRequest.getDeviceSharedFromCustomerId());
    notifyListeners();
  }

  Future<void> getSharedDirectoriesByCustomer() async {
    _listShareDirByCustomer.clear();
    _listShareDirByCustomer
        .addAll(await _dirRequest.getDirectoriesSharedFromCustomerId());
    notifyListeners();
  }

  Future<void> onDeviceMovedSuccess(Device device) async {
    _commandRequest.createNewCommand(
      device: device,
      command: AppString.videoFromCamp,
      content: '',
      isImme: '0',
      secondWait: 10,
    );
    await getExternalDevices();
  }

  Future<void> getExternalDevices() async {
    _listExternalDevices.clear();
    _listExternalDevices
        .addAll(await _deviceRequest.getExternalDeviceByCustomerId());
    notifyListeners();
  }

  Future<void> createDir() async {
    bool checkCreate =
        await _dirRequest.createDir(currentDir.dirName, currentDir.dirType);
    if (checkCreate) {
      folderNameController.clear();
      await refreshDir();
    }
  }

  void openDevicePage() {
    clearEditAndChangeNameFolder();
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => DevicePage(
          dirViewModel: this,
        ),
      ),
    );
  }
}
