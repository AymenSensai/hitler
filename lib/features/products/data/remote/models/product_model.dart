import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_entity.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String name;
  final String sku;
  @JsonKey(name: 'opening_stock')
  final int openingStock;
  @JsonKey(name: 'reorder_point')
  final int reorderPoint;
  final String category;
  @JsonKey(name: 'selling_price')
  final String sellingPrice;
  @JsonKey(name: 'cost_price')
  final String costPrice;
  final String image;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        sku: sku,
        openingStock: openingStock,
        reorderPoint: reorderPoint,
        category: category,
        sellingPrice: sellingPrice,
        costPrice: costPrice,
        image: image,
      );

  static ProductModel fromEntity(ProductEntity product) => ProductModel(
        id: product.id,
        name: product.name,
        sku: product.sku,
        openingStock: product.openingStock,
        reorderPoint: product.reorderPoint,
        category: product.category,
        sellingPrice: product.sellingPrice,
        costPrice: product.costPrice,
        image: product.image,
      );
}
