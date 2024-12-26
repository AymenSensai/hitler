import 'package:json_annotation/json_annotation.dart';

import 'product_model.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  final String message;
  final List<ProductModel> data;

  ProductsResponse({
    required this.message,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
