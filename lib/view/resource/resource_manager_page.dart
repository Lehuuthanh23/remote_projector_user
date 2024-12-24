import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/utils.dart';
import '../../constants/app_color.dart';
import '../../view_models/resource_manager.vm.dart';
import '../../widget/base_page.dart';
import 'widget/file_picker_item.dart';
import 'widget/resource_item.dart';

class ResourceManagerPage extends StatefulWidget {
  final ValueChanged<String>? onChoseSuccess;

  const ResourceManagerPage({super.key, this.onChoseSuccess});

  @override
  State<ResourceManagerPage> createState() => _ResourceManagerPageState();
}

class _ResourceManagerPageState extends State<ResourceManagerPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResourceMangerViewModel>.reactive(
      viewModelBuilder: () => ResourceMangerViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.setContext(context);
        viewModel.setChoseSuccess(widget.onChoseSuccess);
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return PopScope(
          canPop: !viewModel.isUploading,
          child: BasePage(
            isBusy: viewModel.isBusy,
            showAppBar: true,
            showLeadingAction: true,
            title: 'Quản lý tài nguyên'.toUpperCase(),
            onBackPressed: () {
              if (!viewModel.isUploading) {
                Navigator.pop(context);
              }
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildMyFilePicker(viewModel),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: _buildFileResourceUploaded(viewModel),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMyFilePicker(ResourceMangerViewModel viewModel) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (viewModel.listFilePicker.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                color: AppColor.bgDir,
              ),
              height: 40,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'File đã chọn',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (viewModel.listFilePicker.length > 1 &&
                      viewModel.listFilePicker
                          .where((item) => item.cancelToken != null)
                          .isEmpty)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: viewModel.onUploadAllFileTaped,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                'Tải lên tất cả',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.unSelectedLabel2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                padding: const EdgeInsets.only(left: 5),
                                child: Image.asset(
                                  'assets/images/ic_upload.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else if (viewModel.listFilePicker
                      .where((item) => item.cancelToken != null)
                      .isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Đang tải lên',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              ),
            ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.bgDir,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        (MediaQuery.of(context).size.height > 13 * 60 ? 3 : 2) *
                            60,
                  ),
                  child: ListView.builder(
                    itemCount: viewModel.listFilePicker.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FilePickerItem(
                        data: viewModel.listFilePicker[index],
                        onDeleteTap: viewModel.onDeleteFilePickerTaped,
                        onUploadTap: viewModel.onUploadSingleFileTaped,
                        onItemTap: (path, isImage) {
                          if (path != null) {
                            viewModel.toReviewPage(path, 1, isImage);
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: viewModel.onAddVideoFromStorageTaped,
                          child: const Center(
                            child: Text(
                              'Chọn thêm video',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.unSelectedLabel2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: viewModel.onAddImagesFromStorageTaped,
                          child: const Center(
                            child: Text(
                              'Chọn thêm ảnh',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.unSelectedLabel2,
                                fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _buildFileResourceUploaded(ResourceMangerViewModel viewModel) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColor.bgDir,
          ),
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Image.asset(
                'assets/images/img_folder_owner.png',
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Thư mục của tôi',
                  style: TextStyle(
                    color: AppColor.navUnSelect,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                formatBytes(viewModel.totalSizeFolder),
                style: const TextStyle(
                  color: AppColor.navUnSelect,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: viewModel.refreshResourceFileFromFolder,
            child: ListView.builder(
              itemCount: viewModel.listResource.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ResourceItem(
                  data: viewModel.listResource[index],
                  fromEditCamp: widget.onChoseSuccess != null,
                  onCopyTap: (data) {
                    if (widget.onChoseSuccess != null) {
                      viewModel.toReviewPage(
                        data.fileUrl,
                        2,
                        data.fileType == 'image',
                      );
                    } else {
                      copyToClipboard(data.fileUrl, context);
                    }
                  },
                  onDeleteTap: viewModel.onDeleteFileResourceTaped,
                  onItemTap: (path, isImage) {
                    if (path != null) {
                      if (widget.onChoseSuccess != null) {
                        if (!viewModel.isUploading) {
                          widget.onChoseSuccess!.call(path);
                          Navigator.pop(context);
                        }
                      } else {
                        viewModel.toReviewPage(path, 2, isImage);
                      }
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
