import 'package:intl/intl.dart';

class OrderEntity {
  final int id;
  final int? contactId;
  final String transactionDate;
  final String? notes;
  final PivotEntity pivot;

  OrderEntity({
    required this.id,
    this.contactId,
    required this.transactionDate,
    this.notes,
    required this.pivot,
  });

  String get formattedTransactionDate {
    final date = DateTime.parse(transactionDate);
    return DateFormat('dd MMM yyyy').format(date);
  }
}

class PivotEntity {
  final int productId;
  final int orderId;
  final int quantity;

  PivotEntity({
    required this.productId,
    required this.orderId,
    required this.quantity,
  });
}
