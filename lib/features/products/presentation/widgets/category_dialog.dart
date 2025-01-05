import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/widgets/app_text_button.dart';

import '../../../../core/widgets/app_text_form_field.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({super.key, required this.onAddCategory});

  final Function(String) onAddCategory;

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final TextEditingController _dialogController = TextEditingController();

  @override
  void dispose() {
    _dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Category'),
      backgroundColor: ColorsManager.white,
      content: AppTextField(
        controller: _dialogController,
        hintText: 'Enter category name',
        validator: (_) {},
        backgroundColor: ColorsManager.lightGrey,
        hintStyle: TextStyles.font14BlackRegular,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppTextButton(
          onPressed: () {
            if (_dialogController.text.isNotEmpty) {
              widget.onAddCategory(_dialogController.text);
              context.pop();
            }
          },
          buttonText: 'OK',
          buttonWidth: 100.w,
          buttonHeight: 50.h,
          borderRadius: 4,
        ),
      ],
    );
  }
}
