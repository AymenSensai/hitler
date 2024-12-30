import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {super.key, required this.onChecked, this.value = false});

  final Function(bool?) onChecked;
  final bool value;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool? isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.h,
      child: Checkbox(
        value: isChecked,
        activeColor: ColorsManager.blue,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity(horizontal: -2.h, vertical: 0.0),
        onChanged: (value) {
          widget.onChecked(value);
          setState(() {
            isChecked = value;
          });
        },
      ),
    );
  }
}
