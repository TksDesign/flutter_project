import 'package:flutter/material.dart';
import 'package:restaurant_app/data/dummy_data.dart';
import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/meal.dart';
import 'package:restaurant_app/screens/meals.dart';
import 'package:restaurant_app/widget/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onToggleFavorite, required this.isFavorite,required this.availableMeals});
  final void Function(Meal meal) onToggleFavorite;
  final bool Function(Meal meal) isFavorite;
  final List<Meal> availableMeals;

  _selectCategorie(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              isFavorite: isFavorite,
              meals: filteredMeals,
              title: category.title,
              onToggleFavorite: onToggleFavorite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width > 600 ? 3 : 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategorie(context, category),
          )
      ],
    );
  }
}
