import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/utils.dart';
import '../../constants/app_color.dart';
import '../../models/statistics/camp_all_statistics.dart';
import '../../view_models/camp_statistics_all.vm.dart';
import '../../widget/base_page.dart';
import 'widget/line_case_color_profile.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CampStatisticsAllViewModel>.reactive(
      viewModelBuilder: () => CampStatisticsAllViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.setContext(context);
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return BasePage(
          isBusy: viewModel.isBusy,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RefreshIndicator(
              onRefresh: viewModel.refreshStatistics,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(),
                  SliverFillRemaining(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            color: AppColor.navSelected,
                          ),
                          series: getSourceSeries(viewModel),
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Thời gian: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.navUnSelect,
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: viewModel.onDateRangeTaped,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      '${convertTimeString2(viewModel.timeGetProfile?.first ?? DateFormat('yyyy-MM-dd').format(DateTime.now()))} - ${convertTimeString2(viewModel.timeGetProfile?.second ?? DateFormat('yyyy-MM-dd').format(DateTime.now()))}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: viewModel.listAllCamp.length,
                            itemBuilder: (context, index) {
                              return LineCaseColorProfile(
                                label:
                                    viewModel.listAllCamp[index].campaignName,
                                color: viewModel.listAllCamp[index].colorChart,
                                onLabelTap: () => viewModel
                                    .onSingleStatisticCampaignTaped(index),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<StackedColumnSeries<CampAllStatistics, String>> getSourceSeries(
      CampStatisticsAllViewModel viewModel) {
    if (viewModel.timeGetProfile == null) return [];

    List<StackedColumnSeries<CampAllStatistics, String>> listReturn = [];
    List<CampAllStatistics> listStatistics = viewModel.divideDataByTimePeriod();

    viewModel.listAllCamp.forEachIndexed((index, value) {
      listReturn.add(StackedColumnSeries<CampAllStatistics, String>(
        dataSource: listStatistics,
        xValueMapper: (item, _) => item.label,
        yValueMapper: (item, _) => item.data[index],
        name: value.campaignName,
        color: value.colorChart ?? Colors.white,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          labelAlignment: ChartDataLabelAlignment.middle,
          showZeroValue: false,
          textStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ));
    });

    return listReturn;
  }
}
