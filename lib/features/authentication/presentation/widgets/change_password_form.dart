import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    super.key,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور.';
    } else if (value.length < 8) {
      return 'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل.';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال تأكيد كلمة المرور.';
    } else if (value != widget.passwordController.text) {
      return 'كلمات المرور غير متطابقة.';
    }
    return null;
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isObscure,
    required VoidCallback toggleObscure,
    required String hintText,
    required String? Function(String?) validator,
    required TextInputAction textInputAction,
    VoidCallback? onFieldSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font14BlackMedium),
        verticalSpace(8),
        AppTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: textInputAction,
          isObscureText: isObscure,
          focusNode: focusNode,
          suffixIcon: IconButton(
            onPressed: toggleObscure,
            icon: SvgPicture.asset(
              isObscure ? Assets.eyeOff : Assets.eye,
              colorFilter:
                  ColorFilter.mode(ColorsManager.grey, BlendMode.srcIn),
              height: 30.h,
              width: 30.h,
              fit: BoxFit.contain,
            ),
          ),
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildPasswordField(
            label: 'كلمة المرور',
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            isObscure: _isObscurePassword,
            toggleObscure: () {
              setState(() {
                _isObscurePassword = !_isObscurePassword;
              });
            },
            hintText: 'كلمة المرور',
            validator: _passwordValidator,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: () => _confirmPasswordFocusNode.requestFocus(),
          ),
          verticalSpace(8),
          Row(
            children: [
              SvgPicture.asset(
                Assets.pin,
                colorFilter: ColorFilter.mode(
                  ColorsManager.lightBlack,
                  BlendMode.srcIn,
                ),
                height: 24.h,
                width: 24.h,
                fit: BoxFit.contain,
              ),
              horizontalSpace(8),
              Text(
                'يجب ان لا تقل كلمة المرور عن 8 أحرف أو أرقام',
                style: TextStyles.font14BlackRegular,
              ),
            ],
          ),
          verticalSpace(16),
          _buildPasswordField(
            label: 'تأكيد كلمة المرور',
            controller: widget.confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            isObscure: _isObscureConfirmPassword,
            toggleObscure: () {
              setState(() {
                _isObscureConfirmPassword = !_isObscureConfirmPassword;
              });
            },
            hintText: 'تأكيد كلمة المرور',
            validator: _confirmPasswordValidator,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
