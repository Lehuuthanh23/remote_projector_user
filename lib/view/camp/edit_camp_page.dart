import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../app/utils.dart';
import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../models/camp/camp_model.dart';
import '../../models/camp/time_run_model.dart';
import '../../models/device/device_model.dart';
import '../../models/dir/dir_model.dart';
import '../../view_models/edit_camp.vm.dart';
import '../../widget/base_page.dart';
import 'edit_camp_page.form.dart';
import 'widgets/camp_icon_box.dart';
import 'widgets/camp_time_box.dart';
import 'widgets/device_item.dart';
import 'widgets/directory_item.dart';
import 'widgets/line_camp_date.dart';
import 'widgets/line_camp_drop_down.dart';
import 'widgets/line_camp_edit_text.dart';
import 'widgets/time_range.dart';
import 'widgets/time_run_item.dart';

@FormView(fields: [
  FormTextField(name: 'campName'),
  FormTextField(name: 'link'),
  FormTextField(name: 'usb'),
  FormTextField(name: 'videoDuration'),
])
class EditCampPage extends StackedView<EditCampViewModel> with $EditCampPage {
  final CampModel? campEdit;
  final Dir? dir;
  final Device? computer;
  final bool autoApprove;

  const EditCampPage({
    super.key,
    this.campEdit,
    this.dir,
    this.computer,
    this.autoApprove = false,
  });

  @override
  Widget builder(
      BuildContext context, EditCampViewModel viewModel, Widget? child) {
    bool readOnly = !viewModel.showingBottomButton();
    bool showReject = !viewModel.inDeviceShared();

    return BasePage(
      showAppBar: true,
      title: viewModel.getTitlePage(),
      showLeadingAction: true,
      isBusy: viewModel.isBusy,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LineCampEditText(
                controller: campNameController,
                label: 'Tên video',
                readOnly: readOnly,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Đã chạy: ${viewModel.listCampProfile.length} lần',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.navUnSelect,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: viewModel.listCampProfile.isNotEmpty
                          ? viewModel.onHistoryRunCampaignTaped
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          'Xem lịch sử',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: viewModel.listCampProfile.isEmpty
                                ? AppColor.unSelectedLabel2
                                : AppColor.navUnSelect,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LineCampDropDown(
                label: 'Loại video',
                items: AppConstants.sourceVideo,
                itemShow: AppConstants.sourceVideo[viewModel.source],
                onItemChanged: readOnly ? null : viewModel.changeVideoType,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Trạng thái: ${viewModel.status == 1 ? 'Bật' : 'Tắt'}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.navUnSelect,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: viewModel.status == 1,
                      onChanged: campEdit?.approvedYn == '-1'
                          ? null
                          : viewModel.changeStatusCamp,
                      activeColor: AppColor.white,
                      activeTrackColor: AppColor.navSelected,
                      inactiveThumbColor: AppColor.white,
                      inactiveTrackColor: AppColor.bgInActiveSwitch,
                    ),
                  ),
                ],
              ),
              LineCampEditText(
                controller: linkController,
                label: 'Url Link',
                leadingIcon: 'assets/images/img_youtube.png',
                textInputAction: TextInputAction.next,
                leadingText: 'Thư mục của tôi',
                readOnly: readOnly,
                onLeadingTap: viewModel.onReviewUrlTaped,
                onLeadingTextTap:
                    readOnly ? null : viewModel.onResourceManageTaped,
              ),
              LineCampEditText(
                controller: usbController,
                textInputAction: TextInputAction.next,
                readOnly: readOnly,
                label: 'Link dự phòng (USB)',
              ),
              LineCampEditText(
                controller: videoDurationController,
                readOnly: readOnly,
                label: 'Thời lượng (giây)',
              ),
              const SizedBox(height: 10),
              const Text(
                'Giờ chạy trong ngày',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.navUnSelect,
                ),
              ),
              SizedBox(
                width: 230,
                child: ListView.builder(
                  itemCount: viewModel.listTimeRunning.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TimeRunItem(
                      time: viewModel.listTimeRunning[index],
                      index: index,
                      onSubtractTap: viewModel.onTimeRunDeleteTaped,
                      onTimeTap: readOnly
                          ? null
                          : (timeRun, iIndex) => onTimeRangeTaped(
                                context: context,
                                viewModel: viewModel,
                                index: iIndex,
                                timeRun: timeRun,
                              ),
                    );
                  },
                ),
              ),
              CampIconBox(
                icon: 'assets/images/ic_plus.png',
                onTap: readOnly
                    ? null
                    : () => onTimeRangeTaped(
                          context: context,
                          viewModel: viewModel,
                          index: -1,
                        ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Thứ trong tuần',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.navUnSelect,
                ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                child: ListView.builder(
                  itemCount: AppConstants.days.length + 1,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CampTimeBox(
                        centerText: 'Tất cả',
                        textColor: AppColor.white,
                        backgroundColor: AppColor.navSelected,
                        onTap: readOnly ? null : viewModel.addAllDayOfWeek,
                      );
                    }
                    return CampTimeBox(
                      centerText: AppConstants.days[index - 1],
                      textColor: viewModel.daysOfWeek
                              .contains(AppConstants.days[index - 1])
                          ? AppColor.navSelected
                          : AppColor.navUnSelect,
                      onTap: readOnly
                          ? null
                          : () => viewModel.addDayOfWeek(index - 1),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: LineCampDate(
                      label: 'Ngày bắt đầu',
                      content: viewModel.fromDate,
                      readOnly: readOnly,
                      onTextTap: viewModel.onDateRangeTaped,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LineCampDate(
                      label: 'Ngày kết thúc',
                      readOnly: readOnly,
                      content: viewModel.toDate,
                      onTextTap: viewModel.onDateRangeTaped,
                    ),
                  ),
                ],
              ),
              _buildReviewDevices(viewModel),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: viewModel.initialised && !readOnly ||
              (campEdit != null &&
                  int.tryParse(campEdit!.status ?? '0') != viewModel.status)
          ? Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.appBarEnd,
                    AppColor.appBarStart,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: viewModel.onSaveCampaignTaped,
                        child: Center(
                          child: Text(
                            (campEdit != null &&
                                        campEdit?.campaignId != null &&
                                        campEdit!.approvedYn != '1' &&
                                        showReject
                                    ? 'Lưu và duyệt'
                                    : viewModel.isCreateCamp
                                        ? 'Tạo mới'
                                        : 'Lưu thay đổi')
                                .toUpperCase(),
                            style: const TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (campEdit != null &&
                      campEdit?.campaignId != null &&
                      campEdit!.approvedYn != '1' &&
                      showReject)
                    Expanded(
                      child: Container(
                        color: AppColor.navUnSelect,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: viewModel.onRejectCampaign,
                            child: Center(
                              child: Text(
                                'Từ chối'.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  EditCampViewModel viewModelBuilder(BuildContext context) {
    EditCampViewModel viewModel = EditCampViewModel(
      context: context,
      autoApprove: autoApprove,
      campSelected: campEdit,
      device: computer,
      directory: dir,
    );
    return viewModel;
  }

  @override
  void onViewModelReady(EditCampViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.initialise();
  }

  @override
  void onDispose(EditCampViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  Widget _buildReviewDevices(EditCampViewModel viewModel) {
    Widget? view;

    if (viewModel.directory == null) {
      if (viewModel.devices.isNotEmpty) {
        view = DeviceItem(
          data: viewModel.devices[0],
          computerId: [viewModel.devices[0].computerId],
          onDeviceTap: (_) {},
        );
      }
    } else {
      view = DirectoryItem(
        dir: viewModel.directory!,
        controller: viewModel.expandableDirectoryController,
        deviceList: viewModel.devices,
        isOwner: viewModel.directory?.isOwner ?? false,
        computerId: viewModel.devices.map((e) => e.computerId).toList(),
        onChangeStateController: viewModel.onChangeDirectorySelected,
        onDeviceTap: (_) {},
      );
    }

    return view != null
        ? Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    viewModel.getDeviceTabTitle().toUpperCase(),
                    style: const TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  if (viewModel.directory != null)
                    InkWell(
                      onTap: viewModel.fetchDirectoryAndDevice,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.unSelectedLabel2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              view,
            ],
          )
        : const SizedBox();
  }

  Future<void> onTimeRangeTaped({
    required BuildContext context,
    required EditCampViewModel viewModel,
    required int index,
    TimeRunModel? timeRun,
  }) {
    final timeStart = stringToTimeOfDay(timeRun?.fromTime);
    final timeEnd = stringToTimeOfDay(timeRun?.toTime);
    final timeNow = DateTime.now();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Chọn thời gian chạy',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.navSelected,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TimeRangePicker(
            initialFromHour: timeStart?.hour ?? timeNow.hour,
            initialFromMinutes: timeStart?.minute ?? timeNow.minute,
            initialToHour: timeEnd?.hour ?? timeNow.hour,
            initialToMinutes: timeEnd?.minute ?? timeNow.minute,
            editable: true,
            is24Format: true,
            disableTabInteraction: true,
            onSelect: (from, to) {
              Navigator.pop(context);

              bool correctPos = compareTwoTime(from, to);

              if (index > -1) {
                viewModel.updateTimeRange(
                  index,
                  timeRun!,
                  TimeRunModel(
                    idRun: timeRun.idRun,
                    fromTime: convertTime(correctPos ? from : to),
                    toTime: convertTime(correctPos ? to : from),
                  ),
                );
              } else {
                viewModel.addTimeRange(TimeRunModel(
                  fromTime: convertTime(correctPos ? from : to),
                  toTime: convertTime(correctPos ? to : from),
                ));
              }
            },
            onCancel: () => Navigator.pop(context),
          ),
        );
      },
    );
  }
}
