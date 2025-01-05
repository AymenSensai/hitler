import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/assets.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/utils/show_delete_confirmation_dialog.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';
import 'package:stocks_app/features/products/presentation/widgets/products_bloc_listener.dart';

import '../../../../core/utils/cached_network_image.dart';
import '../../data/remote/models/order_request_body.dart';
import '../widgets/quantity_dialog.dart';
import '../widgets/sales_chart.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = _selectedTabIndex;
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final salesData = widget.product.getSalesData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context, (int quantity) {
            context.read<ProductsCubit>().placeOrder(
                  OrderRequestBody(
                    transactionDate: DateTime.now().toIso8601String(),
                    products: [
                      OrderProductModel(
                          id: widget.product.id!, quantity: quantity)
                    ],
                  ),
                );
          });
        },
        child: Icon(
          Icons.shuffle_rounded,
          color: ColorsManager.white,
        ),
      ),
      appBar: TopAppBar(
        title: 'Product Details',
        actions: [
          IconButton(
            onPressed: () => showDeleteConfirmationDialog(
              context,
              () => context
                  .read<ProductsCubit>()
                  .deleteProduct(widget.product.id!),
              'Are you sure you want to delete this product?',
            ),
            icon: SvgPicture.asset(Assets.trash),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: ColorsManager.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  CachedNetworkImageWidget(
                    imageUrl: widget.product.image ?? '',
                    width: 60.h,
                    height: 60.h,
                  ),
                  horizontalSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      verticalSpace(4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Available Stock: ',
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: widget.product.stock,
                              style: TextStyles.font16BlackSemiBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(16),
            DefaultTabController(
              length: 2,
              child: Container(
                height: 55.h,
                color: ColorsManager.white,
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyles.font14BlackMedium,
                  unselectedLabelStyle: TextStyles.font14LightGreyRegular,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: ColorsManager.lightBlack,
                  indicatorColor: ColorsManager.black,
                  tabs: const [
                    Tab(text: 'OVERVIEW'),
                    Tab(text: 'STOCK HISTORY'),
                  ],
                ),
              ),
            ),
            _selectedTabIndex == 0
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        verticalSpace(16),
                        Container(
                          color: ColorsManager.white,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Category: ',
                                      style: TextStyles.font14BlackRegular,
                                    ),
                                    TextSpan(
                                      text: widget.product.category.name,
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(16),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Reorder Point: ',
                                      style: TextStyles.font14BlackRegular,
                                    ),
                                    TextSpan(
                                      text: widget.product.reorderPoint,
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(16),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'SKU#: ',
                                      style: TextStyles.font14BlackRegular,
                                    ),
                                    TextSpan(
                                      text: widget.product.sku,
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(16),
                        Container(
                          color: ColorsManager.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Selling Price(DZD): ',
                                      style: TextStyles.font14BlackRegular,
                                    ),
                                    TextSpan(
                                      text: widget.product.sellingPrice,
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(16),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Cost Price(DZD): ',
                                      style: TextStyles.font14BlackRegular,
                                    ),
                                    TextSpan(
                                      text: widget.product.costPrice,
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(16),
                        Container(
                          color: ColorsManager.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          width: double.infinity,
                          child: SalesChart(
                            salesData: salesData,
                          ),
                        ),
                        ProductBlocListener(),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      ...widget.product.orders.reversed
                          .toList()
                          .asMap()
                          .entries
                          .map(
                        (entry) {
                          final index = entry.key;
                          final order = entry.value;

                          // Calculate the closing stock
                          int closingStock =
                              double.parse(widget.product.stock).toInt();
                          for (int i = 0; i <= index; i++) {
                            closingStock -=
                                widget.product.orders[i].pivot.quantity;
                          }

                          return Container(
                            color: ColorsManager.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Column(
                              children: [
                                verticalSpace(16),
                                Row(
                                  children: [
                                    Text(
                                      order.formattedTransactionDate,
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                    Spacer(),
                                    order.pivot.quantity > 0
                                        ? Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Colors.green,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.arrow_downward_outlined,
                                            color: ColorsManager.red,
                                            size: 18,
                                          ),
                                    horizontalSpace(8),
                                    Text(
                                      order.pivot.quantity.toString(),
                                      style: TextStyles.font18BlackBold,
                                    ),
                                  ],
                                ),
                                verticalSpace(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order.contactId.toString(),
                                      style: TextStyles.font14BlackRegular,
                                    ),
                                    Text(
                                      'Closing stock: $closingStock',
                                      style: TextStyles.font14BlackMedium,
                                    ),
                                  ],
                                ),
                                verticalSpace(16),
                                Divider(
                                  color: ColorsManager.lightGrey,
                                  height: 0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(
      BuildContext context, Function(int) onOrderPlaced) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuantityDialog(
          product: widget.product,
          onOrderPlaced: onOrderPlaced,
        );
      },
    );
  }
}
