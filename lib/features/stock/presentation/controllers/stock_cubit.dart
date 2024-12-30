import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/stock/domain/repo/stock_repo.dart';

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
}
