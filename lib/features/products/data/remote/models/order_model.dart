import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;
  @JsonKey(name: 'contact_id')
  final int? contactId;
  @JsonKey(name: 'transaction_date')
  final String transactionDate;
  final String? notes;
  final PivotModel pivot;

  OrderModel({
    required this.id,
    this.contactId,
    required this.transactionDate,
    this.notes,
    required this.pivot,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toEntity() => OrderEntity(
        id: id,
        contactId: contactId,
        transactionDate: transactionDate,
        notes: notes,
        pivot: pivot.toEntity(),
      );

  static OrderModel fromEntity(OrderEntity order) => OrderModel(
        id: order.id,
        contactId: order.contactId,
        transactionDate: order.transactionDate,
        notes: order.notes,
        pivot: PivotModel(
          productId: order.pivot.productId,
          orderId: order.pivot.orderId,
          quantity: order.pivot.quantity,
        ),
      );
}

@JsonSerializable()
class PivotModel {
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'order_id')
  final int orderId;
  final int quantity;

  PivotModel({
    required this.productId,
    required this.orderId,
    required this.quantity,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) =>
      _$PivotModelFromJson(json);

  Map<String, dynamic> toJson() => _$PivotModelToJson(this);

  PivotEntity toEntity() => PivotEntity(
        productId: productId,
        orderId: orderId,
        quantity: quantity,
      );
}
