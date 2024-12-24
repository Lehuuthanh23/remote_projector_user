import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../app/app_sp.dart';
import '../app/app_sp_key.dart';
import '../app/app_string.dart';
import '../app/utils.dart';
import '../constants/app_color.dart';
import '../constants/app_constants.dart';
import '../models/camp/camp_model.dart';
import '../models/camp/camp_profile_model.dart';
import '../models/camp/time_run_model.dart';
import '../models/device/device_model.dart';
import '../models/dir/dir_model.dart';
import '../models/response/response_result.dart';
import '../models/user/user.dart';
import '../requests/camp/camp.request.dart';
import '../requests/command/command.request.dart';
import '../requests/device/device.request.dart';
import '../requests/dir/dir.request.dart';
import '../view/camp/edit_camp_page.form.dart';
import '../widget/pop_up.dart';

class EditCampViewModel extends FormViewModel {
  EditCampViewModel({
    required this.context,
    required this.autoApprove,
    this.campSelected,
    this.device,
    this.directory,
  });

  BuildContext context;
  CampModel? campSelected;
  Device? device;
  Dir? directory;
  bool autoApprove;

  bool get isCreateCamp =>
      campSelected == null ||
      (campSelected != null && campSelected!.campaignId == null);

  List<CampProfileModel> get listCampProfile =>
      campSelected?.listCampProfile ?? [];

  final CampRequest _campRequest = CampRequest();
  final DeviceRequest _deviceRequest = DeviceRequest();
  final DirRequest _dirRequest = DirRequest();
  final CommandRequest _commandRequest = CommandRequest();
  final ExpandableController expandableDirectoryController =
      ExpandableController();

  final _navigationService = appLocator<NavigationService>();

  final List<TimeRunModel> _listTimeAdding = [];
  final List<TimeRunModel> _listTimeRemoving = [];
  final List<TimeRunModel> _listTimeUpdating = [];

  int? _dirSelect;
  int? get dirSelect => _dirSelect;

  int _status = 0;
  int get status => _status;

  int _source = 0;
  int get source => _source;

  String _fromDate = formatDateToString(DateTime.now());
  String get fromDate => _fromDate;

  String _toDate = formatDateToString(DateTime.now());
  String get toDate => _toDate;

  final List<String> _listError = [];
  List<String> get listError => _listError;

  final List<TimeRunModel> _listTimeRunning = [];
  List<TimeRunModel> get listTimeRunning => _listTimeRunning;

  final List<String> _daysOfWeek = [];
  List<String> get daysOfWeek => _daysOfWeek;

  final List<Device> _devices = [];
  List<Device> get devices => _devices;

  final List<Device> _devicesSharedByOther = [];
  List<Device> get devicesSharedByOther => _devicesSharedByOther;

  final List<Dir> _directorySharedByOther = [];
  List<Dir> get directorySharedByOther => _directorySharedByOther;

  Future<void> initialise() async {
    await _updateCampSelected();
    setInitialised(true);
    notifyListeners();
  }

  @override
  void dispose() {
    _listTimeRunning.clear();
    _listTimeAdding.clear();
    _listTimeUpdating.clear();
    _listTimeRemoving.clear();
    _devicesSharedByOther.clear();
    directorySharedByOther.clear();
    _listError.clear();
    _daysOfWeek.clear();
    _devices.clear();
    expandableDirectoryController.dispose();

    super.dispose();
  }

  String getTitlePage() {
    if (campSelected != null && campSelected!.campaignId != null) {
      if (campSelected!.approvedYn == '-1') {
        return 'Đã từ chối duyệt';
      } else if (campSelected!.approvedYn != '1') {
        return 'Yêu cầu duyệt';
      }
    }

    return isCreateCamp ? 'Tạo mới' : 'Chỉnh sửa';
  }

  bool showingBottomButton() {
    if (campSelected != null) {
      if (campSelected!.approvedYn == '-1') {
        return false;
      }
      if (campSelected!.approvedYn == '1') {
        String? idDir = directory?.dirId?.toString() ?? campSelected?.idDir;
        String? idComputer = device?.computerId ?? campSelected?.idComputer;

        bool isInSharedDirectory = directorySharedByOther
            .where((e) => e.dirId?.toString() == idDir)
            .isNotEmpty;

        if (!isInSharedDirectory) {
          return _devicesSharedByOther
              .where((e) => e.computerId == idComputer)
              .isEmpty;
        }
      }
    }

    return true;
  }

  bool inDeviceShared() {
    String? idComputer = device?.computerId ?? campSelected?.idComputer;

    return _devicesSharedByOther
        .where((e) => e.computerId == idComputer)
        .isNotEmpty;
  }

  Future<void> onRejectCampaign() async {
    showPopupTwoButton(
      title: 'Bạn có chắc chắn từ tối yêu cầu duyệt video này không?',
      context: context,
      isError: true,
      onLeftTap: () async {
        switch (await _campRequest.updateStatusApproveCampaign(
            campSelected?.campaignId, -1)) {
          case ResultSuccess success:
            if (success.value) {
              _handleSuccessUpdateStatusCamp(-1);
            }
            break;
          case ResultError error:
            showResultError(context: context, error: error);
            break;
        }
      },
    );
  }

  void onSaveCampaignTaped() {
    if (campSelected != null &&
        campSelected?.campaignId != null &&
        campSelected!.approvedYn != '1') {
      _handleUpdateCampaign(onSuccess: _handleSaveAndApprovedCampaign);
    } else {
      campSelected == null || campSelected?.campaignId == null
          ? _handleCreateCampaign()
          : _handleUpdateCampaign();
    }
  }

  Future<void> _handleSaveAndApprovedCampaign() async {
    switch (await _campRequest.updateStatusApproveCampaign(
        campSelected?.campaignId, 1)) {
      case ResultSuccess success:
        if (success.value) {
          _handleSuccessUpdateStatusCamp(1);
        }
        break;
      case ResultError error:
        showResultError(context: context, error: error);
        break;
    }
  }

  Future<void> onHistoryRunCampaignTaped() async {
    if (campSelected != null) {
      await _navigationService.navigateToCampProfilePage(
          campModel: campSelected!);
      _fetchCampProfile();
    }
  }

  String getDeviceTabTitle() {
    String? idDir = directory?.dirId?.toString() ?? campSelected?.idDir;
    String? idComputer = device?.computerId ?? campSelected?.idComputer;

    if (idDir != null && idDir != '0') {
      return 'Thư mục';
    } else if (idComputer != null && idComputer != '0') {
      return 'Thiết bị';
    }

    return '';
  }

  void onResourceManageTaped() {
    _navigationService.navigateToResourceManagerPage(onChoseSuccess: (value) {
      linkValue = value;
    });
  }

  void onReviewUrlTaped() {
    if (linkValue!.isNotEmpty) {
      _navigationService.navigateToReviewVideoPage(
        urlFile: linkValue!,
        videoType: 0,
      );
    }
  }

  void onTimeRunDeleteTaped(int index) {
    showPopupTwoButton(
      title: 'Bạn có chắc chắn muốn xóa khoảng thời gian này',
      isError: true,
      context: context,
      onLeftTap: () {
        _removeTimeRange(listTimeRunning[index]);
      },
    );
  }

  void onChangeDirectorySelected(ExpandableController? controllerSelect) {
    controllerSelect?.expanded = !controllerSelect.expanded;
  }

  Future<void> onDateRangeTaped() async {
    DateTime start = stringToDateTime(fromDate);
    DateTime end = stringToDateTime(toDate);
    int nowYear = DateTime.now().year;

    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime(nowYear - 5),
        lastDate: DateTime(nowYear + 5),
        cancelButton: const Text(
          'Hủy',
          style: TextStyle(
            color: AppColor.navSelected,
            fontWeight: FontWeight.bold,
          ),
        ),
        okButton: const Text(
          'Xác nhận',
          style: TextStyle(
            color: AppColor.navSelected,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      value: [start, end],
      dialogSize: const Size(double.maxFinite, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (results != null && results.isNotEmpty) {
      _changeFromDate(formatDateToString(results[0]!));
      _changeToDate(
          formatDateToString(results.length > 1 ? results[1]! : results[0]!));
    }
  }

  Future<void> _updateCampSelected() async {
    var allTime = TimeRunModel(fromTime: '00:00', toTime: '23:59');
    if (campSelected == null) {
      videoDurationValue = '10';
      _daysOfWeek.addAll(AppConstants.days);
      _status = 1;
      _listTimeRunning.add(allTime);
      _listTimeAdding.add(allTime);
    } else {
      campNameValue = campSelected?.campaignName;
      linkValue = campSelected?.urlYoutube;
      usbValue = campSelected?.urlUSP;
      _status = int.parse(campSelected?.status ?? '0');
      _source = (campSelected?.videoType == 'youtube' ||
              campSelected?.videoType == 'url')
          ? 0
          : 1;
      _listTimeRunning.addAll(campSelected?.listTimeRun ?? []);
      if (_listTimeRunning.isEmpty) {
        _listTimeRunning.add(allTime);
        _listTimeAdding.add(allTime);
      }
      _fromDate = convertTimeString2(campSelected?.fromDate)!;
      _toDate = convertTimeString2(campSelected?.toDate)!;
      _daysOfWeek.addAll(
          (campSelected?.daysOfWeek ?? '').removeAllWhiteSpace().split(','));
      videoDurationValue = campSelected?.videoDuration;
      await _fetchCampProfile();
      await _fetchSharedList();
    }

    _sortedListTime();
    await fetchDirectoryAndDevice();
  }

  void addDayOfWeek(int index) {
    String day = AppConstants.days[index];
    _daysOfWeek.contains(day) ? _daysOfWeek.remove(day) : _daysOfWeek.add(day);
    notifyListeners();
  }

  void addAllDayOfWeek() {
    _daysOfWeek.clear();
    _daysOfWeek.addAll(AppConstants.days);
    notifyListeners();
  }

  void changeVideoType(String? sourceString) {
    if (sourceString != null) {
      int index = AppConstants.sourceVideo.indexOf(sourceString);
      if (index > -1) {
        _source = index;
        notifyListeners();
      }
    }
  }

  void changeStatusCamp(bool statusChange) {
    _status = statusChange ? 1 : 0;
    notifyListeners();
  }

  void _changeFromDate(String time) {
    _fromDate = time;
    notifyListeners();
  }

  void _changeToDate(String time) {
    _toDate = time;
    notifyListeners();
  }

  void changeDirSelect(int dirIndex) {
    _dirSelect = dirIndex == dirSelect ? null : dirIndex;
    notifyListeners();
  }

  Future<void> fetchDirectoryAndDevice() async {
    setBusy(true);

    String? idDir = directory?.dirId?.toString() ?? campSelected?.idDir;
    String? idComputer = device?.computerId ?? campSelected?.idComputer;
    List<Device> list = [];

    if (idDir != null && idDir != '0') {
      list = await _deviceRequest.getDeviceByIdDir(int.tryParse(idDir));
      directory ??= Dir(
        dirId: int.tryParse(idDir),
        dirName: 'Thư mục',
        isOwner: true,
      );
    } else if (idComputer != null && idComputer != '0') {
      Device? device =
          await _deviceRequest.getSingleDeviceByComputerId(idComputer);
      if (device != null) {
        list.add(device);
      }
    }
    _devices.clear();
    _devices.addAll(list);

    setBusy(false);
  }

  Future<void> _fetchSharedList() async {
    String? idDir = directory?.dirId?.toString() ?? campSelected?.idDir;
    String? idComputer = device?.computerId ?? campSelected?.idComputer;

    if (idDir != null && idDir != '0') {
      List<Dir> shareDir = await _dirRequest.getShareDir();
      directorySharedByOther.clear();
      directorySharedByOther.addAll(shareDir);
    }
    if (idComputer != null && idComputer != '0') {
      List<Device> shareDevice =
          await _deviceRequest.getDeviceCustomerSharedById();
      _devicesSharedByOther.clear();
      _devicesSharedByOther.addAll(shareDevice);
    }
  }

  Future<void> _fetchCampProfile() async {
    setBusy(true);

    List<CampProfileModel> list = await _campRequest.getCampaignRunProfile(
      campaignId: campSelected?.campaignId,
      fromDate: campSelected?.fromDate,
      toDate: campSelected?.toDate,
    );

    campSelected?.listCampProfile = list;

    setBusy(false);
  }

  void addTimeRange(TimeRunModel item) {
    int checkSame = _checkSameTime(timeCheck: item);
    if (checkSame != 1) {
      showErrorString(
        error:
            'Mốc thời gian nhập vào ${checkSame == -1 ? 'không hợp lệ' : 'bị trùng lặp'}, hãy thử lại',
        context: context,
      );
      return;
    }

    _listTimeRunning.add(item);
    _listTimeAdding.add(item);
    _sortedListTime();
    notifyListeners();
  }

  void updateTimeRange(int index, TimeRunModel oldTime, TimeRunModel newTime) {
    int checkSame = _checkSameTime(indexSubtract: index, timeCheck: newTime);
    if (checkSame != 1) {
      showErrorString(
        error:
            'Mốc thời gian nhập vào ${checkSame == -1 ? 'không hợp lệ' : 'bị trùng lặp'}, hãy thử lại',
        context: context,
      );
      return;
    }

    int indexInList = _listTimeRunning.indexOf(oldTime);
    if (indexInList > -1) {
      _listTimeRunning.replaceRange(indexInList, indexInList + 1, [newTime]);
      _sortedListTime();
    }

    if (oldTime.idRun != null) {
      int index = _listTimeUpdating.indexOf(oldTime);
      if (index > -1) {
        _listTimeUpdating.replaceFirstWhere(
            (currentValue) => currentValue.idRun == oldTime.idRun, newTime);
      } else {
        _listTimeUpdating.add(newTime);
      }
    } else {
      int index = _listTimeAdding.indexOf(oldTime);
      if (index > -1) {
        _listTimeAdding.replaceRange(index, index + 1, [newTime]);
      } else {
        _listTimeAdding.add(newTime);
      }
    }
    notifyListeners();
  }

  void _sortedListTime() {
    List<TimeRunModelWithParsedTime> parsedIntervals =
        _listTimeRunning.map((interval) {
      return TimeRunModelWithParsedTime(
        model: interval,
        fromTime: stringToTimeOfDay(interval.fromTime)!,
        toTime: stringToTimeOfDay(interval.toTime)!,
      );
    }).toList();

    parsedIntervals.sort((a, b) => compareTimeOfDay(a.fromTime, b.fromTime));

    List<TimeRunModel> sortedTimeIntervals = parsedIntervals.map((interval) {
      return interval.model;
    }).toList();

    _listTimeRunning.clear();
    _listTimeRunning.addAll(sortedTimeIntervals);
  }

  void _removeTimeRange(TimeRunModel item) {
    _listTimeRunning.remove(item);
    if (item.idRun != null) {
      _listTimeRemoving.add(item);
      _listTimeUpdating.removeWhere((element) => element.idRun == item.idRun);
    } else {
      _listTimeAdding.remove(item);
    }
    notifyListeners();
  }

  Future<void> _handleCreateCampaign() async {
    CampModel? camp = _handleCreateCampaignModel();
    if (camp == null) return;

    if (autoApprove) {
      camp.approvedYn = '1';
    }

    switch (await _campRequest.createCamp(camp)) {
      case ResultSuccess success:
        if (success.value != null) {
          await _handleUpdateTimeRunByCampId(success.value);
          _handleSuccessUpdateCamp();
        }
        break;
      case ResultError error:
        showResultError(context: context, error: error);
        break;
    }
  }

  Future<void> _handleUpdateCampaign({VoidCallback? onSuccess}) async {
    CampModel? camp = _handleCreateCampaignModel();
    if (camp == null) return;

    switch (await _campRequest.updateCamp(camp)) {
      case ResultSuccess success:
        if (success.value) {
          await _handleUpdateTimeRunByCampId(camp.campaignId);
          onSuccess != null ? onSuccess.call() : _handleSuccessUpdateCamp();
        }
        break;
      case ResultError error:
        showResultError(context: context, error: error);
        break;
    }
  }

  Future<void> _handleSuccessUpdateStatusCamp(int? status) async {
    if (status == -1) {
      _navigationService.back();
    } else {
      showPopupTwoButton(
        title:
            'Đã thay đổi thông tin video thành công. Bạn có muốn cập nhật lại trên tất cả các thiết bị không?',
        context: context,
        barrierDismissible: false,
        onLeftTap: _handleUpdateAllDevice,
        onRightTap: _navigationService.back,
      );
    }
  }

  void _handleSuccessUpdateCamp() {
    if (!autoApprove && campSelected?.approvedYn != '1') {
      _navigationService.back();
      return;
    }

    showPopupTwoButton(
      title:
          'Đã thay đổi thông tin video thành công. Bạn có muốn cập nhật lại trên tất cả các thiết bị không?',
      context: context,
      barrierDismissible: false,
      onLeftTap: _handleUpdateAllDevice,
      onRightTap: _navigationService.back,
    );
  }

  Future<void> _handleUpdateAllDevice() async {
    setBusy(true);

    Set<String> resultSet = {};

    for (Device device in _devices) {
      if (!resultSet.contains(device.computerId ?? '')) {
        await _commandRequest.createNewCommand(
          device: device,
          command: AppString.videoFromCamp,
          content: '',
          isImme: '0',
          secondWait: 10,
        );
        resultSet.add(device.computerId ?? '');
      }
    }

    setBusy(false);
    _navigationService.back();
  }

  Future<void> _handleUpdateTimeRunByCampId(String? campaignId) async {
    for (var item in _listTimeUpdating) {
      await _campRequest.updateTimeRunByIdRun(item);
    }

    for (var item in _listTimeRemoving) {
      await _campRequest.deleteTimeRunByIdRun(item);
    }

    for (var item in _listTimeAdding) {
      await _campRequest.addTimeRunByCampaignId(item, campaignId);
    }
  }

  CampModel? _handleCreateCampaignModel() {
    bool checkValid = true;
    _listError.clear();
    final User currentUser =
        User.fromJson(jsonDecode(AppSP.get(AppSPKey.userInfo)));

    if (campNameValue!.isEmpty) {
      checkValid = false;
      _listError.add('tên video');
    }
    if ((source == 0 && linkValue!.isEmpty) ||
        (source == 1 && usbValue!.isEmpty)) {
      checkValid = false;
      _listError.add('liên kết video ${AppConstants.sourceVideo[source]}');
    }
    if (_daysOfWeek.isEmpty) {
      checkValid = false;
      _listError.add('thứ trong tuần');
    }

    if (checkValid) {
      _daysOfWeek.sort(compareWeekdays);

      final campModel = CampModel(
        campaignId: campSelected?.campaignId,
        campaignName: campNameValue,
        status: '$_status',
        videoId: campSelected?.videoId,
        fromDate: convertTimeString(_fromDate),
        toDate: convertTimeString(_toDate),
        daysOfWeek: _daysOfWeek.join(','),
        videoType: AppConstants.sourceVideo[source],
        urlYoutube: linkValue,
        urlUSP: usbValue,
        videoDuration: videoDurationValue ?? '10',
        customerId: campSelected?.customerId ?? currentUser.customerId,
        idComputer: campSelected?.idComputer ?? device?.computerId,
        idDir: campSelected?.idDir ?? directory?.dirId?.toString(),
        approvedYn: campSelected?.approvedYn,
      );

      return campModel;
    } else {
      showErrorString(
        error:
            'Thông tin camp chưa được ${isCreateCamp ? 'tạo mới' : 'thay đổi'} do chưa nhập ${listError.length == 1 ? '' : 'các '}thông tin về ${listError.join(', ')}',
        context: context,
      );
    }

    return null;
  }

  int _checkSameTime(
      {int indexSubtract = -1, required TimeRunModel timeCheck}) {
    final startTime = stringToTimeOfDay(timeCheck.fromTime)!;
    final endTime = stringToTimeOfDay(timeCheck.toTime)!;
    if (endTime == startTime) return -1;
    if (_listTimeRunning.isEmpty) return 1;
    for (int i = 0; i < _listTimeRunning.length; i++) {
      if (indexSubtract != i) {
        var targetStartTime = stringToTimeOfDay(_listTimeRunning[i].fromTime)!;
        var targetEndTime = stringToTimeOfDay(_listTimeRunning[i].toTime)!;

        bool checkSame = _isTimeRangeOverlap(
            startTime, endTime, targetStartTime, targetEndTime);
        if (checkSame) return 0;
      }
    }

    return 1;
  }

  bool _isTimeRangeOverlap(TimeOfDay startTime, TimeOfDay endTime,
      TimeOfDay targetStartTime, TimeOfDay targetEndTime) {
    final start1 = startTime.hour * 60 + startTime.minute;
    final end1 = endTime.hour * 60 + endTime.minute;
    final start2 = targetStartTime.hour * 60 + targetStartTime.minute;
    final end2 = targetEndTime.hour * 60 + targetEndTime.minute;

    if (start1 < end1 && start2 < end2) {
      return start1 < end2 && start2 < end1;
    } else if (start1 > end1 && start2 > end2) {
      return true;
    } else if (start1 > end1) {
      return start2 < end1 || start2 > start1;
    } else if (start2 > end2) {
      return start1 < end2 || start1 > start2;
    }
    return false;
  }
}

class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);

  bool isEqualTo(Pair other) {
    return this.first == other.first && this.second == other.second;
  }
}

class TimeRunModelWithParsedTime {
  TimeRunModel model;
  TimeOfDay fromTime;
  TimeOfDay toTime;

  TimeRunModelWithParsedTime({
    required this.model,
    required this.fromTime,
    required this.toTime,
  });
}
