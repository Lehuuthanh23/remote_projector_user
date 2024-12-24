import 'package:flutter/material.dart';

import '../../../app/utils.dart';
import '../../../models/packet/packet_model.dart';

class PackageItem extends StatelessWidget {
  final PacketModel data;
  final String buttonLabel;
  final Widget? badgeImage;
  final bool showExpireDate;
  final ValueChanged<PacketModel>? onBuyTap;

  const PackageItem({
    super.key,
    required this.data,
    required this.buttonLabel,
    this.showExpireDate = false,
    this.badgeImage,
    this.onBuyTap,
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
                Image.asset(
                  "assets/images/img_package.png",
                  height: 120,
                  width: 120,
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
                if (showExpireDate) Text('Thời hạn: ${data.expireDate}'),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onBuyTap?.call(data),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            buttonLabel,
                            style: const TextStyle(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
