import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/app_text_form_field.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  DateTime? transactionDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Update Stock',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              AppTextField(
                hintText: 'Select Contact name',
                controller: TextEditingController(),
                validator: (p0) {},
              ),
              verticalSpace(16),
              InkWell(
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: transactionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      transactionDate = value;
                    });
                  }
                }),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded),
                      Text(transactionDate?.toString() ?? 'Select Date'),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ),
              verticalSpace(16),
              InkWell(
                onTap: () => context.pushNamed(Routes.selectProducts),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select Items'),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ),
              verticalSpace(16),
              AppTextField(
                hintText: 'Notes',
                controller: TextEditingController(),
                validator: (p0) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
