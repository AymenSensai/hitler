import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/stocks_app.dart';

import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'core/utils/constants.dart';
import 'core/utils/shared_pref_helper.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();
  await checkIfOnboardingCompleted();
  runApp(StocksApp(appRouter: AppRouter()));
}

checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}

checkIfOnboardingCompleted() async {
  bool? isOnboardingCompleted =
      await SharedPrefHelper.getBool(SharedPrefKeys.onBoardingSeen);
  if (isOnboardingCompleted != null) {
    isOnboardingCompletedOnboarding = isOnboardingCompleted;
  } else {
    isOnboardingCompletedOnboarding = false;
  }
}
