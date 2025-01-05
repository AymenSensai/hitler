import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/cached_network_image.dart';
import '../../../../core/widgets/app_text_button.dart';

class QuantityDialog extends StatefulWidget {
  const QuantityDialog(
      {super.key, required this.product, required this.onOrderPlaced});

  final ProductEntity product;
  final Function(int) onOrderPlaced;

  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select Quantity', style: TextStyles.font16BlackRegular),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CachedNetworkImageWidget(
                imageUrl: widget.product.image ?? '',
                width: 40.h,
                height: 40.h,
              ),
              horizontalSpace(16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  Text(
                    'Available Stock: ${widget.product.stock}',
                    style: TextStyles.font12BlackMedium,
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(16.h),
          Row(
            children: [
              Text(
                'Stock Out',
                style: TextStyles.font14BlackRegular,
              ),
              IconButton(
                onPressed: () {
                  setState(() => quantity--);
                },
                icon: Icon(Icons.remove),
              ),
              Text(
                quantity.toString(),
                style: TextStyles.font14BlackMedium,
              ),
              IconButton(
                onPressed: () {
                  setState(() => quantity++);
                },
                icon: Icon(Icons.add),
              ),
              Text(
                'Stock In',
                style: TextStyles.font14BlackRegular,
              ),
            ],
          ),
          Text('Quantity', style: TextStyles.font14BlackRegular),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppTextButton(
          onPressed: () => widget.onOrderPlaced(quantity),
          buttonText: 'OK',
          buttonWidth: 100.w,
          buttonHeight: 50.h,
          borderRadius: 32,
        ),
      ],
    );
  }
}
