import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/history/presentation/controllers/history_cubit.dart';
import 'package:stocks_app/features/products/domain/entities/category_entity.dart';
import 'package:stocks_app/features/products/presentation/widgets/products_list_view_item.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/show_delete_confirmation_dialog.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/history_entity.dart';
import '../widgets/history_bloc_listener.dart';

class UpdateStockDetailsScreen extends StatelessWidget {
  const UpdateStockDetailsScreen({super.key, required this.order});

  final HistoryEntity order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Update Stock Details',
        actions: [
          IconButton(
            onPressed: () => showDeleteConfirmationDialog(
              context,
              () => context.read<HistoryCubit>().deleteOrders(order.id),
              'Are you sure you want to delete this product?',
            ),
            icon: SvgPicture.asset(Assets.trash),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stock Flow',
                          style: TextStyles.font14BlackRegular,
                        ),
                        verticalSpace(4),
                        Row(
                          children: [
                            order.products.firstOrNull!.pivot.quantity > -1
                                ? Icon(
                                    Icons.arrow_upward_outlined,
                                    color: Colors.green,
                                    size: 24,
                                  )
                                : Icon(
                                    Icons.arrow_downward_outlined,
                                    color: ColorsManager.red,
                                    size: 24,
                                  ),
                            horizontalSpace(16),
                            Text(
                              order.products.firstOrNull?.pivot.quantity
                                      .toString() ??
                                  '0',
                              style: TextStyles.font18BlackBold,
                            ),
                          ],
                        ),
                        verticalSpace(4),
                        Text(
                          order.formattedTransactionDate,
                          style: TextStyles.font14BlackRegular,
                        ),
                      ],
                    ),
                    horizontalSpace(70),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Products',
                          style: TextStyles.font14BlackRegular,
                        ),
                        verticalSpace(4),
                        Text(
                          order.products.length.toString(),
                          style: TextStyles.font18BlackBold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
              ...order.products.map((product) {
                return ProductsListViewItem(
                  product: ProductEntity(
                    id: product.id,
                    name: product.name,
                    sku: product.sku,
                    image: product.image,
                    stock: product.pivot.quantity.toString(),
                    reorderPoint: product.reorderPoint,
                    sellingPrice: product.sellingPrice,
                    costPrice: product.costPrice,
                    category: CategoryEntity(name: '', id: product.categoryId),
                    orders: [],
                  ),
                );
              }),
              HistoryBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
