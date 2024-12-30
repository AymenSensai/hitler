import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  final String message;
  final List<CategoryModel> data;

  CategoriesResponse({
    required this.message,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
