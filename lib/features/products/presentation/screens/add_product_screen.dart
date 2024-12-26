import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/app_text_form_field.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, this.product});

  final ProductEntity? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _stockController = TextEditingController();
  final _reorderPointController = TextEditingController();
  final _categoryController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _costPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final product = widget.product!;
      _nameController.text = product.name;
      _skuController.text = product.sku;
      _stockController.text = product.openingStock.toString();
      _reorderPointController.text = product.reorderPoint.toString();
      _categoryController.text = product.category;
      _sellingPriceController.text = product.sellingPrice;
      _costPriceController.text = product.costPrice;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _stockController.dispose();
    _reorderPointController.dispose();
    _categoryController.dispose();
    _sellingPriceController.dispose();
    _costPriceController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      context.read<ProductsCubit>().addProduct(
            ProductEntity(
              name: _nameController.text,
              sku: _skuController.text,
              openingStock: int.parse(_stockController.text),
              reorderPoint: int.parse(_reorderPointController.text),
              category: _categoryController.text,
              sellingPrice: _sellingPriceController.text,
              costPrice: _costPriceController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Add Product',
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  validator: (value) =>
                      value!.isEmpty ? 'Product Name is required' : null,
                  controller: _nameController,
                  hintText: 'Product Name',
                ),
                verticalSpace(16),
                AppTextField(
                  validator: (value) =>
                      value!.isEmpty ? 'SKU is required' : null,
                  controller: _skuController,
                  hintText: 'SKU',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () async {
                      // Implement SKU scanning logic here
                      final scannedSKU = await scanSKU();
                      if (scannedSKU != null) {
                        _skuController.text = scannedSKU;
                      }
                    },
                  ),
                ),
                verticalSpace(16),
                AppTextField(
                  validator: (value) {
                    if (value!.isEmpty) return 'Opening Stock is required';
                    if (int.tryParse(value) == null) {
                      return 'Must be a valid number';
                    }
                    return null;
                  },
                  controller: _stockController,
                  hintText: 'Opening Stock',
                  keyboardType: TextInputType.number,
                ),
                verticalSpace(16),
                AppTextField(
                  validator: (value) {
                    if (value!.isEmpty) return 'Reorder Point is required';
                    if (int.tryParse(value) == null) {
                      return 'Must be a valid number';
                    }
                    return null;
                  },
                  controller: _reorderPointController,
                  hintText: 'Reorder Point',
                  keyboardType: TextInputType.number,
                ),
                verticalSpace(16),
                AppTextField(
                  validator: (value) =>
                      value!.isEmpty ? 'Category is required' : null,
                  controller: _categoryController,
                  hintText: 'Category',
                ),
                verticalSpace(16),
                AppTextField(
                  validator: (value) {
                    if (value!.isEmpty) return 'Selling Price is required';
                    if (double.tryParse(value) == null) {
                      return 'Must be a valid price';
                    }
                    return null;
                  },
                  controller: _sellingPriceController,
                  hintText: 'Selling Price (DZD)',
                  keyboardType: TextInputType.number,
                ),
                verticalSpace(16),
                AppTextField(
                  validator: (value) {
                    if (value!.isEmpty) return 'Cost Price is required';
                    if (double.tryParse(value) == null) {
                      return 'Must be a valid price';
                    }
                    return null;
                  },
                  controller: _costPriceController,
                  hintText: 'Cost Price (DZD)',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> scanSKU() async {
    try {
      var result = await BarcodeScanner.scan();
      return result.rawContent.isNotEmpty ? result.rawContent : null;
    } catch (e) {
      // Handle any exceptions
      return null;
    }
  }
}
