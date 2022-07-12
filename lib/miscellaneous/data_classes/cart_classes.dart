class CartClasses {
  int? id;
  String? name;
  String? uom;
  int? price;
  int stock;
  String? imagePath;
  int? totalQty;
  int? sellCount;

  CartClasses({
    this.id,
    this.name,
    this.uom,
    this.price,
    required this.stock,
    this.imagePath,
    this.totalQty,
    this.sellCount,
  });
}