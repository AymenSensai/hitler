import '../../../../core/networking/api_result.dart';
import '../../../products/domain/entities/category_entity.dart';

abstract class SettingsRepo {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
}
