import 'package:flutter/material.dart';

import '../../../app/utils.dart';
import '../../../constants/app_color.dart';
import '../../../models/resource/resource_model.dart';

class ResourceItem extends StatelessWidget {
  final ResourceModel data;
  final bool fromEditCamp;
  final ValueChanged<String>? onDeleteTap;
  final ValueChanged<ResourceModel>? onCopyTap;
  final Function(String?, bool)? onItemTap;

  const ResourceItem({
    super.key,
    required this.data,
    this.fromEditCamp = false,
    this.onDeleteTap,
    this.onCopyTap,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: InkWell(
        onTap: () => onItemTap?.call(data.fileUrl, data.fileType == 'image'),
        child: Column(
          children: [
            Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/img_${data.fileType}.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            'Định dạng: ${data.fileType == 'image' ? 'Ảnh' : 'Video'}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.unSelectedLabel2,
                            ),
                          ),
                          Text(
                            'Kích thước: ${formatBytes(data.fileSize)}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.unSelectedLabel2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => onCopyTap?.call(data),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                      child: SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              fromEditCamp ? 'Xem trước' : 'Sao chép\nliên kết',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColor.unSelectedLabel2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColor.bgDir,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onDeleteTap?.call(data.fileName),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: const Center(
                              child: Text(
                                'Xóa',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0.5,
              color: AppColor.navSelected,
            ),
          ],
        ),
      ),
    );
  }
}
