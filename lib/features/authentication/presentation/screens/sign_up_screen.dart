import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/features/authentication/presentation/widgets/divider_with_text.dart';
import 'package:stocks_app/features/authentication/presentation/widgets/google_sign_button.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../controllers/auth_cubit.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/sign_up_form.dart';
import '../widgets/sign_up_prompt.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signUp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create an account',
                style: TextStyles.font24BlackBold,
              ),
              verticalSpace(8),
              Text(
                'Sign up now to get started on your journey.',
                style: TextStyles.font16BlackRegular,
              ),
              verticalSpace(32),
              SignUpForm(
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                formKey: _formKey,
              ),
              verticalSpace(32),
              AppTextButton(
                buttonText: 'Sign Up',
                onPressed: signUp,
              ),
              verticalSpace(16),
              DividerWithText(text: 'Or'),
              verticalSpace(16),
              GoogleSignButton(),
              verticalSpace(16),
              SignUpPrompt(),
              verticalSpace(16),
              SignUpBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
