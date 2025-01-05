import 'package:flutter/material.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/cached_network_image.dart';

class ProductsListViewItem extends StatelessWidget {
  const ProductsListViewItem({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed(Routes.product, arguments: product),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyles.font14BlackMedium,
          ),
          verticalSpace(6),
        ],
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.folder_open_rounded,
            color: ColorsManager.black,
            size: 20,
          ),
          horizontalSpace(8),
          Text(
            product.category.name,
            style: TextStyles.font12BlackRegular,
          ),
        ],
      ),
      tileColor: ColorsManager.white,
      leading: CachedNetworkImageWidget(
        imageUrl: product.image ?? '',
        width: 50,
        height: 50,
      ),
      trailing: Text(
        double.tryParse(product.stock)!.toInt().toString(),
        style: TextStyles.font14BlackMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
