import 'package:flutter/material.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/custom_checkbox.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChecked;
  final VoidCallback onForgotPasswordTap;

  const RememberMeAndForgotPassword({
    required this.isChecked,
    required this.onChecked,
    required this.onForgotPasswordTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckbox(onChecked: onChecked),
        horizontalSpace(8),
        Text(
          'Remember me',
          style: TextStyles.font12LightBlackRegular,
        ),
        const Spacer(),
        TextButton(
          onPressed: onForgotPasswordTap,
          child: Text(
            'Forgot password?',
            style: TextStyles.font12BlueMedium,
          ),
        )
      ],
    );
  }
}
