import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../constants/app_color.dart';
import '../../models/camp/camp_model.dart';
import '../../view_models/camp.vm.dart';
import '../../widget/base_page.dart';
import 'widgets/camp_item.dart';

class CampPage extends StatefulWidget {
  const CampPage({super.key});

  @override
  State<CampPage> createState() => _CampPageState();
}

class _CampPageState extends State<CampPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CampViewModel>.reactive(
      viewModelBuilder: () => CampViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.setContext(context);
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return BasePage(
          body: DefaultTabController(
            initialIndex: 0,
            length: 4,
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
                    const Tab(text: 'Tất cả'),
                    Tab(
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          const Text('Chờ duyệt'),
                          if (viewModel.listVideoRequest.isNotEmpty)
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
                                      viewModel.listVideoRequest.length > 99
                                          ? '99+'
                                          : '${viewModel.listVideoRequest.length}',
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
                    const Tab(text: 'Video đang chạy'),
                    const Tab(text: 'Video đã tắt'),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            RefreshIndicator(
                              onRefresh: () => viewModel.initialise(),
                              child: _lineViewAllCamp(viewModel),
                            ),
                            RefreshIndicator(
                              onRefresh: () => viewModel.initialise(),
                              child: _lineViewCampRequest(viewModel),
                            ),
                            RefreshIndicator(
                              onRefresh: () => viewModel.initialise(),
                              child: _lineViewCampRunning(viewModel: viewModel),
                            ),
                            RefreshIndicator(
                              onRefresh: () => viewModel.initialise(),
                              child: _lineViewCampDisable(viewModel: viewModel),
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

  Widget _lineViewAllCamp(CampViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listAllVideo.isEmpty)
          const Center(
            child: Text('Không có video nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listAllVideo.length,
          itemBuilder: (context, index) {
            return CampItem(
              data: viewModel.listAllVideo[index],
              onEditTap: viewModel.onEditCampaignTaped,
              onDeleteTap: viewModel.onDeleteCampaignTaped,
              onHistoryTap: viewModel.onHistoryRunCampaignTaped,
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewCampRequest(CampViewModel viewModel) {
    return Stack(
      children: [
        if (viewModel.listVideoRequest.isEmpty)
          const Center(
            child: Text('Không có video nào đang chờ duyệt'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listVideoRequest.length,
          itemBuilder: (context, index) {
            return CampItem(
              data: viewModel.listVideoRequest[index],
              onEditTap: viewModel.onEditCampaignTaped,
              onDeleteTap: viewModel.onDeleteCampaignTaped,
              onHistoryTap: viewModel.onHistoryRunCampaignTaped,
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewCampRunning({required CampViewModel viewModel}) {
    List<CampModel> listCampRunning = viewModel.listAllVideo
        .where((element) => element.status == '1')
        .toList();

    return Stack(
      children: [
        if (listCampRunning.isEmpty)
          const Center(
            child: Text('Không có video nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: listCampRunning.length,
          itemBuilder: (context, index) {
            return CampItem(
              data: listCampRunning[index],
              onEditTap: viewModel.onEditCampaignTaped,
              onDeleteTap: viewModel.onDeleteCampaignTaped,
              onHistoryTap: viewModel.onHistoryRunCampaignTaped,
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewCampDisable({required CampViewModel viewModel}) {
    List<CampModel> listCampDisable = viewModel.listAllVideo
        .where((element) => element.status != '1')
        .toList();

    return Stack(
      children: [
        if (listCampDisable.isEmpty)
          const Center(
            child: Text('Không có video nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: listCampDisable.length,
          itemBuilder: (context, index) {
            return CampItem(
              data: listCampDisable[index],
              onEditTap: viewModel.onEditCampaignTaped,
              onDeleteTap: viewModel.onDeleteCampaignTaped,
              onHistoryTap: viewModel.onHistoryRunCampaignTaped,
            );
          },
        ),
      ],
    );
  }
}
