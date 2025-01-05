import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/theme.dart';
import 'core/utils/constants.dart';

class StocksApp extends StatelessWidget {
  final AppRouter appRouter;
  const StocksApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Stock Manager',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: isLoggedInUser
            ? Routes.appHome
            : isOnboardingCompletedOnboarding
                ? Routes.signIn
                : Routes.onboarding,
        theme: ThemeManager.getAppLightTheme(),
      ),
    );
  }
}
