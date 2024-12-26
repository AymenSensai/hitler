import 'package:flutter/material.dart';

import '../theming/colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color backgroundColor;
  final Color color;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.backgroundColor = ColorsManager.blue,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: backgroundColor,
      color: color,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
