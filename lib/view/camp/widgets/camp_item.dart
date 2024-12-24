import 'package:flutter/material.dart';

import '../../../app/utils.dart';
import '../../../constants/app_color.dart';
import '../../../models/camp/camp_model.dart';
import '../../../view/camp/widgets/camp_line_action.dart';

class CampItem extends StatelessWidget {
  final CampModel data;
  final ValueChanged<CampModel> onEditTap;
  final ValueChanged<CampModel>? onCloningTap;
  final ValueChanged<CampModel>? onDeleteTap;
  final ValueChanged<CampModel> onHistoryTap;

  CampItem({
    super.key,
    required this.data,
    this.onCloningTap,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onHistoryTap,
  });

  final GlobalKey<PopupMenuButtonState> _menuKey =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Listener(
        onPointerDown: (PointerEvent event) {
          if (event.buttons == 2) {
            _menuKey.currentState?.showButtonMenu();
          }
        },
        child: InkWell(
          onTap: () => onEditTap.call(data),
          onDoubleTap:
              onCloningTap != null ? () => onCloningTap?.call(data) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: data.campaignName ?? ''),
                                TextSpan(
                                  text:
                                      ' (${convertTimeString2(data.fromDate)} - ${convertTimeString2(data.toDate)})',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Trạng thái: ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: data.approvedYn == '1'
                                      ? data.status == '1'
                                          ? 'đang chạy'
                                          : 'đã tắt'
                                      : data.approvedYn == '-1'
                                          ? 'Từ chối duyệt'
                                          : 'Chờ duyệt',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: data.approvedYn == '1'
                                        ? data.status == '1'
                                            ? Colors.green
                                            : Colors.red
                                        : data.approvedYn == '-1'
                                            ? Colors.red
                                            : AppColor.appBarEnd,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton(
                      key: _menuKey,
                      onSelected: onMenuTaped,
                      tooltip: 'Tùy chọn',
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<int>>[
                          const PopupMenuItem(
                            value: 0,
                            child: CampLineAction(
                              title: 'Lịch sử',
                              mainAxisAlignment: MainAxisAlignment.start,
                              leadingIconString: 'assets/images/ic_history.png',
                            ),
                          ),
                          const PopupMenuItem(
                            value: 1,
                            child: CampLineAction(
                              title: 'Sửa',
                              mainAxisAlignment: MainAxisAlignment.start,
                              leadingIconString: 'assets/images/ic_pensil.png',
                            ),
                          ),
                          if (onCloningTap != null)
                            const PopupMenuItem(
                              value: 2,
                              child: CampLineAction(
                                title: 'Nhân bản',
                                mainAxisAlignment: MainAxisAlignment.start,
                                leadingIconString:
                                    'assets/images/ic_cloning.png',
                              ),
                            ),
                          const PopupMenuItem(
                            value: 3,
                            child: CampLineAction(
                              title: 'Xóa',
                              mainAxisAlignment: MainAxisAlignment.start,
                              leadingIconString:
                                  'assets/images/ic_recycle_bin.png',
                            ),
                          ),
                        ];
                      },
                      icon: const Icon(
                        Icons.menu,
                        size: 20,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0.5),
            ],
          ),
        ),
      ),
    );
  }

  void onMenuTaped(int value) {
    switch (value) {
      case 0:
        onHistoryTap.call(data);
        break;
      case 1:
        onEditTap.call(data);
        break;
      case 2:
        onCloningTap?.call(data);
        break;
      case 3:
        onDeleteTap?.call(data);
        break;
      default:
        break;
    }
  }
}
