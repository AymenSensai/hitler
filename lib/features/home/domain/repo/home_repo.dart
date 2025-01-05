import '../../../../core/networking/api_result.dart';
import '../entities/dashboard_entity.dart';

abstract class HomeRepo {
  Future<ApiResult<DashboardEntity>> getDashboardData();
}
