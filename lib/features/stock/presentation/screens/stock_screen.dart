import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/animated_loading.dart';
import 'package:stocks_app/core/widgets/app_text_dropdown_field.dart';
import 'package:stocks_app/core/widgets/app_text_form_field.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/products/data/remote/models/order_request_body.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/stock/presentation/controllers/stock_cubit.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/cached_network_image.dart';
import '../../../../core/utils/date_picker.dart';
import '../../../../core/utils/error_snackbar.dart';
import '../controllers/stock_state.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  DateTime? transactionDate;
  final TextEditingController _notesController = TextEditingController();
  Map<ProductEntity, int> selectedProducts = {};
  int? contactId;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formattedDate =
        "${transactionDate?.day}-${transactionDate?.month}-${transactionDate?.year}";
    return Scaffold(
      appBar: TopAppBar(
        title: 'Update Stock',
        actions: [
          IconButton(
            onPressed: () {
              final List<OrderProductModel> products =
                  selectedProducts.entries.map((entry) {
                return OrderProductModel(
                  id: entry.key.id!,
                  quantity: entry.value,
                );
              }).toList();
              context.read<StockCubit>().placeOrder(
                    OrderRequestBody(
                      transactionDate: transactionDate!.toIso8601String(),
                      products: products,
                      contactId: contactId,
                      notes: _notesController.text,
                    ),
                  );
            },
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<StockCubit, StockState>(
          listenWhen: (previous, current) =>
              current is UpdateStockLoading ||
              current is UpdateStockSuccess ||
              current is UpdateStockError,
          listener: (context, state) {
            switch (state) {
              case UpdateStockLoading():
                showAnimatedLoading(context);
              case UpdateStockSuccess():
                context.pop();
                context.pop();
              case UpdateStockError():
                context.pop();
                errorSnackbar(context, state.error);
              default:
                const SizedBox.shrink();
            }
          },
          buildWhen: (previous, current) =>
              current is GetStockContactsSuccess ||
              current is GetStockContactsError ||
              current is GetStockContactsLoading,
          builder: (context, state) {
            switch (state) {
              case GetStockContactsLoading():
                return AnimatedLoading();
              case GetStockContactsSuccess():
                final contacts = (state).contacts;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      AppTextDropdownField(
                        hintText: 'Select Contact name',
                        dropdownList:
                            contacts.map((e) => e.name).toList().cast<String>(),
                        initialValue: null,
                        onValueChanged: (value) {
                          contactId = contacts
                              .firstWhere((element) => element.name == value)
                              .id;
                        },
                        validator: (p0) {},
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await context.pushNamed(Routes.addContact);
                              if (!context.mounted) return;
                              context.read<StockCubit>().getContacts();
                            },
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      InkWell(
                        onTap: () => pickDate(
                          context,
                          transactionDate,
                          (value) {
                            setState(() {
                              transactionDate = value;
                            });
                          },
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: ColorsManager.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 20.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: ColorsManager.black,
                              ),
                              horizontalSpace(16),
                              Text(
                                transactionDate != null
                                    ? formattedDate
                                    : 'Select Date',
                                style: TextStyles.font14BlackRegular,
                              ),
                              horizontalSpace(16),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorsManager.black,
                                size: 16.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      selectedProducts.isEmpty
                          ? InkWell(
                              onTap: () async {
                                final data = await context
                                    .pushNamed(Routes.selectProducts);
                                if (data != null) {
                                  setState(() {
                                    selectedProducts = data;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: ColorsManager.white,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Select Products'),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorsManager.black,
                                      size: 16.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final data = await context
                                        .pushNamed(Routes.selectProducts);
                                    if (data != null) {
                                      setState(() {
                                        selectedProducts = data;
                                      });
                                    }
                                  },
                                  child: Container(
                                    color: ColorsManager.white,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 16.w,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: ColorsManager.blue,
                                        ),
                                        horizontalSpace(8),
                                        Text(
                                          'Add More Products',
                                          style: TextStyles.font14BlueMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: selectedProducts.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        selectedProducts.keys.elementAt(index);
                                    final quantity = selectedProducts[product]!;

                                    return ListTile(
                                      title: Text(
                                        product.name,
                                        style: TextStyles.font14BlackMedium,
                                      ),
                                      subtitle: Text(
                                        double.parse(product.stock)
                                            .toInt()
                                            .toString(),
                                        style: TextStyles.font14GreenMedium,
                                      ),
                                      leading: CachedNetworkImageWidget(
                                        imageUrl: product.image ?? '',
                                        width: 50,
                                        height: 50,
                                      ),
                                      tileColor: ColorsManager.white,
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              selectedProducts.removeWhere(
                                                (key, value) =>
                                                    key.id == product.id,
                                              );
                                            }),
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: 18,
                                              color: ColorsManager.red,
                                            ),
                                          ),
                                          verticalSpace(8),
                                          Text(
                                            '$quantity',
                                            style: TextStyles.font14BlackMedium,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                      verticalSpace(16),
                      AppTextField(
                        hintText: 'Notes',
                        controller: _notesController,
                        validator: (p0) {},
                      ),
                    ],
                  ),
                );
              case GetStockContactsError():
                final error = (state).error;
                return Text(error ?? 'An error occurred');
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
