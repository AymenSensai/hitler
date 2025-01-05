// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: (json['id'] as num).toInt(),
      contactId: (json['contact_id'] as num?)?.toInt(),
      transactionDate: json['transaction_date'] as String,
      notes: json['notes'] as String?,
      contact: json['contact'],
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductWithPivotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contact_id': instance.contactId,
      'transaction_date': instance.transactionDate,
      'notes': instance.notes,
      'contact': instance.contact,
      'products': instance.products,
    };

ProductWithPivotModel _$ProductWithPivotModelFromJson(
        Map<String, dynamic> json) =>
    ProductWithPivotModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      stock: json['stock'] as String,
      reorderPoint: json['reorder_point'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      sellingPrice: json['selling_price'] as String,
      costPrice: json['cost_price'] as String,
      image: json['image'] as String?,
      userId: (json['user_id'] as num).toInt(),
      pivot: PivotModel.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductWithPivotModelToJson(
        ProductWithPivotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'stock': instance.stock,
      'reorder_point': instance.reorderPoint,
      'category_id': instance.categoryId,
      'selling_price': instance.sellingPrice,
      'cost_price': instance.costPrice,
      'image': instance.image,
      'user_id': instance.userId,
      'pivot': instance.pivot,
    };
