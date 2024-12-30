import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../products/data/remote/models/products_response.dart';

part 'stock_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class StockApiService {
  factory StockApiService(Dio dio, {String baseUrl}) = _StockApiService;

  @GET(ApiConstants.products)
  Future<ProductsResponse> getProducts();
}
