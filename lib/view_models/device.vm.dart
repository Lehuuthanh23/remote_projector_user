import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../app/app_sp.dart';
import '../app/app_sp_key.dart';
import '../app/app_string.dart';
import '../models/camp/camp_model.dart';
import '../models/device/device_model.dart';
import '../models/dir/dir_model.dart';
import '../models/notification/notification_model.dart';
import '../models/response/response_result.dart';
import '../models/user/user.dart';
import '../requests/account/account.request.dart';
import '../requests/camp/camp.request.dart';
import '../requests/command/command.request.dart';
import '../requests/device/device.request.dart';
import '../requests/dir/dir.request.dart';
import '../requests/notification/notification.request.dart';
import '../view/home/home_page.dart';
import '../widget/pop_up.dart';
import 'dir.vm.dart';

class DeviceViewModel extends BaseViewModel {
  DeviceViewModel({
    required this.context,
    required this.currentDir,
  });

  final BuildContext context;
  final Dir currentDir;

  final DeviceRequest _deviceRequest = DeviceRequest();
  final DirRequest _dirRequest = DirRequest();
  final CommandRequest _commandRequest = CommandRequest();
  final CampRequest _campRequest = CampRequest();
  final NotificationRequest _notificationRequest = NotificationRequest();
  final TextEditingController searchEmailController = TextEditingController();
  final _navigationService = appLocator<NavigationService>();

  Device? _currentDevice;

  final List<Device> _listDeviceByDir = [];
  List<Device> get listDeviceByDir => _listDeviceByDir;

  final List<CampModel> _listVideoByDir = [];
  List<CampModel> get listVideoByDir => _listVideoByDir;

  final List<User> _listCustomer = [];
  List<User> get listCustomer => _listCustomer;

  Future<void> initialise() async {
    setBusy(true);

    await _fetchDeviceListInDir(currentDir.dirId);
    await _fetchVideoList();

    if (currentDir.isOwner == true) {
      await _fetchShareCustomerList();
    }

    setBusy(false);
  }

  @override
  void dispose() {
    searchEmailController.dispose();

    _listDeviceByDir.clear();
    _listCustomer.clear();

    super.dispose();
  }

  Future<void> refreshDeviceInDir() async {
    setBusy(true);
    await _fetchDeviceListInDir(currentDir.dirId);
    setBusy(false);
  }

  Future<void> refreshVideoInDir() async {
    setBusy(true);
    await _fetchVideoList();
    setBusy(false);
  }

  Future<void> refreshSharedCustomer() async {
    setBusy(true);
    await _fetchShareCustomerList();
    setBusy(false);
  }

  Future<void> getDeviceByIdDir(int? idDir) async {
    setBusy(true);
    await _fetchDeviceListInDir(idDir);
    setBusy(false);
  }

  void onCancelSharedCustomerTap(User user) {
    showPopupTwoButton(
      title:
          'Bạn có chắc chắn hủy chia sẻ thư mục cho ${user.customerName} không?',
      context: context,
      isError: true,
      onLeftTap: () => _handleCancelSharedUser(user),
    );
  }

  void onDeleteCampaignTaped(CampModel campaign) {
    showPopupTwoButton(
      title: 'Bạn có chắc chắn muốn xóa camp này',
      isError: true,
      context: context,
      onLeftTap: () {
        _handleDeleteCampaign(campaign);
      },
    );
  }

  Future<void> onAddNewVideoTaped() async {
    await _navigationService.navigateToEditCampPage(
      dir: currentDir,
      autoApprove: true,
    );
    refreshVideoInDir();
  }

  Future<void> onEditCampaignTaped(CampModel campModel) async {
    await _navigationService.navigateToEditCampPage(
      campEdit: campModel,
      dir: currentDir,
      autoApprove: true,
    );
    refreshVideoInDir();
  }

  Future<void> onCloningCampaignTaped(CampModel campModel) async {
    CampModel copiedModelCopied = campModel.cloningItem();
    await _navigationService.navigateToEditCampPage(
      campEdit: copiedModelCopied,
      dir: currentDir,
      autoApprove: true,
    );
    refreshVideoInDir();
  }

  Future<void> onHistoryRunCampaignTaped(CampModel campModel) async {
    await _navigationService.navigateToCampProfilePage(campModel: campModel);
    initialise();
  }

  Future<void> _handleDeleteCampaign(CampModel campaign) async {
    switch (await _campRequest.deleteCamp(campaign.campaignId)) {
      case ResultSuccess success:
        if (success.value) {
          _onDeleteCampaignSuccess(campaign);
        }
        break;
      case ResultError error:
        showResultError(context: context, error: error);
        break;
    }
  }

  Future<void> _onDeleteCampaignSuccess(CampModel campaign) async {
    if (campaign.campaignId != null) {
      int index = _listVideoByDir
          .indexWhere((element) => element.campaignId == campaign.campaignId);

      if (index > -1) {
        if (campaign.approvedYn != '1') {
          showPopupSingleButton(
            title:
                'Đã xóa video ${_listVideoByDir[index].campaignName} thành công',
            context: context,
          );
        } else {
          showPopupTwoButton(
            title:
                'Đã xóa video ${_listVideoByDir[index].campaignName} thành công, bạn có muốn cập nhật lại trên các thiết bị liên quan không?',
            context: context,
            barrierDismissible: false,
            onLeftTap: _handleUpdateDeviceInVideo,
          );
        }

        _listVideoByDir.removeAt(index);
        notifyListeners();
      }
    }
  }

  Future<void> _handleUpdateDeviceInVideo() async {
    setBusy(true);

    Set<String> resultSet = {};
    List<Device> list = await _deviceRequest.getDeviceByIdDir(currentDir.dirId);

    for (Device device in list) {
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
  }

  Future<void> _handleCancelSharedUser(User user) async {
    bool checkDelete = await deleteDirectoryShared(user.customerId);

    if (checkDelete) {
      await refreshSharedCustomer();
    } else if (context.mounted) {
      showPopupSingleButton(
        title: 'Có lỗi xảy ra, vui lòng thử lại sau.',
        context: context,
        isError: true,
      );
    }
  }

  Future<void> _fetchShareCustomerList() async {
    List<User> list =
        await _dirRequest.getShareCustomerList(currentDir.dirId.toString());

    _listCustomer.clear();
    _listCustomer.addAll(list);
  }

  Future<void> _fetchVideoList() async {
    List<CampModel> list = await _campRequest
        .getCampByIdDirectoryWithFilter(currentDir.dirId?.toString());
    _listVideoByDir.clear();
    _listVideoByDir.addAll(list);
  }

  Future<void> _fetchDeviceListInDir(int? idDir) async {
    List<Device> list = await _deviceRequest.getDeviceByIdDir(idDir);

    _listDeviceByDir.clear();
    _listDeviceByDir.addAll(list);
  }

  void setCurrentDevice(Device? device) {
    _currentDevice = device;
  }

  Future<bool> deleteDevice() async {
    if (_currentDevice == null) return false;

    bool checkDelete = await _deviceRequest.deleteDevice(_currentDevice!);

    if (checkDelete) {
      createCommand(device: _currentDevice!, command: AppString.deleteDevice);
    }

    if (context.mounted) {
      Navigator.pop(context);
    }

    return checkDelete;
  }

  void createCommand({
    required Device device,
    required String command,
    String content = '',
    String isImme = '0',
    int secondWait = 10,
  }) {
    _commandRequest.createNewCommand(
      device: device,
      command: command,
      content: content,
      isImme: isImme,
      secondWait: secondWait,
    );
  }

  deleteDir() async {
    if (_listDeviceByDir.isEmpty) {
      bool checkDelete =
          await _dirRequest.deleteDir(currentDir.dirId.toString());

      if (checkDelete) {
        if (context.mounted) {
          showPopupSingleButton(
            title: 'Xóa thư mục thành công',
            context: context,
            onButtonTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
          );
        }
      } else if (context.mounted) {
        showPopupSingleButton(
          title: 'Xóa thư mục thất bại',
          context: context,
          isError: true,
        );
      }
    } else {
      showPopupSingleButton(
        title: 'Không thể xóa thư mục có thiết bị',
        context: context,
        isError: true,
      );
    }
  }

  Future<bool> deleteDirectoryShared(String? customerId) async {
    if (customerId == null) return false;

    bool deleted = await _dirRequest.deleteDirShared(
      currentDir.dirId,
      customerId,
    );

    return deleted;
  }

  Future<User?> getCustomer() async {
    AccountRequest accountRequest = AccountRequest();
    User? user =
        await accountRequest.getCustomerByEmail(searchEmailController.text);
    return user;
  }

  Future<void> shareDir(String idDir, String customerIDTo) async {
    String userInfo = AppSP.get(AppSPKey.userInfo);
    final userJson = jsonDecode(userInfo);
    User currentUser = User.fromJson(userJson);
    String customerIDFrom = currentUser.customerId.toString();

    if (customerIDFrom == customerIDTo) {
      showPopupSingleButton(
        title: 'Không thể chia sẻ cho chính bản thân',
        context: context,
      );
      return;
    }

    if ((int.tryParse(customerIDTo) ?? 0) <= 0) {
      showPopupSingleButton(
        title: 'Chia sẻ không thành công, vui lòng thử lại sau',
        context: context,
      );
      return;
    }

    for (var user in _listCustomer) {
      if (user.customerId == customerIDTo) {
        showPopupSingleButton(
          title: 'Thư mục đã được chia sẻ cho ${user.customerName} trước đó',
          context: context,
        );
        return;
      }
    }

    String? errorMessage =
        await _dirRequest.shareDir(idDir, customerIDFrom, customerIDTo);

    if (errorMessage == null) {
      _notificationRequest.createNotification(
        NotificationModel(
          title: 'Chia sẻ thư mục',
          description: 'Bạn nhận được chia sẻ thư mục mới',
          detail:
              'Bạn nhận được chia sẻ thư mục từ người tên ${currentUser.customerName}',
        ),
        customerIDTo,
      );

      if (context.mounted) {
        initialise();

        showPopupSingleButton(
          title: 'Chia sẻ thư mục thành công',
          context: context,
        );
      }
    } else if (context.mounted) {
      showPopupSingleButton(
        title: 'Đã có lỗi xảy ra, vui lòng thử lại sau',
        isError: true,
        context: context,
      );
    }
  }

  Future<void> shareDevice(String? computerId, String idDir,
      DirViewModel dirViewModel, String customerIDTo) async {
    String userInfo = AppSP.get(AppSPKey.userInfo);
    final userJson = jsonDecode(userInfo);
    User currentUser = User.fromJson(userJson);
    String customerIDFrom = currentUser.customerId.toString();

    if (customerIDFrom == customerIDTo) {
      showPopupSingleButton(
        title: 'Không thể chia sẻ cho chính bản thân',
        context: context,
      );
      return;
    }

    if ((int.tryParse(customerIDTo) ?? 0) <= 0) {
      showPopupSingleButton(
        title: 'Chia sẻ không thành công, vui lòng thử lại sau',
        context: context,
      );
      return;
    }

    List<User> list = await _deviceRequest.getShareCustomerList(computerId);
    for (var user in list) {
      if (user.customerId == customerIDTo && context.mounted) {
        showPopupSingleButton(
          title: 'Thiết bị đã được chia sẻ cho ${user.customerName} trước đó',
          context: context,
        );
        return;
      }
    }

    String? errorMessage = await _deviceRequest.shareDevice(
        computerId, idDir, customerIDFrom, customerIDTo);
    if (errorMessage == null) {
      _notificationRequest.createNotification(
        NotificationModel(
          title: 'Chia sẻ thiết bị',
          description: 'Bạn nhận được chia sẻ thiết bị mới',
          detail:
              'Bạn nhận được chia sẻ thiết bị từ người tên ${currentUser.customerName}',
        ),
        customerIDTo,
      );

      if (context.mounted) {
        initialise();
        dirViewModel.refreshDir();
        dirViewModel.refreshSharedDevicesByCustomer();

        showPopupSingleButton(
          title: 'Chia sẻ thiết bị thành công',
          context: context,
        );
      }
    } else if (context.mounted) {
      initialise();

      showPopupSingleButton(
        title: 'Đã có lỗi xảy ra, vui lòng thử lại sau',
        isError: true,
        context: context,
      );
    }
  }

  Future<bool> updateDevice(Device device) async {
    bool updated = await _deviceRequest.updateDevice(device);

    return updated;
  }

  Future<void> onDeviceMovedSuccess(Device device) async {
    _commandRequest.createNewCommand(
      device: device,
      command: AppString.videoFromCamp,
      content: '',
      isImme: '0',
      secondWait: 10,
    );
    await initialise();
  }
}
