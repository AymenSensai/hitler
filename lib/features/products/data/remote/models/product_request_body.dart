import 'dart:io';

class ProductRequestBody {
  final int? id;
  final String name;
  final String sku;
  final int stock;
  final int reorderPoint;
  final String category;
  final String sellingPrice;
  final String costPrice;
  final File image;

  ProductRequestBody({
    this.id,
    required this.name,
    required this.sku,
    required this.stock,
    required this.reorderPoint,
    required this.category,
    required this.sellingPrice,
    required this.costPrice,
    required this.image,
  });
}
