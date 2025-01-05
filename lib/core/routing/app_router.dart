import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/di/dependency_injection.dart';
import 'package:stocks_app/core/widgets/app_home.dart';
import 'package:stocks_app/features/authentication/presentation/controllers/auth_cubit.dart';
import 'package:stocks_app/features/authentication/presentation/screens/change_password_screen.dart';
import 'package:stocks_app/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:stocks_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:stocks_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:stocks_app/features/authentication/presentation/screens/verification_screen.dart';
import 'package:stocks_app/features/contacts/presentation/screens/add_contact_screen.dart';
import 'package:stocks_app/features/history/presentation/controllers/history_cubit.dart';
import 'package:stocks_app/features/history/presentation/screens/update_stock_details_screen.dart';
import 'package:stocks_app/features/onboarding/onboarding_screen.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';
import 'package:stocks_app/features/products/presentation/screens/add_product_screen.dart';
import 'package:stocks_app/features/products/presentation/screens/product_screen.dart';
import 'package:stocks_app/features/settings/presentation/screens/category_screen.dart';
import 'package:stocks_app/features/stock/presentation/controllers/stock_cubit.dart';
import 'package:stocks_app/features/stock/presentation/screens/selected_products_screen.dart';
import 'package:stocks_app/features/stock/presentation/screens/stock_screen.dart';

import '../../features/contacts/presentation/controllers/contacts_cubit.dart';
import '../../features/history/domain/entities/history_entity.dart';
import 'routes.dart';

class AppRouter {
  static final productsCubit = getIt<ProductsCubit>();
  static final stocksCubit = getIt<StockCubit>();
  static final contactsCubit = getIt<ContactsCubit>();

  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: SignInScreen(),
          ),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: SignUpScreen(),
          ),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: ResetPasswordScreen(),
          ),
        );

      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: ChangePasswordScreen(),
          ),
        );

      case Routes.verification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: VerificationScreen(email: arguments as String),
          ),
        );

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

      case Routes.updateStock:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: stocksCubit
              ..getContacts()
              ..getProducts(),
            child: StockScreen(),
          ),
        );

      case Routes.selectProducts:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: stocksCubit,
            child: SelectedProductsScreen(),
          ),
        );

      case Routes.category:
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(),
        );

      case Routes.addContact:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: contactsCubit,
            child: AddContactsScreen(),
          ),
        );

      case Routes.updateStockDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HistoryCubit>(),
            child: UpdateStockDetailsScreen(
              order: arguments as HistoryEntity,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
