import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/scan_sku.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../controllers/products_cubit.dart';
import 'products_list_view_item.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppTextField(
            validator: (_) {},
            controller: _searchController,
            hintText: 'Search Product Name, SKU',
            prefixIcon: Assets.search,
            suffixIcon: IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () async {
                final scannedSKU = await scanSKU();
                if (scannedSKU != null) {
                  _searchController.text = scannedSKU;
                }
              },
            ),
            onChanged: (query) {
              context.read<ProductsCubit>().searchProducts(query);
            },
          ),
        ),
        verticalSpace(16),
        ListView.separated(
          itemCount: widget.products.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => verticalSpace(16),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            final product = widget.products[index];
            return ProductsListViewItem(product: product);
          },
        ),
      ],
    );
  }
}
