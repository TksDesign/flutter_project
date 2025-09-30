import 'package:textfield/models/Category.dart';
import 'package:textfield/models/grocery_item.dart';
import 'package:textfield/data/categories.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantite: 1,
      category: categories[Categorie.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Banane',
      quantite: 5,
      category: categories[Categorie.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantite: 3,
      category: categories[Categorie.vegetables]!),
];
