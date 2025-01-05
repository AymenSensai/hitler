import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/utils/extensions.dart';

import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../controllers/history_cubit.dart';
import '../controllers/history_state.dart';

class HistoryBlocListener extends StatelessWidget {
  const HistoryBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryCubit, HistoryState>(
      listenWhen: (previous, current) =>
          current is DeleteOrdersLoading ||
          current is DeleteOrdersSuccess ||
          current is DeleteOrdersError,
      listener: (context, state) {
        switch (state) {
          case DeleteOrdersLoading():
            showAnimatedLoading(context);
          case DeleteOrdersSuccess():
            _setupSuccess(context);
          case DeleteOrdersError():
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
    context.pop();
  }

  void _setupError(BuildContext context, String? error) {
    context.pop();
    errorSnackbar(context, error);
  }
}
