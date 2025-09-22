import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/models/meal.dart';


class FavoritesMealsProvider extends StateNotifier<List<Meal>> {
  FavoritesMealsProvider()
      : super(
            []); //le super dooit etre du type qui a ete define au StateNotifier

  // definissons maintenant les methodes pour d'eventuel modicifaction

  void toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // methode pour supprimer
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }

  // Fonction qui vérifie si un repas est favori
  bool isMealFavorite(Meal meal) {
    final favoriteMeals = state;
    return favoriteMeals.contains(meal);
  }
}

// on connecte notre methode
final favoriteMealsProvide =
    StateNotifierProvider<FavoritesMealsProvider, List<Meal>>((ref) {
  // extenciation de la class
  return FavoritesMealsProvider();
}); //pour gerer les donnes plus complexe dans le style dynamique
// diregeons nous maintenant vers tabs
