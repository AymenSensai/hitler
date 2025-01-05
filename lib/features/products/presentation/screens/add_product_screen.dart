import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/utils/cached_network_image.dart';
import 'package:stocks_app/core/utils/error_snackbar.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/app_text_dropdown_field.dart';
import 'package:stocks_app/core/widgets/app_text_form_field.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';
import 'package:stocks_app/features/products/presentation/widgets/category_dialog.dart';

import '../../../../core/utils/scan_sku.dart';
import '../../data/remote/models/product_request_body.dart';
import '../controllers/products_state.dart';
import '../widgets/products_bloc_listener.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, this.product});

  final ProductEntity? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _reorderPointController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();

  File? _productImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final product = widget.product!;
      _nameController.text = product.name;
      _skuController.text = product.sku;
      _stockController.text = product.stock.toString();
      _reorderPointController.text =
          double.parse(product.reorderPoint).toInt().toString();
      _sellingPriceController.text = product.sellingPrice;
      _costPriceController.text = product.costPrice;
      _categoryController.text = product.category.name;
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _productImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      if (_productImage == null && widget.product == null) {
        errorSnackbar(context, 'Product image is required');
      } else {
        if (widget.product == null) {
          context.read<ProductsCubit>().addProduct(
                ProductRequestBody(
                  name: _nameController.text,
                  sku: _skuController.text,
                  stock: int.parse(_stockController.text),
                  reorderPoint: int.parse(_reorderPointController.text),
                  category: _categoryController.text,
                  sellingPrice: _sellingPriceController.text,
                  costPrice: _costPriceController.text,
                  image: _productImage!,
                ),
              );
        } else {
          context.read<ProductsCubit>().updateProduct(
                ProductRequestBody(
                  id: widget.product!.id,
                  name: _nameController.text,
                  sku: _skuController.text,
                  stock: int.parse(_stockController.text),
                  reorderPoint: int.parse(_reorderPointController.text),
                  category: _categoryController.text,
                  sellingPrice: _sellingPriceController.text,
                  costPrice: _costPriceController.text,
                  image: _productImage!,
                ),
              );
        }
      }
    }
  }

  void showCategoryDialog(void Function(String) onAddCategory) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryDialog(
          onAddCategory: onAddCategory,
        );
      },
    );
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
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: ColorsManager.white,
                    ),
                    child: widget.product?.image != null
                        ? CachedNetworkImageWidget(
                            imageUrl: widget.product!.image!,
                          )
                        : _productImage != null
                            ? Image.file(_productImage!, fit: BoxFit.cover)
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image,
                                        size: 50, color: Colors.grey),
                                    Text(
                                      'Tap to upload image',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                  ),
                ),
                verticalSpace(16),
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
                      final scannedSKU = await scanSKU();
                      if (scannedSKU != null) {
                        _skuController.text = scannedSKU;
                      }
                    },
                  ),
                ),
                verticalSpace(16),
                if (widget.product == null) ...[
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  verticalSpace(16),
                ],
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
                BlocBuilder<ProductsCubit, ProductsState>(
                  buildWhen: (previous, current) =>
                      current is GetCategoriesSuccess,
                  builder: (context, state) {
                    return AppTextDropdownField(
                      initialValue: widget.product?.category.name,
                      dropdownList: context.read<ProductsCubit>().categories,
                      hintText: 'Category',
                      validator: (value) =>
                          value!.isEmpty ? 'Category is required' : null,
                      onValueChanged: (value) {
                        _categoryController.text = value!;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => showCategoryDialog(
                          (category) {
                            context.read<ProductsCubit>().addCategory(category);
                          },
                        ),
                      ),
                    );
                  },
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                AddProductBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
