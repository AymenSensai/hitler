import 'package:flutter/material.dart';

import '../theming/styles.dart';
import 'spacing.dart';

void errorSnackbar(BuildContext context, String? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Expanded(
            child: Text(
              (error == null || error.isEmpty) ? '! حدث خطأ ما' : error,
              style: TextStyles.font12WhiteMedium,
            ),
          ),
          horizontalSpace(8),
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.red[600],
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
    ),
  );
}
