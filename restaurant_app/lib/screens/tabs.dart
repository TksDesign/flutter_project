import 'package:flutter/material.dart';
// import 'package:restaurant_app/models/meal.dart';
import 'package:restaurant_app/screens/categories.dart';
import 'package:restaurant_app/screens/filters.dart';
import 'package:restaurant_app/screens/meals.dart';
import 'package:restaurant_app/widget/main_drawer.dart';
// importatioon du provider
// import 'package:restaurant_app/providers/meals_provider.dart';
import 'package:restaurant_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// filter
import 'package:restaurant_app/providers/filters_provider.dart';

const kInitialFilter = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vega: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void onSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
      // result recupere les differents filtre du screen filter
    }
    ;
  }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // observons les changement sur une valeur
    // final meal = ref.watch(mealsProvider);
    // creeons une liste deja filtrer que nous passons a Catogorie

    // pour ecouter le filter
    // final activeFilter = ref.watch(filtersProvider);

    final availableMeals = ref.watch(filtersMealProvider);
    Widget pageScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    final favoriteMeals = ref.watch(favoriteMealsProvide);
    if (_selectedPageIndex == 1) {
      pageScreen = MealsScreen(
        meals: favoriteMeals,
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
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favories'),
          ]),
    );
  }
}
