class ActiveOrderClass {
  String orderCode;
  DateTime date;
  List<DetailActiveOrderClass> detailOrder;
  int total;
  String paymentMethod;
  String? receipent;
  String? address;
  bool status;

  ActiveOrderClass({
    required this.orderCode,
    required this.date,
    required this.detailOrder,
    required this.total,
    required this.paymentMethod,
    this.receipent,
    this.address,
    required this.status,
  });
}

class DetailActiveOrderClass {
  String productName;
  String productUOM;
  int productPrice;
  String imgPath;
  int qty;
  int subtotal;

  DetailActiveOrderClass({
    required this.productName,
    required this.productUOM,
    required this.productPrice,
    required this.imgPath,
    required this.qty,
    required this.subtotal
  });
}