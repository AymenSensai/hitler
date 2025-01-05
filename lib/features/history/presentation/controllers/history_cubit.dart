import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/history/domain/repo/history_repo.dart';
import 'package:stocks_app/features/history/presentation/controllers/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._historyRepo) : super(HistoryInitial());

  final HistoryRepo _historyRepo;

  Future<void> getOrders() async {
    emit(GetOrdersLoading());
    final response = await _historyRepo.getOrders();
    response.when(
      success: (response) {
        emit(GetOrdersSuccess(orders: response));
      },
      failure: (error) {
        emit(GetOrdersError(error: error));
      },
    );
  }

  Future<void> deleteOrders(int id) async {
    emit(DeleteOrdersLoading());
    final response = await _historyRepo.deleteOrders(id);
    response.when(
      success: (_) {
        emit(DeleteOrdersSuccess());
      },
      failure: (error) {
        emit(DeleteOrdersError(error: error));
      },
    );
  }
}
