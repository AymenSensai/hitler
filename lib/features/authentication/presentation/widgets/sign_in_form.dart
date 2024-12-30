import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_regex.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool isObscureText = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    } else if (!AppRegex.isEmailValid(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyles.font14BlackMedium,
          ),
          verticalSpace(8),
          AppTextField(
            validator: emailValidator,
            controller: widget.emailController,
            hintText: 'Email',
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: () => _passwordFocusNode.requestFocus(),
          ),
          verticalSpace(16),
          Text(
            'Password',
            style: TextStyles.font14BlackMedium,
          ),
          verticalSpace(8),
          AppTextField(
            controller: widget.passwordController,
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            isObscureText: isObscureText,
            autofillHints: const [AutofillHints.password],
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              icon: SvgPicture.asset(
                isObscureText ? Assets.eyeOff : Assets.eye,
                colorFilter:
                    ColorFilter.mode(ColorsManager.grey, BlendMode.srcIn),
                height: 30.h,
                width: 30.h,
                fit: BoxFit.contain,
              ),
            ),
            focusNode: _passwordFocusNode,
            validator: passwordValidator,
          ),
        ],
      ),
    );
  }
}
