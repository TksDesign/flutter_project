import 'package:flutter/material.dart';
import 'package:restaurant_app/data/dummy_data.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/models/meal.dart';
import 'package:restaurant_app/screens/categories.dart';
import 'package:restaurant_app/screens/filters.dart';
import 'package:restaurant_app/screens/meals.dart';
import 'package:restaurant_app/widget/main_drawer.dart';

const kInitialFilter = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vega: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favorieMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilter;

  void _toogleMealFavoriteStatus(Meal meal) {
    final isExisting = _favorieMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favorieMeals.remove(meal);
      });
    } else {
      setState(() {
        _favorieMeals.add(meal);
      });
    }
  }

  void onSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context)
          .push<Map<Filters, bool>>(MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                    currentFilter: _selectedFilters,
                  )));
      // result recupere les differents filtre du screen filter
      setState(() {
        _selectedFilters = result ?? kInitialFilter;
      });
    }
    ;
  }

  // Fonction qui vérifie si un repas est favori
  bool _isMealFavorite(Meal meal) {
    return _favorieMeals.contains(meal);
  }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // creeons une liste deja filtrer que nous passons a Catogorie
    final availableMeals = dumMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGluttenFree) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegeterian) {
        return false;
      }
      if (_selectedFilters[Filters.vega]! && !meal.isVegan) {
        return false;
      }
      return true; // pour concerver les autres listes
    }).toList();
    Widget pageScreen = CategoriesScreen(
      availableMeals: availableMeals,
      isFavorite: _isMealFavorite,
      onToggleFavorite: _toogleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      pageScreen = MealsScreen(
        isFavorite: _isMealFavorite,
        meals: _favorieMeals,
        onToggleFavorite: _toogleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: onSelectScreen,
      ), //le tiroir
      body: pageScreen,
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favories'),
          ]),
    );
  }
}
