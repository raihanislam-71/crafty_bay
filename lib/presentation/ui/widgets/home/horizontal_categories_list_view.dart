import 'package:crafty_bay/data/models/category_model.dart';
import 'package:flutter/material.dart';
import '../category_card.dart';


class HorizontalCategoriesListView extends StatelessWidget {
  const HorizontalCategoriesListView({
    super.key, required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return CategoryCard(categoryModel: categoryList[index],);
      },
      separatorBuilder: (_, _) => const SizedBox(width: 8),
    );
  }
}
