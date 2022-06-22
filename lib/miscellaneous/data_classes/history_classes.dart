import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';

class HistoryClasses {
  int id;
  String orderDate;
  String receiverName;
  String address;
  List<CartClasses> historyList;

  HistoryClasses({
    required this.id,
    required this.orderDate,
    required this.receiverName,
    required this.address,
    required this.historyList,
  });
}