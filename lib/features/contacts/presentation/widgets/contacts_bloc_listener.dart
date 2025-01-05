import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/utils/extensions.dart';

import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../controllers/contacts_cubit.dart';
import '../controllers/contacts_state.dart';

class ContactsBlocListener extends StatelessWidget {
  const ContactsBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsCubit, ContactsState>(
      listenWhen: (previous, current) =>
          current is AddContactLoading ||
          current is AddContactSuccess ||
          current is AddContactError,
      listener: (context, state) {
        switch (state) {
          case AddContactLoading():
            showAnimatedLoading(context);
          case AddContactSuccess():
            _setupSuccess(context);
          case AddContactError():
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
