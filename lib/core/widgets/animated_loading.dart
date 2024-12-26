import 'package:flutter/material.dart';

void showAnimatedLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AnimatedLoading(),
  );
}

class AnimatedLoading extends StatelessWidget {
  const AnimatedLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
