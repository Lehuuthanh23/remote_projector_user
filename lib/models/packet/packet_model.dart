class PacketModel {
  String? packetId;
  String? namePacket;
  String? price;
  String? monthQty;
  String? detail;
  String? description;
  String? picture;
  String? expireDate;

  PacketModel({
    this.packetId,
    this.namePacket,
    this.price,
    this.monthQty,
    this.detail,
    this.description,
    this.picture,
    this.expireDate,
  });

  factory PacketModel.fromJson(Map<String, dynamic> json) {
    return PacketModel(
      packetId: json['packet_id'],
      namePacket: json['name_packet'],
      price: json['price'],
      monthQty: json['month_qty'],
      expireDate: json['expire_date'],
      description: json['description'],
      picture: 'picture',
      detail: json['detail'].trim(),
    );
  }
}
