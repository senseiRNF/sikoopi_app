import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';

class HistoryClasses {
  final int id;
  final String orderDate;
  final String receiverName;
  final String address;
  final List<CartClasses> historyList;

  const HistoryClasses({
    required this.id,
    required this.orderDate,
    required this.receiverName,
    required this.address,
    required this.historyList,
  });
}