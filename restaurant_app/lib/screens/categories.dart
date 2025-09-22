import 'package:flutter/material.dart';
import 'package:restaurant_app/data/dummy_data.dart';
import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/meal.dart';
import 'package:restaurant_app/screens/meals.dart';
import 'package:restaurant_app/widget/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  _selectCategorie(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              meals: filteredMeals,
              title: category.title,
            )));
  }

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0, //valeur de debut
      upperBound: 1, //valeur de fin
    );

    _animationController.forward(); //pour marquer le debut de l'animation
  }

// pour effacer le cache de l'animation si jamais a cas de bug
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > 600 ? 3 : 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () =>
                    widget._selectCategorie(context, category),
              )
          ],
        ),
        builder: (context, child) {
          return Padding(
            padding:
                EdgeInsets.only(top: 100 - _animationController.value * 100),
            child: child,
          );
        });
  }
}
