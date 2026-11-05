import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/models/product_wish_list_model.dart';
import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WishListController>().getWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<WishListController>(
          builder: (wishListController) {
            return Visibility(
              visible: !wishListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: _buildWishListBody(wishListController),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWishListBody(WishListController controller) {
    if (controller.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.errorMessage!),
            const SizedBox(height: 8),
            TextButton(
              onPressed: controller.getWishList,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    final wishList = controller.wishListModel.wishList ?? [];

    if (wishList.isEmpty) {
      return const Center(
        child: Text('Your wishlist is empty'),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.getWishList,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: GridView.builder(
          itemCount: wishList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final wishItem = wishList[index];
            final ProductWishListModel? productWish = wishItem.product;

            if (productWish == null) return const SizedBox();

            final ProductModel productModel = ProductModel(
              id: productWish.id,
              title: productWish.title,
              shortDes: productWish.shortDes,
              price: productWish.price,
              discount: productWish.discount,
              discountPrice: productWish.discountPrice,
              image: productWish.image,
              stock: productWish.stock,
              star: productWish.star?.toInt(),
              remark: productWish.remark,
              categoryId: productWish.categoryId,
              brandId: productWish.brandId,
            );

            return ProductCard(product: productModel);
          },
        ),
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
