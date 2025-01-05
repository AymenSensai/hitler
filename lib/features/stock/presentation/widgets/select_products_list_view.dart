import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/utils/spacing.dart';

import '../../../products/domain/entities/product_entity.dart';
import 'select_products_list_view_item.dart';

class SelectProductsListView extends StatelessWidget {
  const SelectProductsListView({
    super.key,
    required this.products,
    required this.onProductSelected,
  });

  final List<ProductEntity> products;
  final Function(ProductEntity, int) onProductSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => verticalSpace(16),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        final product = products[index];
        return SelectProductsListViewItem(
          product: product,
          onProductSelected: onProductSelected,
        );
      },
    );
  }
}
