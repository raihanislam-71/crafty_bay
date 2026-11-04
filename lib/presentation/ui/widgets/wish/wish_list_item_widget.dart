import 'package:flutter/material.dart';
import 'package:crafty_bay/data/models/product_wish_list_model.dart';

import '../../utils/app_colors.dart';

class WishListItemWidget extends StatelessWidget {
  const WishListItemWidget({
    super.key,
    required product,
    required this.onRemove,
    this.isDeleting = false,
  }) : _product = product;

  final ProductWishListModel _product;
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
                            _product.title ?? 'Product',
                            style: textTheme.bodyLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
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
                _buildPrice(textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Price: \$${_product.price ?? '0'}',
          style: textTheme.titleSmall?.copyWith(
            color: AppColors.themeColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    final String? imageUrl = _product.image;
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
}
