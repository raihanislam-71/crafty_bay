import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_path.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("title od product", style: textTheme.bodyLarge),
                          _buildColorAndSize(textTheme),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete, color: Colors.grey),
                    ),
                  ],
                ),
                _buildPriceAndCounter(textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
      spacing: 8,
      children: [
        Text(
          "Color: Red",
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        Text(
          "Size: XL",
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }


  Widget _buildPriceAndCounter(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$100",
          style: textTheme.titleMedium?.copyWith(color: AppColors.themeColor),
        ),
        ItemCount(
          initialValue: 1,
          minValue: 0,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {},
        ),
      ],
    );
  }


  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        AssetsPath.dummyProductImg,
        width: 80,
        height: 80,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
