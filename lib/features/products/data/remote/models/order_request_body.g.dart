// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestBody _$OrderRequestBodyFromJson(Map<String, dynamic> json) =>
    OrderRequestBody(
      contactId: (json['contact_id'] as num?)?.toInt(),
      transactionDate: json['transaction_date'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$OrderRequestBodyToJson(OrderRequestBody instance) =>
    <String, dynamic>{
      'contact_id': instance.contactId,
      'transaction_date': instance.transactionDate,
      'products': instance.products,
      'notes': instance.notes,
    };

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
    };
