import 'package:stocks_app/features/contacts/domain/entities/contact_entity.dart';

sealed class StockState<T> {}

class StockInitial<T> extends StockState<T> {}

class GetStockContactsLoading<T> extends StockState<T> {}

class GetStockContactsSuccess<T> extends StockState<T> {
  final List<ContactEntity> contacts;
  GetStockContactsSuccess({required this.contacts});
}

class GetStockContactsError<T> extends StockState<T> {
  final String? error;
  GetStockContactsError({required this.error});
}

class UpdateStockLoading<T> extends StockState<T> {}

class UpdateStockSuccess<T> extends StockState<T> {}

class UpdateStockError<T> extends StockState<T> {
  final String? error;
  UpdateStockError({required this.error});
}
