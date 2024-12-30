import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_regex.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool isObscureText = true;

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
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

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    } else if (value != widget.passwordController.text) {
      return 'Passwords do not match.';
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
            'Name',
            style: TextStyles.font14BlackMedium,
          ),
          verticalSpace(8),
          AppTextField(
            validator: nameValidator,
            controller: widget.nameController,
            hintText: 'Name',
            focusNode: _nameFocusNode,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: () => _emailFocusNode.requestFocus(),
          ),
          verticalSpace(16),
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
