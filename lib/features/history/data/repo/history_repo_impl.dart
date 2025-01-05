import 'package:stocks_app/features/history/domain/entities/history_entity.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../domain/repo/history_repo.dart';
import '../remote/history_api_service.dart';

class HistoryRepoImpl extends HistoryRepo {
  final HistoryApiService _apiService;

  HistoryRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<HistoryEntity>>> getOrders() async {
    try {
      final response = await _apiService.getOrders();
      final entities = response.data.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<void>> deleteOrders(int id) async {
    try {
      await _apiService.deleteOrders(id);
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
