import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavItem {
  home(0, 'Home', Icons.home),
  categories(1, 'Categories', Icons.category),
  leaderboard(2, 'Ranking', Icons.leaderboard),
  profile(3, 'Profile', Icons.person),
  quizDetail(4, 'Quiz Detail', Icons.quiz);

  const NavItem(this.ind, this.label, this.icon);

  final int ind;
  final String label;
  final IconData icon;
}

class NavigationState {
  final NavItem currentItem;
  final Map<String, dynamic> arguments; //  Paramètres dynamiques
  final String? routeName; //  Nom de route optionnel

  const NavigationState({
    required this.currentItem,
    this.arguments = const {},
    this.routeName,
  });

  NavigationState copyWith({
    NavItem? currentItem,
    Map<String, dynamic>? arguments,
    String? routeName,
  }) {
    return NavigationState(
      currentItem: currentItem ?? this.currentItem,
      arguments: arguments ?? this.arguments,
      routeName: routeName ?? this.routeName,
    );
  }

// METHODE : Récupérer un argument typé
  T? getArgument<T>(String key) {
    return arguments.containsKey(key) ? arguments[key] as T : null;
  }

  // METHODE : Vérifier la présence d'un argument
  bool hasArgument(String key) {
    return arguments.containsKey(key);
  }
}

final StateProvider<NavigationState> navigationProvider = StateProvider<NavigationState>((ref) {
  return const NavigationState(currentItem: NavItem.home);
});
