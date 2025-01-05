// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      soldQuantities: (json['sold_quantities'] as num).toInt(),
      purchasedQuantities: (json['purchased_quantities'] as num).toInt(),
      earnings: json['earnings'] as String,
      spendings: json['spendings'] as String,
      productCount: (json['product_count'] as num).toInt(),
      contactCount: (json['contact_count'] as num).toInt(),
      salesData: Map<String, int>.from(json['sales_data'] as Map),
      purchaseData: Map<String, int>.from(json['purchase_data'] as Map),
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'sold_quantities': instance.soldQuantities,
      'purchased_quantities': instance.purchasedQuantities,
      'earnings': instance.earnings,
      'spendings': instance.spendings,
      'product_count': instance.productCount,
      'contact_count': instance.contactCount,
      'sales_data': instance.salesData,
      'purchase_data': instance.purchaseData,
    };
