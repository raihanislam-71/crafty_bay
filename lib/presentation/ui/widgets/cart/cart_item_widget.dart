import 'package:flutter/material.dart';
import 'package:crafty_bay/data/models/cart_item_model.dart';

import '../../utils/app_colors.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
    this.isDeleting = false,
  });

  final CartItemModel item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;
  final bool isDeleting;

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
                          Text(
                            item.product?.title ?? 'Product',
                            style: textTheme.bodyLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          _buildColorAndSize(textTheme),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: isDeleting ? null : onRemove,
                      icon: isDeleting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.delete, color: Colors.grey),
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
          "Color: ${item.color ?? 'N/A'}",
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        Text(
          "Size: ${item.size ?? 'N/A'}",
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceAndCounter(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unit: ${_formatPrice(item.unitPrice)}',
              style: textTheme.bodySmall,
            ),
            Text(
              'Total: ${_formatPrice(item.totalPrice)}',
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.themeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: item.quantity > 1
                  ? () => onQuantityChanged(item.quantity - 1)
                  : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: AppColors.themeColor,
            ),
            Text('${item.quantity}', style: textTheme.titleSmall),
            IconButton(
              onPressed: () => onQuantityChanged(item.quantity + 1),
              icon: const Icon(Icons.add_circle_outline),
              color: AppColors.themeColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    final String? imageUrl = item.product?.image;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: (imageUrl == null || imageUrl.isEmpty)
            ? const Icon(Icons.image_not_supported_outlined, size: 40)
            : Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.image_not_supported_outlined, size: 40),
              ),
      ),
    );
  }

  String _formatPrice(num price) =>
      '\$${price % 1 == 0 ? price.toStringAsFixed(0) : price.toStringAsFixed(2)}';
}
