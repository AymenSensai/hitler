import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/products/data/remote/products_api_service.dart';
import '../../features/products/data/repo/products_repo_impl.dart';
import '../../features/products/domain/repo/products_repo.dart';
import '../../features/products/presentation/controllers/products_cubit.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  // Products
  getIt
      .registerLazySingleton<ProductsApiService>(() => ProductsApiService(dio));
  getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepoImpl(getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));
}
