import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stocks_app/features/products/data/remote/models/product_model.dart';

import '../../../../core/networking/api_constants.dart';
import 'models/categories_response.dart';
import 'models/category_model.dart';
import 'models/products_response.dart';

part 'products_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio, {String baseUrl}) = _ProductsApiService;

  @GET(ApiConstants.products)
  Future<ProductsResponse> getProducts();

  @POST(ApiConstants.products)
  Future<void> addProduct(
    @Body() ProductModel productRequest,
  );

  @GET(ApiConstants.categories)
  Future<CategoriesResponse> getCategories();

  @POST(ApiConstants.categories)
  Future<void> addCategory(
    @Body() CategoryModel categoryRequest,
  );
}
