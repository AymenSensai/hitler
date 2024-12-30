import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/top_app_bar.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void submit() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                'إعادة تعيين كلمة المرور',
                style: TextStyles.font24BlackBold,
              ),
              verticalSpace(8),
              Text(
                'يرجى ادخال كلمة المرور الجديدة',
                style: TextStyles.font16LightBlackRegular,
              ),
              verticalSpace(16),
              ChangePasswordForm(
                formKey: _formKey,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              verticalSpace(24),
              AppTextButton(
                buttonText: 'تأكيد',
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
