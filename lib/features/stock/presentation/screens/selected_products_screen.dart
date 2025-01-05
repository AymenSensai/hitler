import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/utils/assets.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/app_text_form_field.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/stock/presentation/controllers/stock_cubit.dart';
import 'package:stocks_app/features/stock/presentation/widgets/select_products_list_view.dart';

import '../../../../core/utils/scan_sku.dart';
import '../../../products/domain/entities/product_entity.dart';

class SelectedProductsScreen extends StatefulWidget {
  const SelectedProductsScreen({super.key});

  @override
  State<SelectedProductsScreen> createState() => _SelectedProductsScreenState();
}

class _SelectedProductsScreenState extends State<SelectedProductsScreen> {
  final TextEditingController _searchController = TextEditingController();

  Map<ProductEntity, int> selectedProducts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Selects Products',
        actions: [
          IconButton(
            onPressed: () => context.pop(selectedProducts),
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                ),
              ),
              verticalSpace(16),
              SelectProductsListView(
                products: context.read<StockCubit>().products,
                onProductSelected: (product, quantity) {
                  if (selectedProducts.containsKey(product)) {
                    selectedProducts[product] = quantity;
                  } else {
                    selectedProducts[product] = quantity;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
