import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../products/domain/entities/category_entity.dart';
import '../../domain/repo/settings_repo.dart';
import '../remote/settings_api_service.dart';

class SettingsRepoImpl extends SettingsRepo {
  final SettingsApiService _apiService;

  SettingsRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      final categories = response.data;
      final entities = categories.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
