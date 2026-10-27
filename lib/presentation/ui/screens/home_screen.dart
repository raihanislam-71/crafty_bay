import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/slider_banner_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SearchTextField(textEditingController: TextEditingController()),
              const SizedBox(height: 16),
              GetBuilder<SliderListController>(
                builder: (sliderListController) {
                  return Visibility(
                    visible: !sliderListController.inProgress,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: HomeBannerSlider(sliderList: sliderListController.sliderList,));
                }
              ),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              _buildPopularProductSection(),
              const SizedBox(height: 16),
              _buildNewProductSection(),
              const SizedBox(height: 16),
              _buildSpecialProductSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'Popular', onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<PopularProductListController>(
            builder: (popularProductListController) {
              return Visibility(
                visible: !popularProductListController.inProgress,
                replacement: const CenteredCircularProgressIndicator(),
                child: HorizontalProductListView(productList: popularProductListController.productList,),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'New', onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<NewProductListController>(
            builder: (newProductListController) {
              return Visibility(
                visible: !newProductListController.inProgress,
                replacement: const CenteredCircularProgressIndicator(),
                child: HorizontalProductListView(productList: newProductListController.productList,),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'Special', onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<SpecialProductListController>(
            builder: (specialProductListController) {
              return Visibility(
                visible: !specialProductListController.inProgress,
                replacement: const CenteredCircularProgressIndicator(),
                child: HorizontalProductListView(productList: specialProductListController.productList,),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          onTap: () {
            Get.find<BottomNavBarController>().selectCategory();
          },
        ),
        const SizedBox(height: 8),
         SizedBox(height: 120, child: GetBuilder<CategoryListController>(
           builder: (categoryListController) {
             return Visibility(
               visible: !categoryListController.inProgress,
                 replacement: const CenteredCircularProgressIndicator(),
                 child: HorizontalCategoriesListView(categoryList: categoryListController.categoryList,));
           }
         )),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPath.appLogoNav),
      actions: [
        AppbarIconButton(iconData: Icons.person, onTap: () {}),
        const SizedBox(width: 8),
        AppbarIconButton(iconData: Icons.call, onTap: () {}),
        const SizedBox(width: 8),
        AppbarIconButton(iconData: Icons.notifications_active, onTap: () {}),
      ],
    );
  }
}


