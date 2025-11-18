// main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tksquizzz/core/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/core/widgets/auth_loading.dart';
import 'package:tksquizzz/features/auth/application/providers/auth_providers.dart';
import 'package:tksquizzz/features/auth/presentation/pages/login_page.dart';
import 'package:tksquizzz/features/auth/presentation/pages/new_password_page.dart';
import 'package:tksquizzz/features/home/application/providers/navigation_provider.dart';
import 'package:tksquizzz/features/home/presentation/pages/home_page.dart';
import 'package:tksquizzz/features/home/presentation/pages/categories_page.dart';
import 'package:tksquizzz/features/home/presentation/pages/leaderboard_page.dart';
import 'package:tksquizzz/features/home/presentation/pages/profile_page.dart';
import 'package:tksquizzz/features/home/presentation/pages/quiz/quiz_detail_page.dart';

// Clé globale pour la navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabseAnonkey,
  );

  // Réception du token
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;
    if (event == AuthChangeEvent.passwordRecovery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NewPasswordPage()),
          (route) => false,
        );
      });
    }
  });

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const AppWrapper(),
    );
  }
}

// Wrapper principal qui gère l'authentification ET la navigation
class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const MainNavigationWrapper();
        } else {
          return const LoginPage();
        }
      },
      loading: () => const AuthLoadingScreen(),
      error: (error, stack) {
        print('Erreur AuthWrapper: $error');
        return const LoginPage();
      },
    );
  }
}

// Wrapper qui gère la navigation principale
class MainNavigationWrapper extends ConsumerWidget {
  const MainNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNav = ref.watch(navigationProvider);

    return Scaffold(
      body: _buildPage(currentNav),
      bottomNavigationBar: _buildBottomNavBar(ref, currentNav),
    );
  }

  // Construire la page en fonction de la navigation
  Widget _buildPage(NavigationState state) {
    switch (state.currentItem) {
      case NavItem.home:
        return const HomePage();
      case NavItem.categories:
        return const CategoriesPage();
      case NavItem.leaderboard:
        return const LeaderboardPage();
      case NavItem.profile:
        return const ProfilePage();
      case NavItem.quizDetail:
        return const QuizDetailPage();
    }
  }

  // Construire la barre de navigation
  Widget _buildBottomNavBar(WidgetRef ref, NavigationState state) {
    final bottomNavItems = [
      NavItem.home,
      NavItem.categories,
      NavItem.leaderboard,
      NavItem.profile,
    ];
    final currentIndex = _getCurrentIndex(state.currentItem, bottomNavItems);
    return BottomNavigationBar(
      currentIndex: currentIndex, // state.currentItem.index
      onTap: (index) {
        final newNav = bottomNavItems[index];

        //  Créer un NavigationState au lieu de NavItem
        ref.read(navigationProvider.notifier).state = NavigationState(
          currentItem: newNav,
          arguments: {}, // Reset les arguments quand on change de page principale
        );
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: 'Ranking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
  // unselectedItemColor: Colors.grey,
  //     items: NavItem.values.map((nav) {
  //       return BottomNavigationBarItem(
  //         icon: Icon(nav.icon),
  //         label: nav.label,
  //       );
  //     }).toList(),

  int _getCurrentIndex(NavItem currentItem, List<NavItem> bottomNavItems) {
    // Si on est sur une page de la BottomNav, retourner son index
    if (bottomNavItems.contains(currentItem)) {
      return bottomNavItems.indexOf(currentItem);
    }
    // 🎯 CORRECTION : Si on est sur QuizDetail, montrer categorie comme actif
    return 1; // Home comme page active par défaut
  }
}
