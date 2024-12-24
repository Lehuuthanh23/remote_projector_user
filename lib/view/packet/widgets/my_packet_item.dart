import 'package:flutter/material.dart';

import '../../../app/utils.dart';
import '../../../models/packet/my_packet_model.dart';

class MyPackageItem extends StatelessWidget {
  final MyPacketModel data;
  final ValueChanged<MyPacketModel>? onRenewalTap;
  final ValueChanged<String?>? onCancelTap;

  const MyPackageItem({
    super.key,
    required this.data,
    this.onRenewalTap,
    this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/img_package.png",
                          height: 120,
                          width: 120,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 10),
                          child: Image.asset(
                            'assets/images/ic_${data.deleted != 'y' ? 'checked_${isDatePast(data.expireDate) ? 'disable' : 'enable'}' : 'cancel'}.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gói cước ${data.namePacket}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Thời hạn: ',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "${data.monthQty} tháng",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${formatNumber(data.price)}đ',
                        style: const TextStyle(color: Color(0xffEB6E2C)),
                      ),
                      Text(
                        data.detail ?? '',
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Ngày hiệu lực: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: convertTimeString2(data.validDate) ??
                                'chưa kích hoạt',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Ngày kết thúc: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: convertTimeString2(data.expireDate) ??
                                'chưa kích hoạt',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (data.deleted != 'y')
                  Material(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isDatePast(data.expireDate))
                          InkWell(
                            onTap: () => onRenewalTap?.call(data),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Gia hạn gói cước',
                                    style: TextStyle(
                                      color: Color(0xff027800),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Image.asset("assets/images/ic_pay.png"),
                                ],
                              ),
                            ),
                          ),
                        InkWell(
                          onTap: () => onCancelTap?.call(data.paidId),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Hủy gói cước',
                              style: TextStyle(
                                color: Color(0xffff0000),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
