class ProductEntity {
  final int? id;
  final String name;
  final String sku;
  final int openingStock;
  final int reorderPoint;
  final String category;
  final String sellingPrice;
  final String costPrice;
  final String image;

  ProductEntity({
    this.id,
    required this.name,
    required this.sku,
    required this.openingStock,
    required this.reorderPoint,
    required this.category,
    required this.sellingPrice,
    required this.costPrice,
    required this.image,
  });
}
