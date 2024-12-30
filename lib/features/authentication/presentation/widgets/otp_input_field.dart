import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/spacing.dart';

class OtpInputField extends StatefulWidget {
  const OtpInputField({
    super.key,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  String _otpCode = "";
  String _errorText = '';

  void _submitOtp(String otp) {
    setState(() {
      _otpCode = otp;
      _errorText = '';
    });

    if (_otpCode != '1234') {
      setState(() {
        _errorText = 'الرمز غير صحيح حاول مرة اخرى';
      });
    } else {
      context.pushNamed(Routes.changePassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Localizations.override(
          context: context,
          locale: const Locale('en', ''),
          child: OtpTextField(
            numberOfFields: 4,
            enabledBorderColor:
                _errorText.isNotEmpty ? ColorsManager.red : Color(0xFFE7E7E7),
            focusedBorderColor:
                _errorText.isNotEmpty ? ColorsManager.red : ColorsManager.blue,
            showFieldAsBox: true,
            fieldWidth: 60.w,
            fieldHeight: 60.w,
            textStyle: TextStyles.font20BlackBold,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(8),
            autoFocus: true,
            onCodeChanged: (String code) {
              setState(() {
                _errorText = '';
              });
            },
            onSubmit: _submitOtp,
          ),
        ),
        verticalSpace(8),
        if (_errorText.isNotEmpty)
          Text(
            _errorText,
            style: TextStyles.font14RedRegular,
          ),
      ],
    );
  }
}
