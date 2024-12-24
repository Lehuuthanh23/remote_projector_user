import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../constants/app_color.dart';
import '../../view_models/device.vm.dart';
import '../../view_models/dir.vm.dart';
import '../../widget/base_page.dart';
import '../account/widgets/user_card.dart';
import '../camp/widgets/camp_item.dart';
import 'widget/device_card.dart';
import 'widget/search_customer_dialog.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key, required this.dirViewModel});

  final DirViewModel dirViewModel;

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeviceViewModel>.reactive(
      viewModelBuilder: () => DeviceViewModel(
        context: context,
        currentDir: widget.dirViewModel.currentDir,
      ),
      onViewModelReady: (viewModel) {
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          isBusy: viewModel.isBusy,
          isDevicePage: viewModel.currentDir.isOwner == true,
          onPressedDeleteDir: viewModel.deleteDir,
          onPressedShareDir: () async {
            SearchCustomerDialog.show(context, viewModel, (customerId) async {
              Navigator.pop(context);
              await viewModel.shareDir(
                viewModel.currentDir.dirId.toString(),
                customerId,
              );
            });
          },
          title: widget.dirViewModel.currentDir.dirName,
          body: DefaultTabController(
            length: viewModel.currentDir.isOwner == true ? 3 : 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: AppColor.navSelected,
                  labelColor: AppColor.navSelected,
                  unselectedLabelColor: AppColor.unSelectedLabel,
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  labelStyle: const TextStyle(fontSize: 16),
                  tabs: [
                    const Tab(text: 'Thiết bị'),
                    const Tab(text: 'Video'),
                    if (viewModel.currentDir.isOwner == true)
                      const Tab(text: 'Người được chia sẻ'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      RefreshIndicator(
                        onRefresh: viewModel.refreshDeviceInDir,
                        child: _lineViewDeviceInDir(viewModel),
                      ),
                      RefreshIndicator(
                        onRefresh: viewModel.refreshVideoInDir,
                        child: _lineViewVideoInDir(viewModel),
                      ),
                      if (viewModel.currentDir.isOwner == true)
                        RefreshIndicator(
                          onRefresh: viewModel.refreshSharedCustomer,
                          child: _lineViewSharedUserInDir(viewModel),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _lineViewDeviceInDir(DeviceViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listDeviceByDir.isEmpty)
          const Center(
            child: Text('Không có thiết bị nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listDeviceByDir.length,
          itemBuilder: (context, index) {
            return DeviceCard(
              deviceViewModel: viewModel,
              isOwner: widget.dirViewModel.currentDir.isOwner == true,
              data: viewModel.listDeviceByDir[index],
              dirViewModel: widget.dirViewModel,
              onMovedSuccess: (device) async {
                await widget.dirViewModel.initialise();
                await viewModel.onDeviceMovedSuccess(device);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewVideoInDir(DeviceViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listVideoByDir.isEmpty)
          const Center(
            child: Text('Không có video nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listVideoByDir.length,
          itemBuilder: (context, index) {
            return CampItem(
              data: viewModel.listVideoByDir[index],
              onEditTap: viewModel.onEditCampaignTaped,
              onCloningTap: viewModel.onCloningCampaignTaped,
              onDeleteTap: viewModel.onDeleteCampaignTaped,
              onHistoryTap: viewModel.onHistoryRunCampaignTaped,
            );
          },
        ),
        Positioned(
          bottom: 50,
          right: 10,
          child: Container(
            margin: const EdgeInsets.only(bottom: 25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.appBarStart,
                  AppColor.appBarEnd,
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: viewModel.onAddNewVideoTaped,
              icon: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _lineViewSharedUserInDir(DeviceViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listCustomer.isEmpty ||
            viewModel.currentDir.isOwner != true)
          const Center(
            child: Text('Không có người nào được chia sẻ'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listCustomer.length,
          itemBuilder: (context, index) {
            return UserCard(
              user: viewModel.listCustomer[index],
              onCancelSharedTap: viewModel.onCancelSharedCustomerTap,
            );
          },
        ),
      ],
    );
  }
}
