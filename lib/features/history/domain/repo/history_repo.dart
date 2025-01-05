import '../../../../core/networking/api_result.dart';
import '../entities/history_entity.dart';

abstract class HistoryRepo {
  Future<ApiResult<List<HistoryEntity>>> getOrders();
  Future<ApiResult<void>> deleteOrders(int id);
}
