import 'package:flutter/material.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/cached_network_image.dart';

class SelectProductsListViewItem extends StatefulWidget {
  const SelectProductsListViewItem({
    super.key,
    required this.product,
    required this.onProductSelected,
  });

  final ProductEntity product;
  final Function(ProductEntity, int) onProductSelected;

  @override
  State<SelectProductsListViewItem> createState() =>
      _SelectProductsListViewItemState();
}

class _SelectProductsListViewItemState
    extends State<SelectProductsListViewItem> {
  int number = 0;

  void increment() {
    setState(() {
      number++;
      widget.onProductSelected(widget.product, number);
    });
  }

  void decrement() {
    setState(() {
      number--;
      widget.onProductSelected(widget.product, number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.product.name,
        style: TextStyles.font14BlackMedium,
      ),
      tileColor: ColorsManager.white,
      subtitle: Text(
        widget.product.stock,
        style: TextStyles.font12GreyRegular,
      ),
      leading: CachedNetworkImageWidget(
        imageUrl: widget.product.image ?? '',
        width: 50,
        height: 50,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: decrement,
          ),
          Text(
            '$number',
            style: TextStyles.font14BlackMedium,
          ),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: increment,
          ),
        ],
      ),
    );
  }
}
