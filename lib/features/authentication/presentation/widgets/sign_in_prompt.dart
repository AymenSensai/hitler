import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/extensions.dart';

class SignInPrompt extends StatelessWidget {
  const SignInPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyles.font12LightBlackMedium,
        ),
        TextButton(
          onPressed: () => context.pushReplacementNamed(Routes.register),
          child: Text(
            'Sign Up',
            style: TextStyles.font12BlueMedium,
          ),
        ),
      ],
    );
  }
}
