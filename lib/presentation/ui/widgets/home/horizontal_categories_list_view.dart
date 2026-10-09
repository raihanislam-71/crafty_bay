import 'package:flutter/material.dart';
import '../category_card.dart';


class HorizontalCategoriesListView extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const CategoryCard();
      },
      separatorBuilder: (_, _) => const SizedBox(width: 8),
    );
  }
}
