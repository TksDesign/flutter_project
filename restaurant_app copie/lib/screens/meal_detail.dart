import 'package:flutter/material.dart';
import 'package:restaurant_app/models/meal.dart';

class MealDetail extends StatefulWidget {
  const MealDetail(
      {super.key,
      required this.meal,
      required this.onToggleFavorite,
      required this.isFavorite});
  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  final bool Function(Meal meal) isFavorite;
  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isFav = widget.isFavorite(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  widget.meal.imageURL,
                  height: 300,
                  width: width > 600 ? 600 : double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Colors.black38),
                    margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.onToggleFavorite(widget.meal);
                          });
                        },
                        icon: isFav
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border))),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Ingredient',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 45,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  for (final ingredient in widget.meal.ingredients)
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        ingredient,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14),
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Steps',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              child: Column(
                children: [
                  for (int i = 0; i < widget.meal.steps.length; i++)
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              "${i + 1}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              widget.meal.steps[i],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
