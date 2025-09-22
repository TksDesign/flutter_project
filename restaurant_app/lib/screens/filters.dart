import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/screens/tabs.dart';
import 'package:restaurant_app/widget/main_drawer.dart';

// import de filter
import 'package:restaurant_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: onSelectScreen),
      body: Column(
        children: [
          _buildSwitchList(
              currentValue: activeFilters[Filters.glutenFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.glutenFree, isChecked);
              },
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.'),
          _buildSwitchList(
              currentValue: activeFilters[Filters.vega]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.vega, isChecked);
              },
              title: 'Vegan-free',
              subtitle: 'Only Vegan gluten-free meals.'),
          _buildSwitchList(
              currentValue: activeFilters[Filters.lactoseFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.lactoseFree, isChecked);
              },
              title: 'Lactose-free',
              subtitle: 'Only lactose gluten-free meals.'),
          _buildSwitchList(
              currentValue: activeFilters[Filters.vegetarian]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.vegetarian, isChecked);
              },
              title: 'Vegetarian-free',
              subtitle: 'Only Vegetarian gluten-free meals.'),
        ],
      ),
    );
  }
}
