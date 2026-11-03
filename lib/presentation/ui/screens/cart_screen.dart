import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/bottom_nav_bar_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/cart/cart_item_widget.dart';
import '../widgets/centered_circular_progress_indicator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            return Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: !cartListController.inProgress,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: _buildCartList(cartListController),
                  ),
                ),
                _buildPriceAndAddToCartSection(cartListController),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartList(CartListController controller) {
    if (controller.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.errorMessage!),
            const SizedBox(height: 8),
            TextButton(
              onPressed: controller.getCartList,
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }

    if (controller.cartList.isEmpty) {
      return const Center(child: Text('Your cart is empty'));
    }

    return RefreshIndicator(
      onRefresh: controller.getCartList,
      child: ListView.builder(
        itemCount: controller.cartList.length,
        itemBuilder: (context, index) {
          final item = controller.cartList[index];
          return GetBuilder<DeleteCartController>(
            builder: (deleteCartController) {
              return CartItemWidget(
                key: ValueKey(item.id),
                item: item,
                onQuantityChanged: (quantity) {
                  controller.updateQuantity(item.id!, quantity);
                },
                isDeleting: deleteCartController.isDeleting(item.id),
                onRemove: () =>
                    _onRemoveCartItem(deleteCartController, controller, item),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(CartListController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Prices'),
              Text(
                _formatPrice(controller.totalPrice),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: _onTapCheckOutButton,
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapCheckOutButton() {
    Get.to(() => const PaymentDetailsScreen());
  }

  Future<void> _onRemoveCartItem(
    DeleteCartController deleteCartController,
    CartListController controller,
    CartItemModel item,
  ) async {
    final int? itemId = item.id;
    if (itemId == null) return;

    final bool isDeleted = await deleteCartController.deleteCartItem(
      itemId,
      productId: item.productId ?? item.product?.id,
    );
    if (isDeleted) {
      controller.removeItem(itemId);
      await controller.getCartList();
      if (mounted) {
        showSnackBarMessage(context, 'Item removed from cart');
      }
      return;
    }

    if (!isDeleted && mounted) {
      showSnackBarMessage(
        context,
        deleteCartController.errorMessage ?? 'Delete failed',
        true,
      );
    }
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }

  String _formatPrice(num price) =>
      '\$${price % 1 == 0 ? price.toStringAsFixed(0) : price.toStringAsFixed(2)}';
}
