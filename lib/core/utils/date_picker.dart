import 'package:flutter/material.dart';

import '../theming/colors.dart';

Future<void> pickDate(BuildContext context, DateTime? initialDate,
    ValueChanged<DateTime> onDatePicked,
    {DateTime? firstDate, DateTime? lastDate}) async {
  await showDatePicker(
    context: context,
    initialDate: initialDate ?? firstDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: lastDate ?? DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorsManager.blue,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
          ),
        ),
        child: child!,
      );
    },
  ).then(
    (value) {
      if (value != null) {
        onDatePicked(value);
      }
      return null;
    },
  );
}
