import 'package:crafty_bay/presentation/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryListScreens extends StatelessWidget {
  const CategoryListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index){
          return const CategoryCard();
        },
      ),
    );
  }
}
