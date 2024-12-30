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
}
