import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../app/app_string.dart';
import '../models/camp/camp_model.dart';
import '../models/device/device_model.dart';
import '../models/response/response_result.dart';
import '../requests/camp/camp.request.dart';
import '../requests/command/command.request.dart';
import '../requests/device/device.request.dart';
import '../widget/pop_up.dart';

class CampViewModel extends BaseViewModel {
  late BuildContext _context;

  final CampRequest _campRequest = CampRequest();
  final DeviceRequest _deviceRequest = DeviceRequest();
  final CommandRequest _commandRequest = CommandRequest();
  final _navigationService = appLocator<NavigationService>();

  final List<CampModel> _listAllVideo = [];
  List<CampModel> get listAllVideo => _listAllVideo;

  final List<CampModel> _listVideoRequest = [];
  List<CampModel> get listVideoRequest => _listVideoRequest;

  Future<void> initialise() async {
    setBusy(true);

    await _getAllCampaign();

    for (var item in _listAllVideo) {
      item.listTimeRun = await _campRequest.getTimeRunCampById(item.campaignId);
    }

    setBusy(false);
  }

  @override
  void dispose() {
    _listAllVideo.clear();

    super.dispose();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> _getAllCampaign() async {
    List<CampModel> listShareCamp =
        await _campRequest.getCampSharedByIdCustomer();
    List<CampModel> listMyCamp = await _campRequest.getAllCampByIdCustomer();

    _listAllVideo.clear();
    _listVideoRequest.clear();

    _listAllVideo.addAll([...listMyCamp, ...listShareCamp]);
    _listVideoRequest.addAll(_listAllVideo
        .where((e) => e.approvedYn != '-1' && e.approvedYn != '1'));
  }

  void onDeleteCampaignTaped(CampModel campaign) {
    showPopupTwoButton(
      title: 'Bạn có chắc chắn muốn xóa camp này',
      isError: true,
      context: _context,
      onLeftTap: () {
        _handleDeleteCampaign(campaign);
      },
    );
  }

  Future<void> onEditCampaignTaped(CampModel? campModel) async {
    await _navigationService.navigateToEditCampPage(campEdit: campModel);
    initialise();
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
        showResultError(context: _context, error: error);
        break;
    }
  }

  Future<void> _onDeleteCampaignSuccess(CampModel campaign) async {
    if (campaign.campaignId != null) {
      int index = _listAllVideo
          .indexWhere((element) => element.campaignId == campaign.campaignId);

      if (index > -1) {
        await showPopupTwoButton(
          title:
              'Đã xóa video ${_listAllVideo[index].campaignName} thành công, bạn có muốn cập nhật lại trên các thiết bị liên quan không?',
          context: _context,
          barrierDismissible: false,
          onLeftTap: () => _handleUpdateDeviceInVideo(campaign),
        );

        _listAllVideo.removeAt(index);
        notifyListeners();
      }
    }
  }

  Future<void> _handleUpdateDeviceInVideo(CampModel campaign) async {
    setBusy(true);

    Set<String> resultSet = {};
    List<Device> list = [];

    if (campaign.idDir != null && campaign.idDir != '0') {
      list.addAll(
          await _deviceRequest.getDeviceByIdDir(int.tryParse(campaign.idDir!)));
    } else if (campaign.idComputer != null && campaign.idComputer != '0') {
      /// fetch device by id_computer
      /// list = await ...
    }

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
}
