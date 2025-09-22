import 'package:flutter/material.dart';
import 'package:restaurant_app/models/meal.dart';
import 'package:restaurant_app/widget/meals_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;
  // pour filter la complexite et mettre s en majuscule
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1); // 'hello'+'world' = 'helloword'
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
                height: 400,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(meal.imageURL)),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis, // pour les text long
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealsItemTrait(
                                icon: Icons.schedule,
                                label: '${meal.duration.toString()} min'),
                            const SizedBox(
                              width: 8,
                            ),
                            MealsItemTrait(
                                icon: Icons.work, label: '${complexityText}'),
                            const SizedBox(
                              width: 8,
                            ),
                            MealsItemTrait(
                                icon: Icons.attach_money,
                                label: '${meal.affordability.name}')
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
