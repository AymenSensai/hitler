import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/stock/domain/repo/stock_repo.dart';

import '../../../products/data/remote/models/order_request_body.dart';
import '../../../products/domain/entities/product_entity.dart';
import 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit(this._stockRepo) : super(StockInitial());

  final StockRepo _stockRepo;
  final List<ProductEntity> products = [];

  Future<void> getProducts() async {
    final response = await _stockRepo.getProducts();
    response.when(
      success: (response) {
        products.clear();
        products.addAll(response);
      },
      failure: (error) {},
    );
  }

  Future<void> getContacts() async {
    emit(GetStockContactsLoading());
    final response = await _stockRepo.getContacts();
    response.when(
      success: (response) {
        emit(GetStockContactsSuccess(contacts: response));
      },
      failure: (error) {
        emit(GetStockContactsError(error: error));
      },
    );
  }

  Future<void> placeOrder(OrderRequestBody order) async {
    emit(UpdateStockLoading());
    final response = await _stockRepo.placeOrder(order);
    response.when(
      success: (response) {
        getProducts();
        emit(UpdateStockSuccess());
      },
      failure: (error) {
        emit(UpdateStockError(error: error));
      },
    );
  }
}
