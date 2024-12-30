import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../controllers/auth_cubit.dart';

class GoogleSignButton extends StatefulWidget {
  const GoogleSignButton({super.key});

  @override
  State<GoogleSignButton> createState() => _GoogleSignButtonState();
}

class _GoogleSignButtonState extends State<GoogleSignButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => googleSignIn(context),
        style: TextButton.styleFrom(
          side: const BorderSide(color: ColorsManager.lightBlack),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          fixedSize: Size(double.maxFinite, 62.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.google,
              width: 20.w,
              height: 20.w,
            ),
            horizontalSpace(24),
            Text(
              'Continue with Google',
              style: TextStyles.font14BlackMedium,
            ),
          ],
        ),
      ),
    );
  }

  void googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      // User canceled the sign-in
      return;
    }

    // Obtain Google authentication details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print(googleAuth.idToken);

    if (!context.mounted || googleAuth.idToken == null) return;

    context.read<AuthCubit>().googleSignIn(googleAuth.idToken!);
  }
}
