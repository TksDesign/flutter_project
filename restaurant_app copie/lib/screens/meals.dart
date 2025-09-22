import 'package:flutter/material.dart';
import 'package:restaurant_app/models/meal.dart';
import 'package:restaurant_app/screens/meal_detail.dart';
import 'package:restaurant_app/widget/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.meals,
      this.title,
      required this.onToggleFavorite,
      required this.isFavorite});
  final List<Meal> meals;
  final String? title;
  final void Function(Meal meal) onToggleFavorite;
  final bool Function(Meal meal) isFavorite;

  void SelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetail(
              isFavorite: isFavorite,
              onToggleFavorite: onToggleFavorite,
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      width: 600,
      child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealsItem(
               
                meal: meals[index],
                onSelectMeal: (meal) {
                  SelectMeal(context, meal);
                },
              )),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Cette liste..... est vide',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(
              height: 16,
            ),
            Text(
              'try selecting category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: content,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
