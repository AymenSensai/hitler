import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stocks_app/features/products/data/remote/models/category_model.dart';

import '../../../domain/entities/product_entity.dart';
import 'order_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String name;
  final String sku;
  @JsonKey(name: 'stock')
  final int stock;
  @JsonKey(name: 'reorder_point')
  final int reorderPoint;
  @JsonKey(name: 'selling_price')
  final String sellingPrice;
  @JsonKey(name: 'cost_price')
  final String costPrice;
  final String? image;
  final CategoryModel category;
  final List<OrderModel> orders;

  ProductModel({
    this.id,
    required this.name,
    required this.sku,
    required this.stock,
    required this.reorderPoint,
    required this.sellingPrice,
    required this.costPrice,
    required this.image,
    required this.category,
    required this.orders,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        sku: sku,
        stock: stock.toString(),
        reorderPoint: reorderPoint.toString(),
        sellingPrice: sellingPrice,
        costPrice: costPrice,
        image: image,
        category: category.toEntity(),
        orders: orders.map((order) => order.toEntity()).toList(),
      );

  static ProductModel fromEntity(ProductEntity product) => ProductModel(
        id: product.id,
        name: product.name,
        sku: product.sku,
        stock: int.parse(product.stock),
        reorderPoint: int.parse(product.reorderPoint),
        sellingPrice: product.sellingPrice,
        costPrice: product.costPrice,
        image: product.image,
        category: CategoryModel.fromEntity(product.category),
        orders: product.orders
            .map((order) => OrderModel.fromEntity(order))
            .toList(),
      );
}
