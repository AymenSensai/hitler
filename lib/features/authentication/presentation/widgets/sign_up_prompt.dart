import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/extensions.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyles.font12LightBlackMedium,
        ),
        TextButton(
          onPressed: () => context.pushReplacementNamed(Routes.signIn),
          child: Text(
            'Sign In',
            style: TextStyles.font12BlueMedium,
          ),
        ),
      ],
    );
  }
}
