import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';

class SignInBlocListener extends StatelessWidget {
  const SignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is SignInLoading ||
          current is SignInSuccess ||
          current is SignInError,
      listener: (context, state) {
        switch (state) {
          case GoogleSignInLoading():
          case SignInLoading():
            showAnimatedLoading(context);
          case GoogleSignInSuccess():
          case SignInSuccess():
            _setupSuccess(context);
          case GoogleSignInError():
            _setupError(context, state.error);
          case SignInError():
            _setupError(context, state.error);
          default:
            const SizedBox.shrink();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _setupSuccess(BuildContext context) {
    context.pop();
    context.pushNamedAndRemoveUntil(
      Routes.appHome,
      predicate: (Route<dynamic> route) => false,
    );
  }

  void _setupError(BuildContext context, String? error) {
    context.pop();
    errorSnackbar(context, error);
  }
}

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is SignUpLoading ||
          current is SignUpSuccess ||
          current is SignUpError,
      listener: (context, state) {
        switch (state) {
          case GoogleSignInLoading():
          case SignUpLoading():
            showAnimatedLoading(context);
          case GoogleSignInSuccess():
          case SignUpSuccess():
            _setupSuccess(context);
          case GoogleSignInError():
            _setupError(context, state.error);
          case SignUpError():
            _setupError(context, state.error);
          default:
            const SizedBox.shrink();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _setupSuccess(BuildContext context) {
    context.pop();
    context.pushNamedAndRemoveUntil(
      Routes.appHome,
      predicate: (Route<dynamic> route) => false,
    );
  }

  void _setupError(BuildContext context, String? error) {
    context.pop();
    errorSnackbar(context, error);
  }
}
