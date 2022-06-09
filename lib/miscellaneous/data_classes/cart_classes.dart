class CartClasses {
  final int id;
  final String name;
  final String uom;
  final int price;
  final String imagePath;
  int totalQty;

  CartClasses({
    required this.id,
    required this.name,
    required this.uom,
    required this.price,
    required this.imagePath,
    required this.totalQty,
  });
}