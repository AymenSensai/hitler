import 'package:flutter/material.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class SelectProductsListViewItem extends StatelessWidget {
  const SelectProductsListViewItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed(Routes.product, arguments: product),
      title: Text(
        product.name,
        style: TextStyles.font14BlackMedium,
      ),
      subtitle: Text(
        "${product.sku} | ${product.costPrice}",
        style: TextStyles.font12GreyRegular,
      ),
      leading: CircleAvatar(
        backgroundColor: ColorsManager.blue.withValues(alpha: 0.1),
        child: Text(
          product.id.toString(),
          style: TextStyles.font14BlueMedium,
        ),
      ),
    );
  }
}
