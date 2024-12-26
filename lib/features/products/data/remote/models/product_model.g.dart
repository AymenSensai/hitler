// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      openingStock: (json['opening_stock'] as num).toInt(),
      reorderPoint: (json['reorder_point'] as num).toInt(),
      category: json['category'] as String,
      sellingPrice: json['selling_price'] as String,
      costPrice: json['cost_price'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'opening_stock': instance.openingStock,
      'reorder_point': instance.reorderPoint,
      'category': instance.category,
      'selling_price': instance.sellingPrice,
      'cost_price': instance.costPrice,
    };
