import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop([Object? result]) => Navigator.of(this).pop(result);
}

extension ScreenSize on BuildContext {
  double screenHeight() => MediaQuery.of(this).size.height;
  double screenWidth() => MediaQuery.of(this).size.width;
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}
