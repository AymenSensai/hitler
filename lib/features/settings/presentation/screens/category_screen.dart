import 'package:flutter/material.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: ColorsManager.white,
        ),
      ),
      appBar: TopAppBar(
        title: 'Category',
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
