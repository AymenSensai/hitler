import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stocks_app/features/products/data/remote/models/categories_response.dart';

import '../../../../core/networking/api_constants.dart';

part 'settings_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SettingsApiService {
  factory SettingsApiService(Dio dio, {String baseUrl}) = _SettingsApiService;

  @GET(ApiConstants.categories)
  Future<CategoriesResponse> getCategories();
}
