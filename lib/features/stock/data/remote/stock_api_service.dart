import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../contacts/data/remote/models/contacts_response.dart';
import '../../../products/data/remote/models/order_request_body.dart';
import '../../../products/data/remote/models/products_response.dart';

part 'stock_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class StockApiService {
  factory StockApiService(Dio dio, {String baseUrl}) = _StockApiService;

  @GET(ApiConstants.products)
  Future<ProductsResponse> getProducts();

  @GET(ApiConstants.contacts)
  Future<ContactsResponse> getContacts();

  @POST(ApiConstants.orders)
  Future<void> placeOrder(
    @Body() OrderRequestBody order,
  );
}
