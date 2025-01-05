import 'package:json_annotation/json_annotation.dart';

import '../../../../products/data/remote/models/order_model.dart';
import '../../../domain/entities/history_entity.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  final int id;
  @JsonKey(name: 'contact_id')
  final int? contactId;
  @JsonKey(name: 'transaction_date')
  final String transactionDate;
  final String? notes;
  final dynamic contact;
  final List<ProductWithPivotModel> products;

  HistoryModel({
    required this.id,
    this.contactId,
    required this.transactionDate,
    this.notes,
    required this.contact,
    required this.products,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

  HistoryEntity toEntity() => HistoryEntity(
        id: id,
        contactId: contactId,
        transactionDate: transactionDate,
        notes: notes,
        contact: contact,
        products: products.map((product) => product.toEntity()).toList(),
      );
}

@JsonSerializable()
class ProductWithPivotModel {
  final int id;
  final String name;
  final String sku;
  final String stock;
  @JsonKey(name: 'reorder_point')
  final String reorderPoint;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'selling_price')
  final String sellingPrice;
  @JsonKey(name: 'cost_price')
  final String costPrice;
  final String? image;
  @JsonKey(name: 'user_id')
  final int userId;
  final PivotModel pivot;

  ProductWithPivotModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.stock,
    required this.reorderPoint,
    required this.categoryId,
    required this.sellingPrice,
    required this.costPrice,
    this.image,
    required this.userId,
    required this.pivot,
  });

  factory ProductWithPivotModel.fromJson(Map<String, dynamic> json) =>
      _$ProductWithPivotModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductWithPivotModelToJson(this);

  ProductWithPivotEntity toEntity() => ProductWithPivotEntity(
        id: id,
        name: name,
        sku: sku,
        stock: stock,
        reorderPoint: reorderPoint,
        categoryId: categoryId,
        sellingPrice: sellingPrice,
        costPrice: costPrice,
        image: image,
        userId: userId,
        pivot: pivot.toEntity(),
      );
}
