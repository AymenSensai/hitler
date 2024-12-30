import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/features/authentication/presentation/widgets/remember_me_and_forgot_password.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../controllers/auth_cubit.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/divider_with_text.dart';
import '../widgets/google_sign_button.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_in_prompt.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberMeBoxChecked = false;

  void signIn() {
    if (_formKey.currentState!.validate()) {
      if (_isRememberMeBoxChecked == true) {
        TextInput.finishAutofillContext();
      }
      context
          .read<AuthCubit>()
          .login(_emailController.text, _passwordController.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyles.font24BlackBold,
              ),
              verticalSpace(8),
              Text(
                'Welcome back! Please sign in to your account',
                style: TextStyles.font16LightBlackRegular,
              ),
              verticalSpace(32),
              SignInForm(
                emailController: _emailController,
                passwordController: _passwordController,
                formKey: _formKey,
              ),
              verticalSpace(8),
              RememberMeAndForgotPassword(
                isChecked: _isRememberMeBoxChecked,
                onChecked: (value) => _isRememberMeBoxChecked = value ?? false,
                onForgotPasswordTap: () =>
                    context.pushNamed(Routes.resetPassword),
              ),
              verticalSpace(16),
              AppTextButton(
                buttonText: 'Sign In',
                onPressed: signIn,
              ),
              verticalSpace(16),
              DividerWithText(text: 'Or'),
              verticalSpace(16),
              GoogleSignButton(),
              verticalSpace(16),
              SignInPrompt(),
              verticalSpace(16),
              SignInBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
