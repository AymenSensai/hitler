import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final bool? readOnly;
  final Color? backgroundColor;
  final TextEditingController controller;
  final Function(String?) validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final VoidCallback? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final int maxLines;
  const AppTextField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.isObscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly,
    this.backgroundColor,
    this.keyboardType,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTap,
    this.maxLines = 1,
    required this.validator,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        isDense: true,
        errorStyle: TextStyles.font10RedRegular,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.blue,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
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
        hintStyle: hintStyle ?? TextStyles.font16GreyRegular,
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 20.h,
                ),
                child: SvgPicture.asset(
                  prefixIcon!,
                  width: 22.w,
                  height: 22.w,
                  colorFilter: const ColorFilter.mode(
                    ColorsManager.grey,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: suffixIcon,
              )
            : null,
      ),
      obscureText: isObscureText ?? false,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      style: TextStyles.font16BlackMedium,
      maxLines: maxLines,
      validator: (value) {
        return validator(value);
      },
      onTap: onTap,
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!();
        }
      },
    );
  }
}
