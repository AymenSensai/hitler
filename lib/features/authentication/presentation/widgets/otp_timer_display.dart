import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/spacing.dart';

class OtpTimerDisplay extends StatefulWidget {
  const OtpTimerDisplay({super.key});

  @override
  State<OtpTimerDisplay> createState() => _OtpTimerDisplayState();
}

class _OtpTimerDisplayState extends State<OtpTimerDisplay> {
  int _timeRemaining = 30;
  Timer? _timer;
  bool _isTimeExpired = false;

  void resendCode() {
    startTimer();
    setState(() {
      _isTimeExpired = false;
    });
  }

  String _getFormattedTime(int secondsRemaining) {
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void startTimer() {
    _isTimeExpired = false;
    _timeRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        setState(() {
          _isTimeExpired = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ستنتهي صلاحية رمز التحقق بعد ',
                style: TextStyles.font16LightBlackRegular,
              ),
              TextSpan(
                text: _getFormattedTime(_timeRemaining),
                style: TextStyles.font14BlueMedium,
              ),
            ],
          ),
        ),
        verticalSpace(8),
        if (_isTimeExpired)
          GestureDetector(
            onTap: resendCode,
            child: Text(
              'ارسال مرة أخرى',
              style: TextStyles.font14BlueMedium.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: ColorsManager.blue,
              ),
            ),
          ),
      ],
    );
  }
}
