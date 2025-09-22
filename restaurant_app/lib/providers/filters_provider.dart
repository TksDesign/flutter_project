import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/providers/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vega }

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vega: false,
        });

  void setFilters(Map<Filters, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filtersMealProvider = Provider((ref) {
  final meal = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filtersProvider);
  return meal.where((meal) {
    if (activeFilter[Filters.glutenFree]! && !meal.isGluttenFree) {
      return false;
    }
    if (activeFilter[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Filters.vegetarian]! && !meal.isVegeterian) {
      return false;
    }
    if (activeFilter[Filters.vega]! && !meal.isVegan) {
      return false;
    }
    return true; // pour concerver les autres listes
  }).toList();
});
