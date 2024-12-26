import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/assets.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Product Details',
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.trash),
          ),
          IconButton(
            onPressed: () => context.pushNamed(
              Routes.addProduct,
              arguments: product,
            ),
            icon: SvgPicture.asset(Assets.pen),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name),
            Text('${product.openingStock}'),
            Text('Category: ${product.category}'),
            Text('Reorder Point: ${product.reorderPoint}'),
            Text('SKU#: ${product.sku}'),
            Text('Selling Price(DZD): ${product.sellingPrice}'),
            Text('Cost Price(DZD): ${product.costPrice}'),
          ],
        ),
      ),
    );
  }
}
