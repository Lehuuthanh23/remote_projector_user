import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app_string.dart';
import '../../app/utils.dart';
import '../../constants/app_color.dart';
import '../../models/device/device_model.dart';
import '../../models/dir/dir_model.dart';
import '../../models/user/user.dart';
import '../../view_models/detail_device.vm.dart';
import '../../view_models/device.vm.dart';
import '../../view_models/dir.vm.dart';
import '../../widget/base_page.dart';
import '../../widget/loading_shimmer.dart';
import '../../widget/pop_up.dart';
import '../account/widgets/user_card.dart';
import '../camp/widgets/camp_item.dart';
import '../camp/widgets/camp_line_action.dart';
import 'widget/device_card.dart';

class DeviceDetailPage extends StatefulWidget {
  final Device device;
  final Dir currentDir;
  final DeviceViewModel deviceViewModel;
  final DirViewModel dirViewModel;
  final bool inDir;

  const DeviceDetailPage({
    super.key,
    required this.device,
    required this.currentDir,
    required this.deviceViewModel,
    required this.dirViewModel,
    required this.inDir,
  });

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  bool checkAlive = false;

  @override
  void initState() {
    checkAlive = checkIfWithinFiveMinutes(widget.device.lastedAliveTime);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailDeviceViewModel>.reactive(
      viewModelBuilder: () => DetailDeviceViewModel(
        context: context,
        currentDevice: widget.device,
        currentDir: widget.currentDir,
        inDir: widget.inDir,
      ),
      onViewModelReady: (viewModel) {
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        bool checkLive =
            checkIfWithinFiveMinutes(widget.device.lastedAliveTime);
        if (checkLive == false &&
            checkAlive != checkLive &&
            !viewModel.isBusy) {
          viewModel.refreshCurrentDevice();
        }

        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          isBusy: viewModel.isBusy,
          title: 'Chi tiết thiết bị',
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: viewModel.refreshCurrentDevice,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(),
                    SliverFillRemaining(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: DeviceCard(
                              inDir: widget.currentDir.dirId != -1,
                              data: viewModel.currentDevice,
                              dirViewModel: widget.dirViewModel,
                              deviceViewModel: widget.deviceViewModel,
                              onTap: false,
                              isDetail: true,
                            ),
                          ),
                          Expanded(
                            child: viewModel.currentDevice.isOwner == true
                                ? _buildViewOwner(viewModel)
                                : _buildViewGuest(viewModel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (viewModel.isWaitCommand)
                const GradientLoadingWidget(
                  showFull: true,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildViewGuest(DetailDeviceViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CampLineAction(
          title: 'Xem giờ thiết bị',
          leadingIcon: const Icon(
            Icons.timer_sharp,
            size: 20,
            color: Colors.black,
          ),
          onTap: () async {
            if (!viewModel.isBusy) {
              await viewModel.createCommand(
                device: viewModel.currentDevice,
                command: AppString.getTimeNow,
              );
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          child: Text(
            'Danh sách video',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          color: AppColor.appBarStart.withOpacity(0.1),
          width: double.infinity,
          height: 40,
          margin: const EdgeInsets.only(top: 5),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: viewModel.onAddNewVideoTaped,
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Thêm video mới cho thiết bị',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: viewModel.refreshCampInDevice,
            child: ListView.builder(
              itemCount: viewModel.listCampOnDevice.length,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                return CampItem(
                  data: viewModel.listCampOnDevice[index],
                  onEditTap: viewModel.onEditCampaignTaped,
                  onCloningTap: viewModel.onCloningCampaignTaped,
                  onDeleteTap: viewModel.onDeleteCampaignTaped,
                  onHistoryTap: viewModel.onHistoryRunCampaignTaped,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewOwner(DetailDeviceViewModel viewModel) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: SizedBox(
              height: 40,
              child: TabBar(
                indicatorColor: AppColor.navSelected,
                labelColor: AppColor.navSelected,
                unselectedLabelColor: AppColor.unSelectedLabel,
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                labelStyle: const TextStyle(fontSize: 16),
                tabs: [
                  const Tab(text: 'Thiết bị'),
                  const Tab(text: 'Video'),
                  Tab(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        const Text('Chờ duyệt'),
                        if (viewModel.listCampRequestOnDevice.isNotEmpty)
                          Positioned(
                            top: -5,
                            right: -10,
                            child: IgnorePointer(
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    viewModel.listCampRequestOnDevice.length >
                                            99
                                        ? '99+'
                                        : '${viewModel.listCampRequestOnDevice.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: ExpandablePanel(
                        controller: viewModel.expandableManagerController,
                        header: Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            'Quản lý thiết bị',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Material(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              const Divider(height: 1),
                              Row(
                                children: [
                                  Expanded(
                                    child: CampLineAction(
                                      title: 'Xem giờ thiết bị',
                                      leadingIcon: const Icon(
                                        Icons.timer_sharp,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onTap: () async {
                                        if (!viewModel.isBusy) {
                                          await viewModel.createCommand(
                                            device: viewModel.currentDevice,
                                            command: AppString.getTimeNow,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CampLineAction(
                                      title: 'Khởi động lại ứng dụng',
                                      leadingIcon: const Icon(
                                        Icons.restart_alt_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onTap: () async {
                                        if (!viewModel.isBusy) {
                                          await viewModel.createCommand(
                                            device: viewModel.currentDevice,
                                            command: AppString.restartApp,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 1),
                              Row(
                                children: [
                                  Expanded(
                                    child: CampLineAction(
                                      title: 'Dừng / Tiếp tục video',
                                      leadingIcon: const Icon(
                                        Icons.motion_photos_paused,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onTap: () async {
                                        if (!viewModel.isBusy) {
                                          await viewModel.createCommand(
                                            device: viewModel.currentDevice,
                                            command: AppString.videoPause,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CampLineAction(
                                      title: 'Tắt chạy video',
                                      leadingIcon: const Icon(
                                        Icons.stop_circle_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onTap: () async {
                                        if (!viewModel.isBusy) {
                                          await viewModel.createCommand(
                                            device: viewModel.currentDevice,
                                            command: AppString.videoStop,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 1),
                              Row(
                                children: [
                                  Expanded(
                                    child: CampLineAction(
                                      title: 'Chạy USB',
                                      leadingIcon: const Icon(
                                        Icons.usb,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onTap: () async {
                                        if (!viewModel.isBusy) {
                                          await viewModel.createCommand(
                                            device: viewModel.currentDevice,
                                            command: AppString.videoFromUSB,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CampLineAction(
                                      title: 'Chạy CAMP',
                                      leadingIcon: const Icon(
                                        Icons.campaign_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onTap: () async {
                                        if (!viewModel.isBusy) {
                                          await viewModel.createCommand(
                                            device: viewModel.currentDevice,
                                            command: AppString.videoFromCamp,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (viewModel.listCustomerOnDevice.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                        ),
                        child: Text(
                          'Người được chia sẻ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    if (viewModel.listCustomerOnDevice.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.listCustomerOnDevice.length,
                          itemBuilder: (context, index) {
                            return UserCard(
                              user: viewModel.listCustomerOnDevice[index],
                              onCancelSharedTap: (user) {
                                cancelSharedDevice(viewModel, user);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
                RefreshIndicator(
                  onRefresh: viewModel.refreshCampInDevice,
                  child: _lineViewVideoInDevice(viewModel),
                ),
                RefreshIndicator(
                  onRefresh: viewModel.refreshCampInDevice,
                  child: _lineViewVideoRequestInDevice(viewModel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lineViewVideoInDevice(DetailDeviceViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColor.appBarStart.withOpacity(0.1),
          width: double.infinity,
          height: 40,
          margin: const EdgeInsets.only(top: 5),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => viewModel.onAddNewVideoTaped(autoApprove: true),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Thêm video mới cho thiết bị',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.listCampOnDevice.length,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return CampItem(
                data: viewModel.listCampOnDevice[index],
                onEditTap: (camp) => viewModel.onEditCampaignTaped(
                  camp,
                  autoApprove: true,
                ),
                onCloningTap: (camp) => viewModel.onCloningCampaignTaped(
                  camp,
                  autoApprove: true,
                ),
                onDeleteTap: viewModel.onDeleteCampaignTaped,
                onHistoryTap: viewModel.onHistoryRunCampaignTaped,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _lineViewVideoRequestInDevice(DetailDeviceViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listCampRequestOnDevice.isEmpty)
          const Center(
            child: Text('Không có video nào đang chờ duyệt'),
          ),
        ListView.builder(
          itemCount: viewModel.listCampRequestOnDevice.length,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            return CampItem(
              data: viewModel.listCampRequestOnDevice[index],
              onEditTap: (camp) => viewModel.onEditCampaignTaped(
                camp,
                autoApprove: true,
              ),
              onCloningTap: (camp) => viewModel.onCloningCampaignTaped(
                camp,
                autoApprove: true,
              ),
              onDeleteTap: viewModel.onDeleteCampaignTaped,
              onHistoryTap: viewModel.onHistoryRunCampaignTaped,
            );
          },
        ),
      ],
    );
  }

  void cancelSharedDevice(DetailDeviceViewModel viewModel, User user) {
    showPopupTwoButton(
      title:
          'Bạn có chắc chắn hủy chia sẻ thiết bị cho ${user.customerName} không?',
      context: context,
      isError: true,
      onLeftTap: () async {
        bool checkDelete = await viewModel.deleteDeviceShared(user.customerId);
        if (checkDelete) {
          viewModel.initialise();
        } else if (mounted) {
          showPopupSingleButton(
            title: 'Có lỗi xảy ra, vui lòng thử lại sau.',
            context: context,
            isError: true,
          );
        }
      },
    );
  }
}
