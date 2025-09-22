import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/data/dummy_data.dart';

// mise en place d'un fournisseur puis je me rend dans tabs
final mealsProvider = Provider((ref) {
  return dumMeals; 
});
