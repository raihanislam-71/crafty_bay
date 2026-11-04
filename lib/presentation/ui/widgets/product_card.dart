import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/remove_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.showDeleteFromWishlist = false,
  });

  final ProductModel product;
  final bool showDeleteFromWishlist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(
              productId: product.id!,
            ));
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: SizedBox(
          width: 160,
          child: Column(
            children: [
              Container(
                width: 160,
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(product.image ?? ''),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? 'Product Title',
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price ?? '999'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(
                              "${product.star ?? '4.5'}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<WishListController>(
                          builder: (wishListController) {
                            final isWishlisted = wishListController.wishListModel.wishList?.any(
                                    (element) => element.productId == product.id) ??
                                false;

                            return InkWell(
                              onTap: () async {
                                final authController = Get.find<AuthController>();
                                if (!authController.isLoggedInUser()) {
                                  Get.to(() => const EmailVerificationScreen());
                                  return;
                                }

                                if (isWishlisted) {
                                  final removeController = Get.find<RemoveWishListController>();
                                  final success = await removeController.removeWishList(product.id!);
                                  if (success) {
                                    await wishListController.getWishList();
                                    if (context.mounted) {
                                      showSnackBarMessage(context, 'Removed from wishlist');
                                    }
                                  }
                                } else {
                                  final createController = Get.find<CreateWishListController>();
                                  final success = await createController.createWishList(product.id!);
                                  if (success) {
                                    await wishListController.getWishList();
                                    if (context.mounted) {
                                      showSnackBarMessage(context, 'Added to wishlist');
                                    }
                                  }
                                }
                              },
                              child: Card(
                                color: AppColors.themeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    isWishlisted ? Icons.favorite : Icons.favorite_outline_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
