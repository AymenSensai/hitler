import 'package:stocks_app/features/products/domain/entities/order_entity.dart';
import 'package:stocks_app/features/products/domain/entities/category_entity.dart';

class ProductEntity {
  final int? id;
  final String name;
  final String sku;
  final String stock;
  final String reorderPoint;
  final String sellingPrice;
  final String costPrice;
  final String? image;
  final CategoryEntity category;
  final List<OrderEntity> orders;

  ProductEntity({
    this.id,
    required this.name,
    required this.sku,
    required this.stock,
    required this.reorderPoint,
    required this.sellingPrice,
    required this.costPrice,
    required this.image,
    required this.category,
    required this.orders,
  });

  List<Map<String, dynamic>> getSalesData() {
    final sales = orders.where((order) => order.pivot.quantity < 0).toList();

    final Map<String, int> salesPerDate = {};
    for (var sale in sales) {
      final date = sale.transactionDate.split(' ')[0];
      salesPerDate[date] =
          (salesPerDate[date] ?? 0) + sale.pivot.quantity.abs();
    }

    return salesPerDate.entries
        .map((entry) => {'date': entry.key, 'quantity': entry.value})
        .toList();
  }
}
