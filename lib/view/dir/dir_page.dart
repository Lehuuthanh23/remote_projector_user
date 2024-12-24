import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../constants/app_color.dart';
import '../../models/dir/dir_model.dart';
import '../../view_models/device.vm.dart';
import '../../view_models/dir.vm.dart';
import '../../widget/base_page.dart';
import '../device/widget/device_card.dart';

class DirPage extends StatefulWidget {
  const DirPage({super.key});

  @override
  State<DirPage> createState() => _DirPageState();
}

class _DirPageState extends State<DirPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int axisCount = (width / 80).toInt();

    return ViewModelBuilder<DirViewModel>.reactive(
      viewModelBuilder: () => DirViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.setContext(context);
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: viewModel.clearEditAndChangeNameFolder,
          child: BasePage(
            isBusy: viewModel.isBusy,
            body: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelStyle: const TextStyle(fontSize: 16),
                    indicatorColor: AppColor.navSelected,
                    labelColor: AppColor.navSelected,
                    unselectedLabelColor: AppColor.unSelectedLabel,
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'Chủ sở hữu'),
                      Tab(text: 'Được chia sẻ'),
                      Tab(text: 'Đã chia sẻ'),
                    ],
                    onTap: (_) => viewModel.clearEditAndChangeNameFolder(),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildOwnerView(viewModel, axisCount),
                        _buildSharedView(viewModel, axisCount),
                        _buildSharedFromCustomerView(viewModel, axisCount),
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

  Widget _buildOwnerView(DirViewModel viewModel, int axisCount) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * viewModel.topHeightFraction,
                    child: RefreshIndicator(
                      onRefresh: viewModel.refreshDir,
                      child: _viewOwnerDirectory(viewModel, axisCount),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            'Thiết bị ngoài',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: viewModel.refreshExternalDevices,
                            child:
                                _lineViewExternalDevice(viewModel: viewModel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: constraints.maxHeight * viewModel.topHeightFraction - 10,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) => viewModel.onChangeFraction(
                    details,
                    constraints.maxHeight,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    child: const Stack(
                      children: [
                        Center(child: Divider(height: 0.5)),
                        Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSharedFromCustomerView(DirViewModel viewModel, int axisCount) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * viewModel.topHeightFraction,
                    child: RefreshIndicator(
                      onRefresh: viewModel.refreshDir,
                      child:
                          _viewSharedDirectoryByCustomer(viewModel, axisCount),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            'Thiết bị đã chia sẻ',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: viewModel.refreshSharedDevicesByCustomer,
                            child: _lineViewSharedDeviceByCustomer(viewModel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: constraints.maxHeight * viewModel.topHeightFraction - 10,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) => viewModel.onChangeFraction(
                    details,
                    constraints.maxHeight,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    child: const Stack(
                      children: [
                        Center(child: Divider(height: 0.5)),
                        Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSharedView(DirViewModel viewModel, int axisCount) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * viewModel.topHeightFraction,
                    child: RefreshIndicator(
                      onRefresh: viewModel.refreshDir,
                      child: _viewSharedDirectory(viewModel, axisCount),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            'Thiết bị được chia sẻ',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: viewModel.refreshSharedDevices,
                            child: _lineViewSharedDevice(viewModel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: constraints.maxHeight * viewModel.topHeightFraction - 10,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) => viewModel.onChangeFraction(
                    details,
                    constraints.maxHeight,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    child: const Stack(
                      children: [
                        Center(child: Divider(height: 0.5)),
                        Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.expand_outlined,
                                size: 10,
                                color: AppColor.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _lineViewSharedDevice(DirViewModel viewModel) {
    DeviceViewModel deviceViewModel = DeviceViewModel(
      context: context,
      currentDir: viewModel.defaultDir,
    );

    return Stack(
      children: [
        if (viewModel.listSharedDevices.isEmpty)
          const Center(
            child: Text('Không có thiết bị nào được chia sẻ'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listSharedDevices.length,
          itemBuilder: (context, index) {
            return DeviceCard(
              deviceViewModel: deviceViewModel,
              data: viewModel.listSharedDevices[index],
              dirViewModel: viewModel,
              inDir: false,
              isOwner: false,
              showDir: false,
              dirId: -1,
              onOpenDetailSuccess: viewModel.getSharedDevices,
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewSharedDeviceByCustomer(DirViewModel viewModel) {
    DeviceViewModel deviceViewModel = DeviceViewModel(
      context: context,
      currentDir: viewModel.defaultDir,
    );

    return Stack(
      children: [
        if (viewModel.listSharedDevicesByCustomer.isEmpty)
          const Center(
            child: Text('Không có thiết bị nào đã chia sẻ'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listSharedDevicesByCustomer.length,
          itemBuilder: (context, index) {
            return DeviceCard(
              deviceViewModel: deviceViewModel,
              data: viewModel.listSharedDevicesByCustomer[index],
              dirViewModel: viewModel,
              inDir: false,
              isOwner: false,
              showDir: false,
              dirId: -1,
              onOpenDetailSuccess: viewModel.getSharedDevicesByCustomer,
            );
          },
        ),
      ],
    );
  }

  Widget _lineViewExternalDevice({required DirViewModel viewModel}) {
    DeviceViewModel deviceViewModel = DeviceViewModel(
      context: context,
      currentDir: viewModel.defaultDir,
    );

    return Stack(
      children: [
        if (viewModel.listExternalDevices.isEmpty)
          const Center(
            child: Text('Không có thiết bị ngoài nào'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.listExternalDevices.length,
          itemBuilder: (context, index) {
            return DeviceCard(
              deviceViewModel: deviceViewModel,
              data: viewModel.listExternalDevices[index],
              dirViewModel: viewModel,
              inDir: false,
              isOwner: true,
              dirId: -1,
              onDeleteSuccess: viewModel.getExternalDevices,
              onMovedSuccess: viewModel.onDeviceMovedSuccess,
              onOpenDetailSuccess: viewModel.getExternalDevices,
            );
          },
        ),
      ],
    );
  }

  Widget _viewOwnerDirectory(DirViewModel viewModel, int axisCount) {
    int lengthList = viewModel.listDir.length;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: ((lengthList + 1) / axisCount).ceil(),
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        int startIndex = index * axisCount;
        int endIndex = (startIndex + axisCount).clamp(0, lengthList + 1);
        int mainItemLength = 0;
        List<Widget> listItemInRow = [];

        for (int indexInList = startIndex;
            indexInList < endIndex;
            indexInList++) {
          if (listItemInRow.isNotEmpty) {
            listItemInRow.add(const SizedBox(width: 10));
          }
          if (indexInList >= lengthList) {
            listItemInRow.add(Expanded(child: dirAddCard(context, viewModel)));
          } else {
            listItemInRow.add(Expanded(
                child: dirCard(
              indexInList,
              viewModel,
              viewModel.listDir[indexInList],
              true,
            )));
          }
          mainItemLength += 1;
        }

        if (mainItemLength < axisCount) {
          int loop = axisCount - mainItemLength;
          for (int i = 0; i < loop; i++) {
            if (listItemInRow.isNotEmpty) {
              listItemInRow.add(const SizedBox(width: 10));
            }
            listItemInRow.add(const Expanded(child: SizedBox()));
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listItemInRow,
          ),
        );
      },
    );
  }

  Widget _viewSharedDirectory(DirViewModel viewModel, int axisCount) {
    int lengthList = viewModel.listShareDir.length;

    return Stack(
      children: [
        if (viewModel.listShareDir.isEmpty)
          const Center(
            child: Text('Không có thư mục nào được chia sẻ'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (lengthList / axisCount).ceil(),
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            int startIndex = index * axisCount;
            int endIndex = (startIndex + axisCount).clamp(0, lengthList);
            int mainItemLength = 0;
            List<Widget> listItemInRow = [];

            for (int indexInList = startIndex;
                indexInList < endIndex;
                indexInList++) {
              if (listItemInRow.isNotEmpty) {
                listItemInRow.add(const SizedBox(width: 10));
              }
              listItemInRow.add(Expanded(
                  child: dirCard(
                indexInList,
                viewModel,
                viewModel.listShareDir[indexInList],
                false,
              )));
              mainItemLength += 1;
            }

            if (mainItemLength < axisCount) {
              int loop = axisCount - mainItemLength;
              for (int i = 0; i < loop; i++) {
                if (listItemInRow.isNotEmpty) {
                  listItemInRow.add(const SizedBox(width: 10));
                }
                listItemInRow.add(const Expanded(child: SizedBox()));
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listItemInRow,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _viewSharedDirectoryByCustomer(DirViewModel viewModel, int axisCount) {
    int lengthList = viewModel.listShareDirByCustomer.length;

    return Stack(
      children: [
        if (viewModel.listShareDirByCustomer.isEmpty)
          const Center(
            child: Text('Không có thư mục nào đã chia sẻ'),
          ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (lengthList / axisCount).ceil(),
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            int startIndex = index * axisCount;
            int endIndex = (startIndex + axisCount).clamp(0, lengthList);
            int mainItemLength = 0;
            List<Widget> listItemInRow = [];

            for (int indexInList = startIndex;
                indexInList < endIndex;
                indexInList++) {
              if (listItemInRow.isNotEmpty) {
                listItemInRow.add(const SizedBox(width: 10));
              }
              listItemInRow.add(Expanded(
                  child: dirCard(
                indexInList,
                viewModel,
                viewModel.listShareDirByCustomer[indexInList],
                true,
              )));
              mainItemLength += 1;
            }

            if (mainItemLength < axisCount) {
              int loop = axisCount - mainItemLength;
              for (int i = 0; i < loop; i++) {
                if (listItemInRow.isNotEmpty) {
                  listItemInRow.add(const SizedBox(width: 10));
                }
                listItemInRow.add(const Expanded(child: SizedBox()));
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listItemInRow,
              ),
            );
          },
        ),
      ],
    );
  }

  InkWell dirAddCard(BuildContext context, DirViewModel vm) {
    return InkWell(
      onTap: () => vm.changeEditingFolderName(!vm.isEditingFolderName),
      child: Column(
        children: [
          Image.asset(
            'assets/images/img_folder_add.png',
          ),
          vm.isEditingFolderName
              ? TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 5, right: 5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffFABD1D),
                      ),
                    ),
                  ),
                  controller: vm.folderNameController,
                  focusNode: vm.folderNameFocusNode,
                  onSubmitted: (_) => vm.onCreateNewFolderTaped(),
                  style: const TextStyle(
                    color: Color(0xff797979),
                    fontSize: 12,
                  ),
                )
              : const Text(
                  'Tạo thư mục',
                  style: TextStyle(color: Color(0xff797979), fontSize: 12),
                ),
        ],
      ),
    );
  }

  InkWell dirCard(int index, DirViewModel viewModel, Dir dir, bool isOwner) {
    return InkWell(
      onTap: () {
        viewModel.currentDir = dir;
        viewModel.openDevicePage();
      },
      onLongPress: isOwner
          ? () => viewModel.changeChangeFolderName(
                !viewModel.isChangeFolderName,
                idFolder: dir.dirId,
              )
          : null,
      child: Column(
        children: [
          Image.asset(
            isOwner
                ? 'assets/images/img_folder_owner.png'
                : 'assets/images/img_folder_share.png',
          ),
          viewModel.isChangeFolderName &&
                  viewModel.idFolderChangeName == dir.dirId
              ? TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 5, right: 5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffFABD1D),
                      ),
                    ),
                  ),
                  controller: viewModel.changeFolderNameController,
                  focusNode: viewModel.changeFolderNameFocusNode,
                  onSubmitted: (_) => viewModel.onUpdateFolderTaped(),
                  style: const TextStyle(
                    color: Color(0xff797979),
                    fontSize: 12,
                  ),
                )
              : Text(
                  dir.dirName ?? '',
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Color(0xff797979), fontSize: 12),
                ),
        ],
      ),
    );
  }
}
