import '../../domain/entities/history_entity.dart';

sealed class HistoryState<T> {}

class HistoryInitial<T> extends HistoryState<T> {}

class GetOrdersLoading<T> extends HistoryState<T> {}

class GetOrdersSuccess<T> extends HistoryState<T> {
  final List<HistoryEntity> orders;
  GetOrdersSuccess({required this.orders});
}

class GetOrdersError<T> extends HistoryState<T> {
  final String? error;
  GetOrdersError({required this.error});
}

class DeleteOrdersLoading<T> extends HistoryState<T> {}

class DeleteOrdersSuccess<T> extends HistoryState<T> {}

class DeleteOrdersError<T> extends HistoryState<T> {
  final String? error;
  DeleteOrdersError({required this.error});
}
