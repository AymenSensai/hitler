import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/features/authentication/presentation/controllers/auth_cubit.dart';
import 'package:stocks_app/features/authentication/presentation/widgets/reset_password_bloc_listener.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_regex.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/top_app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    } else if (!AppRegex.isEmailValid(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void onContinue() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(_emailController.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: ''),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password Reset',
                style: TextStyles.font24BlackBold,
              ),
              verticalSpace(8),
              Text(
                'Enter your email to reset your password',
                style: TextStyles.font16LightBlackRegular,
              ),
              verticalSpace(24),
              Text(
                'Email',
                style: TextStyles.font14BlackMedium,
              ),
              verticalSpace(8),
              Form(
                key: _formKey,
                child: AppTextField(
                  validator: emailValidator,
                  controller: _emailController,
                  hintText: 'Email',
                ),
              ),
              verticalSpace(24),
              AppTextButton(
                buttonText: 'Continue',
                onPressed: onContinue,
              ),
              ResetPasswordBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
