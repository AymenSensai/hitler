import 'package:flutter/material.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';
import 'extensions.dart';

Future<void> showDeleteConfirmationDialog(
    BuildContext context, VoidCallback deleteTask, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorsManager.white,
        title: Text(
          'Delete Confirmation',
          style: TextStyles.font18BlackMedium,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                text,
                style: TextStyles.font14BlackRegular,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyles.font14BlackMedium,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(ColorsManager.red),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyles.font14WhiteMedium,
            ),
            onPressed: () async {
              context.pop();
              deleteTask();
            },
          ),
        ],
      );
    },
  );
}
