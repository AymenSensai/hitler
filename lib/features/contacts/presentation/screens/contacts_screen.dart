import 'package:flutter/material.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Contacts',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(Routes.addContact);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
