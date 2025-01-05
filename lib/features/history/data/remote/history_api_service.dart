import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stocks_app/features/history/data/remote/models/history_response.dart';

import '../../../../core/networking/api_constants.dart';

part 'history_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HistoryApiService {
  factory HistoryApiService(Dio dio, {String baseUrl}) = _HistoryApiService;

  @GET(ApiConstants.orders)
  Future<HistoryResponse> getOrders();

  @DELETE('${ApiConstants.orders}/{id}')
  Future<void> deleteOrders(
    @Path('id') int id,
  );
}
