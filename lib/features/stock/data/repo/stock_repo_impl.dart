import 'package:stocks_app/features/contacts/domain/entities/contact_entity.dart';
import 'package:stocks_app/features/products/data/remote/models/order_request_body.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/repo/stock_repo.dart';
import '../remote/stock_api_service.dart';

class StockRepoImpl extends StockRepo {
  final StockApiService _apiService;

  StockRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async {
    try {
      final response = await _apiService.getProducts();
      final entities = response.data.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<List<ContactEntity>>> getContacts() async {
    try {
      final response = await _apiService.getContacts();
      final entities = response.data.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<void>> placeOrder(OrderRequestBody order) async {
    try {
      await _apiService.placeOrder(order);
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
