import 'package:flutter/material.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import 'products_list_view_item.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductsListViewItem(product: product);
      },
    );
  }
}
