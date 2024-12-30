import 'package:flutter/material.dart';

import '../../../products/domain/entities/product_entity.dart';
import 'select_products_list_view_item.dart';

class SelectProductsListView extends StatelessWidget {
  const SelectProductsListView({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return SelectProductsListViewItem(product: product);
      },
    );
  }
}
