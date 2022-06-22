class ProductClasses {
  int? id;
  String name;
  String uom;
  int price;
  String imagePath;
  bool isActive;
  
  ProductClasses({
    this.id,
    required this.name,
    required this.uom,
    required this.price,
    required this.imagePath,
    required this.isActive,
  });
}