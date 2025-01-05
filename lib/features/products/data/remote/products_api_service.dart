import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
import 'models/categories_response.dart';
import 'models/category_model.dart';
import 'models/order_request_body.dart';
import 'models/products_response.dart';

part 'products_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio, {String baseUrl}) = _ProductsApiService;

  @GET(ApiConstants.products)
  Future<ProductsResponse> getProducts();

  @POST(ApiConstants.products)
  @MultiPart()
  Future<void> addProduct(
    @Part() String name,
    @Part() String sku,
    @Part() int stock,
    @Part() int reorder_point,
    @Part() int category_id,
    @Part() String selling_price,
    @Part() String cost_price,
    @Part() File image,
  );

  @PUT('${ApiConstants.products}/{id}')
  @MultiPart()
  Future<void> updateProduct(
    @Path('id') int id,
    @Part() String name,
    @Part() String sku,
    @Part() int stock,
    @Part() int reorder_point,
    @Part() int category_id,
    @Part() String selling_price,
    @Part() String cost_price,
    @Part() File image,
  );

  @GET(ApiConstants.categories)
  Future<CategoriesResponse> getCategories();

  @POST(ApiConstants.categories)
  Future<void> addCategory(
    @Body() CategoryModel categoryRequest,
  );

  @DELETE('${ApiConstants.products}/{id}')
  Future<void> deleteProduct(
    @Path('id') int id,
  );

  @POST(ApiConstants.orders)
  Future<void> placeOrder(
    @Body() OrderRequestBody order,
  );
}
