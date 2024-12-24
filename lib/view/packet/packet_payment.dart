import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/utils.dart';
import '../../constants/app_color.dart';
import '../../models/packet/my_packet_model.dart';
import '../../models/packet/packet_model.dart';
import '../../view_models/packet.vm.dart';
import '../../widget/base_page.dart';
import '../../widget/button_custom.dart';

class PacketPaymentPage extends StatefulWidget {
  final PacketModel? packet;
  final MyPacketModel? myPacket;
  final PacketViewModel packetViewModel;

  const PacketPaymentPage({
    super.key,
    this.packet,
    this.myPacket,
    required this.packetViewModel,
  });

  @override
  State<PacketPaymentPage> createState() => _PacketPaymentPageState();
}

class _PacketPaymentPageState extends State<PacketPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PacketViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.packetViewModel,
        builder: (context, viewModel, child) {
          return BasePage(
            showAppBar: true,
            title: 'Thanh toán',
            showLeadingAction: true,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTopBadge(
                      packet: widget.packet, myPacket: widget.myPacket),
                  DefaultTabController(
                    initialIndex: 0,
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColor.bgTimeBox,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(4),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: AppColor.navSelected,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            labelColor: AppColor.white,
                            labelStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            unselectedLabelColor: AppColor.unSelectedLabel2,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: 'Thanh toán online'),
                              Tab(text: 'Chuyển khoản'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildTransferPayment(),
                              _buildTransferPayment(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: ButtonCustom(
              onPressed: () => viewModel.onPaymentTaped(
                packet: widget.packet,
                myPacket: widget.myPacket,
              ),
              height: 65,
              title: 'Gửi đi',
              textSize: 22,
              borderRadius: 0,
            ),
          );
        });
  }

  Widget _buildTopBadge({PacketModel? packet, MyPacketModel? myPacket}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Image.asset(
            'assets/images/img_package.png',
            height: 120,
            width: 120,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gói cước ${myPacket?.namePacket ?? packet?.namePacket ?? ''}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
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
                          )),
                      TextSpan(
                        text:
                            '${myPacket?.monthQty ?? packet?.monthQty ?? ''} tháng',
                      ),
                    ],
                  ),
                ),
                Text(
                  '${formatNumber(myPacket?.price ?? packet?.price)}đ',
                  style: const TextStyle(color: AppColor.navSelected),
                ),
                Text(myPacket?.detail ?? packet?.detail ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferPayment() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                transferText(title: "Chủ tài khoản", data: ""),
                transferText(title: "Số tài khoản", data: ""),
                transferText(title: "Ngân hàng", data: ""),
                transferText(title: "Chi nhánh", data: ""),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  RichText transferText({required String title, required String data}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18.0,
          color: AppColor.black,
        ),
        children: [
          TextSpan(
            text: '$title: ',
            style: const TextStyle(
              fontSize: 18.0,
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: data,
          ),
        ],
      ),
    );
  }
}
