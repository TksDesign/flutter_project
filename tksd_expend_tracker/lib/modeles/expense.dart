import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = const Uuid();
// instantiation de uuid
final formater = DateFormat.yMd();

enum Category { foods, travel, leisure, work }

const categoryIcons = {
  Category.foods: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};
const categoryColors = {
  Category.foods: Colors.blue,
  Category.travel: Colors.orange,
  Category.leisure: Colors.purple,
  Category.work: Colors.grey,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; // Ajout d'une catégorie pour la dépense

  String get formateDate {
    return formater.format(date);
  }

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // Génération d'un identifiant unique pour chaque dépense
}


// pour l'affichage graphique

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenses = allExpense.where((e) => e.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
