class TransactionClasses {
  int? id;
  int? userId;
  String? username;
  DateTime? date;
  int? total;
  String? payment;
  String? receipent;
  String? address;
  String? status;
  String? transferReceiptImage;
  bool? isActive;

  TransactionClasses({
    this.id,
    this.userId,
    this.username,
    this.date,
    this.total,
    this.payment,
    this.receipent,
    this.address,
    this.status,
    this.transferReceiptImage,
    this.isActive,
  });
}