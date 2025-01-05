// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      stock: json['stock'] as String,
      reorderPoint: json['reorder_point'] as String,
      sellingPrice: json['selling_price'] as String,
      costPrice: json['cost_price'] as String,
      image: json['image'] as String?,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'stock': instance.stock,
      'reorder_point': instance.reorderPoint,
      'selling_price': instance.sellingPrice,
      'cost_price': instance.costPrice,
      'image': instance.image,
      'category': instance.category,
      'orders': instance.orders,
    };
