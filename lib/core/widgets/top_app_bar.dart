import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.title, this.leading, this.actions});

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyles.font20BlackBold),
      forceMaterialTransparency: true,
      iconTheme: IconThemeData(size: 30.h),
      leading: leading,
      actions: actions,
      toolbarHeight: 50,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
