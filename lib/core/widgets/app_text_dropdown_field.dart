import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextDropdownField extends StatefulWidget {
  const AppTextDropdownField({
    super.key,
    required this.initialValue,
    required this.dropdownList,
    required this.onValueChanged,
    required this.validator,
    required this.hintText,
    this.backgroundColor = ColorsManager.white,
    this.suffixIcon,
  });

  final String? initialValue;
  final List<String> dropdownList;
  final ValueChanged<String?> onValueChanged;
  final Function(String?) validator;
  final String hintText;
  final Color backgroundColor;
  final Widget? suffixIcon;

  @override
  State<AppTextDropdownField> createState() => _AppTextDropdownFieldState();
}

class _AppTextDropdownFieldState extends State<AppTextDropdownField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedValue,
      style: TextStyles.font14WhiteRegular,
      isDense: false,
      itemHeight: 61.h,
      validator: (value) {
        return widget.validator(value);
      },
      dropdownColor: widget.backgroundColor,
      icon: SizedBox.shrink(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: widget.backgroundColor,
        errorStyle: TextStyles.font10RedRegular,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.blue,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.lightGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      items: widget.dropdownList.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyles.font18BlackMedium,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedValue = newValue;
          widget.onValueChanged(newValue);
        });
      },
      hint: Text(
        widget.hintText,
        style: TextStyles.font16GreyRegular,
      ),
    );
  }
}
