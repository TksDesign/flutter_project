import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tksd_expend_tracker/modeles/expense.dart';

class StackedDailyChart extends StatelessWidget {
  final List<Expense> expenses;
  final List<DateTime> days;

  const StackedDailyChart(
      {super.key, required this.expenses, required this.days});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.E(); // abrégé du jour

    // Totaux par jour et par catégorie
    Map<DateTime, Map<Category, double>> totals = {};
    for (var day in days) {
      final dailyExpenses = expenses.where((e) =>
          e.date.year == day.year &&
          e.date.month == day.month &&
          e.date.day == day.day);
      totals[day] = {};
      for (var cat in Category.values) {
        totals[day]![cat] = dailyExpenses
            .where((e) => e.category == cat)
            .fold(0.0, (a, b) => a + b.amount);
      }
    }

    // Trouver le montant max pour normaliser la hauteur
    double maxTotal = 0;
    for (var dayTotals in totals.values) {
      final daySum = dayTotals.values.fold(0.0, (a, b) => a + b);
      if (daySum > maxTotal) maxTotal = daySum;
    }
    if (maxTotal == 0) maxTotal = 1; // éviter div par 0

    return Stack(
      alignment: Alignment(0, -0.3),
      children: [
        Container(
          height: 3,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days.map((day) {
            final dayTotals = totals[day]!;
            final categories = dayTotals.entries.toList();

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 150, // hauteur fixe
                  width: 40,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: double.infinity,
                        width: 1,
                        color: const Color.fromARGB(98, 103, 142, 149),
                      ),
                      for (var i = 0; i < categories.length; i++)
                        Positioned(
                          bottom: categories.take(i).fold(0.0,
                              (sum, e) => sum! + (e.value / maxTotal) * 40),
                          child: Container(
                            width: 30,
                            height: (categories[i].value / maxTotal) * 40,
                            decoration: BoxDecoration(
                              color: categoryColors[categories[i].key],
                              borderRadius: i == categories.length - 1
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    )
                                  : BorderRadius.zero,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(formatter.format(day)), // Mon, Tue ...
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
