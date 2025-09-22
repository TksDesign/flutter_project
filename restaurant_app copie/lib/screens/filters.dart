import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/tabs.dart';
import 'package:restaurant_app/widget/main_drawer.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vega }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilter});
  final Map<Filters, bool> currentFilter;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegeterianFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  void initState() {
    super.initState();
    // pour passer les valeurs au parents tabs et mettre a jour l'etat
    _glutenFreeFilterSet = widget.currentFilter[Filters.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilter[Filters.lactoseFree]!;
    _vegeterianFreeFilterSet = widget.currentFilter[Filters.vegetarian]!;
    _veganFreeFilterSet = widget.currentFilter[Filters.vega]!;
  }

  void onSelectScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'Meals') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const TabsScreen()));
    }
  }

  Widget _buildSwitchList({
    required String title,
    required String subtitle,
    required bool currentValue,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(
      value: currentValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: onSelectScreen),
      body: PopScope<Map<Filters, bool>>(
        canPop: false, // empeche le pop automatique
        onPopInvokedWithResult: (bool dispo, Map<Filters, bool>? result) {
          if (!dispo) {
            Navigator.of(context).pop({
              Filters.glutenFree: _glutenFreeFilterSet,
              Filters.lactoseFree: _lactoseFreeFilterSet,
              Filters.vegetarian: _vegeterianFreeFilterSet,
              Filters.vega: _veganFreeFilterSet
            });
          }
          // cela permet d'accder a ces donnees apres fermeture du menu
        },
        child: Column(
          children: [
            _buildSwitchList(
                currentValue: _glutenFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenFreeFilterSet = isChecked;
                  });
                },
                title: 'Gluten-free',
                subtitle: 'Only include gluten-free meals.'),
            _buildSwitchList(
                currentValue: _veganFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _veganFreeFilterSet = isChecked;
                  });
                },
                title: 'Vegan-free',
                subtitle: 'Only Vegan gluten-free meals.'),
            _buildSwitchList(
                currentValue: _lactoseFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _lactoseFreeFilterSet = isChecked;
                  });
                },
                title: 'Lactose-free',
                subtitle: 'Only lactose gluten-free meals.'),
            _buildSwitchList(
                currentValue: _vegeterianFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _vegeterianFreeFilterSet = isChecked;
                  });
                },
                title: 'Vegetarian-free',
                subtitle: 'Only Vegetarian gluten-free meals.'),
          ],
        ),
      ),
    );
  }
}
