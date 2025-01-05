import 'package:stocks_app/features/home/domain/repo/home_repo.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../remote/home_api_service.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeApiService _apiService;

  HomeRepoImpl(this._apiService);

  @override
  Future<ApiResult<DashboardEntity>> getDashboardData() async {
    try {
      final response = await _apiService.getDashboardData();
      final entity = response.toEntity();
      return ApiResult.success(entity);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
