import 'package:flutter/material.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/extensions.dart';

import '../../../../core/networking/dio_factory.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/shared_pref_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logOut(BuildContext context) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, '');
    DioFactory.setTokenIntoHeaderAfterLogin('');
    if (!context.mounted) return;
    context.pushNamedAndRemoveUntil(
      Routes.signIn,
      predicate: (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Account Details',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.person),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Category',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.category),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Preferences',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Privacy & Security',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.lock),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Reset App Data',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.refresh),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Send Feedback',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.feedback),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Rate App',
                style: TextStyles.font16BlackRegular,
              ),
              leading: const Icon(Icons.star),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyles.font16RedRegular,
              ),
              leading: const Icon(
                Icons.logout,
                color: ColorsManager.red,
              ),
              onTap: () => _logOut(context),
            ),
          ],
        ),
      ),
    );
  }
}
