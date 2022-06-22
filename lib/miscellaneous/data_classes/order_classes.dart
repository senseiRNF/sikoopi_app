class ActiveOrderClass {
  String? orderCode;
  DateTime? date;
  List<DetailActiveOrderClass>? detailOrder;
  int? total;
  String? paymentMethod;
  String? receipent;
  String? address;
  bool? status;

  ActiveOrderClass({
    this.orderCode,
    this.date,
    this.detailOrder,
    this.total,
    this.paymentMethod,
    this.receipent,
    this.address,
    this.status,
  });
}

class DetailActiveOrderClass {
  String? productName;
  String? productUOM;
  int? productPrice;
  String? imgPath;
  int? qty;
  int? subtotal;

  DetailActiveOrderClass({
    this.productName,
    this.productUOM,
    this.productPrice,
    this.imgPath,
    this.qty,
    this.subtotal
  });
}