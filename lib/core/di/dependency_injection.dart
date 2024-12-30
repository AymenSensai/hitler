import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stocks_app/features/authentication/data/remote/auth_api_service.dart';

import '../../features/authentication/data/repo/auth_repo_impl.dart';
import '../../features/authentication/domain/repo/auth_repo.dart';
import '../../features/authentication/presentation/controllers/auth_cubit.dart';
import '../../features/products/data/remote/products_api_service.dart';
import '../../features/products/data/repo/products_repo_impl.dart';
import '../../features/products/domain/repo/products_repo.dart';
import '../../features/products/presentation/controllers/products_cubit.dart';
import '../../features/stock/data/remote/stock_api_service.dart';
import '../../features/stock/data/repo/stock_repo_impl.dart';
import '../../features/stock/domain/repo/stock_repo.dart';
import '../../features/stock/presentation/controllers/stock_cubit.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  // Authentication
  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService(dio));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // Products
  getIt
      .registerLazySingleton<ProductsApiService>(() => ProductsApiService(dio));
  getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepoImpl(getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));

  // Stock
  getIt.registerLazySingleton<StockApiService>(() => StockApiService(dio));
  getIt.registerLazySingleton<StockRepo>(() => StockRepoImpl(getIt()));
  getIt.registerFactory<StockCubit>(() => StockCubit(getIt()));
}
