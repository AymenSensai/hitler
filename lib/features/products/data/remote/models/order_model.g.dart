// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: (json['id'] as num).toInt(),
      contactId: (json['contact_id'] as num?)?.toInt(),
      transactionDate: json['transaction_date'] as String,
      notes: json['notes'] as String?,
      pivot: PivotModel.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contact_id': instance.contactId,
      'transaction_date': instance.transactionDate,
      'notes': instance.notes,
      'pivot': instance.pivot,
    };

PivotModel _$PivotModelFromJson(Map<String, dynamic> json) => PivotModel(
      productId: (json['product_id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$PivotModelToJson(PivotModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'order_id': instance.orderId,
      'quantity': instance.quantity,
    };
