import '../../../products/domain/entities/order_entity.dart';
import 'package:intl/intl.dart';

class HistoryEntity {
  final int id;
  final int? contactId;
  final String transactionDate;
  final String? notes;
  final dynamic contact;
  final List<ProductWithPivotEntity> products;

  HistoryEntity({
    required this.id,
    this.contactId,
    required this.transactionDate,
    this.notes,
    required this.contact,
    required this.products,
  });

  String get formattedTransactionDate {
    final date = DateTime.parse(transactionDate);
    return DateFormat('dd MMM yyyy').format(date);
  }
}

class ProductWithPivotEntity {
  final int id;
  final String name;
  final String sku;
  final String stock;
  final String reorderPoint;
  final int categoryId;
  final String sellingPrice;
  final String costPrice;
  final String? image;
  final int userId;
  final PivotEntity pivot;

  ProductWithPivotEntity({
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
}
