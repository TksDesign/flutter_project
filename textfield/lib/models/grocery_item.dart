import 'package:textfield/models/Category.dart';

class GroceryItem {
   GroceryItem({ required this.id, required this.name, required this.quantite, required this.category});
  final String id;
  final String name;
  final int quantite;
  final Category category;
}
