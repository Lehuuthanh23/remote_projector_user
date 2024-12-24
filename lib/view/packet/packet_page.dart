import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../constants/app_color.dart';
import '../../view_models/packet.vm.dart';
import '../../widget/base_page.dart';
import 'widgets/my_packet_item.dart';
import 'widgets/packet_item.dart';

class PacketPage extends StatefulWidget {
  const PacketPage({super.key});

  @override
  State<PacketPage> createState() => _PacketPageState();
}

class _PacketPageState extends State<PacketPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PacketViewModel>.reactive(
      viewModelBuilder: () => PacketViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.setContext(context);
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return BasePage(
          isBusy: viewModel.isBusy,
          body: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: AppColor.navSelected,
                  labelColor: AppColor.navSelected,
                  unselectedLabelColor: AppColor.unSelectedLabel,
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 16),
                  tabs: [
                    Tab(text: "Gói cước cung cấp"),
                    Tab(text: "Gói cước đã mua"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      RefreshIndicator(
                        onRefresh: viewModel.refreshAllPacket,
                        child: _lineViewAllPacket(viewModel),
                      ),
                      RefreshIndicator(
                        onRefresh: viewModel.refreshMyPacket,
                        child: _lineViewMyPacket(viewModel),
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

  Widget _lineViewAllPacket(PacketViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.allPacket.isEmpty)
          const Center(
            child: Text('Không có gói cước nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.allPacket.length,
          itemBuilder: (context, index) {
            return PackageItem(
              data: viewModel.allPacket[index],
              buttonLabel: 'Mua gói cước',
              badgeImage: Image.asset("assets/images/img_package.png"),
              onBuyTap: viewModel.onPacketTaped,
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewMyPacket(PacketViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listMyPacket.isEmpty)
          const Center(
            child: Text('Không có gói cước đã mua nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listMyPacket.length,
          itemBuilder: (context, index) {
            return MyPackageItem(
              data: viewModel.listMyPacket[index],
              onCancelTap: viewModel.onCancelPacketTaped,
              onRenewalTap: viewModel.onRenewalPacketTaped,
            );
          },
        )
      ],
    );
  }
}
