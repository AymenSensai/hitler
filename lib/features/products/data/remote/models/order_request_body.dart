import 'package:json_annotation/json_annotation.dart';

part 'order_request_body.g.dart';

@JsonSerializable()
class OrderRequestBody {
  @JsonKey(name: 'contact_id')
  final int? contactId;
  @JsonKey(name: 'transaction_date')
  final String transactionDate;
  final List<OrderProductModel> products;
  final String? notes;

  OrderRequestBody({
    this.contactId,
    required this.transactionDate,
    required this.products,
    this.notes,
  });

  factory OrderRequestBody.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestBodyToJson(this);
}

@JsonSerializable()
class OrderProductModel {
  final int id;
  final int quantity;

  OrderProductModel({
    required this.id,
    required this.quantity,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}
