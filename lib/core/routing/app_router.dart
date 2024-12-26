import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/di/dependency_injection.dart';
import 'package:stocks_app/core/widgets/app_home.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';
import 'package:stocks_app/features/products/presentation/screens/add_product_screen.dart';
import 'package:stocks_app/features/products/presentation/screens/product_screen.dart';

import 'routes.dart';

class AppRouter {
  static final productsCubit = getIt<ProductsCubit>();

  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.appHome:
        return MaterialPageRoute(
          builder: (_) => AppHome(),
        );

      case Routes.addProduct:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: productsCubit,
            child: AddProductScreen(
              product: arguments as ProductEntity?,
            ),
          ),
        );

      case Routes.product:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: productsCubit,
            child: ProductScreen(
              product: arguments as ProductEntity,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
