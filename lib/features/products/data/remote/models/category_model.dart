import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stocks_app/features/products/domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int? id;
  final String name;

  CategoryModel({
    this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id.toString(),
      name: name,
    );
  }
}
