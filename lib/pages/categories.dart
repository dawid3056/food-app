import 'package:flutter/material.dart';
import 'package:food_app/data/data.dart';
import 'package:food_app/pages/meals.dart';
import 'package:food_app/widgets/category_grid_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MealsPage(meals: [], title: 'title'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick your category',
        ),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectCategory(context),
            ),
        ],
      ),
    );
  }
}
