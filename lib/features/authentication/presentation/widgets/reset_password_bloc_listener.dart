import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/utils/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is ForgotPasswordLoading ||
          current is ForgotPasswordSuccess ||
          current is ForgotPasswordError,
      listener: (context, state) {
        switch (state) {
          case ForgotPasswordLoading():
            showAnimatedLoading(context);
          case ForgotPasswordSuccess():
            _setupSuccess(context);
          case ForgotPasswordError():
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
    context.pushNamed(Routes.verification, arguments: 'reset_password');
  }

  void _setupError(BuildContext context, String? error) {
    context.pop();
    errorSnackbar(context, error);
  }
}
