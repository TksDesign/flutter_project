import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ToggleKeyboardPage());
  }
}

class ToggleKeyboardPage extends StatefulWidget {
  @override
  State<ToggleKeyboardPage> createState() => _ToggleKeyboardPageState();
}

class _ToggleKeyboardPageState extends State<ToggleKeyboardPage> {
  String input = "";
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _noteFocus = FocusNode();

  bool showCustomKeyboard = false;

  @override
  void initState() {
    super.initState();
    _noteFocus.addListener(() {
      if (_noteFocus.hasFocus) {
        setState(() {
          showCustomKeyboard = false;
        });
      }
    });
  }

  void onKeyTap(String value) {
    setState(() {
      if (value == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else {
        input += value;
      }
    });
  }

  Widget buildKey(String label) {
    return GestureDetector(
      onTap: () => onKeyTap(label),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "\$",
      "0",
      ".",
      "⌫"
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Clavier personnalisé")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              focusNode: _noteFocus,
              controller: _noteController,
              decoration: InputDecoration(
                labelText: "Notes (utilise le clavier du téléphone)",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // fermer le clavier du téléphone
              setState(() {
                showCustomKeyboard = true;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text("Montant: \$", style: TextStyle(fontSize: 18)),
                  Text(input,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          if (showCustomKeyboard)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(20),
                children: keys.map((k) => buildKey(k)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

// enum Category { foods, travel, leisure, work }

// const categoryColors = {
//   Category.foods: Colors.blue,
//   Category.travel: Colors.orange,
//   Category.leisure: Colors.purple,
//   Category.work: Colors.green,
// };

// class Expense {
//   final double amount;
//   final Category category;
//   final DateTime date;

//   Expense({required this.amount, required this.category, required this.date});
// }

// class StackedDailyChart extends StatelessWidget {
//   final List<Expense> expenses;
//   final List<DateTime> days;

//   const StackedDailyChart({super.key, required this.expenses, required this.days});

//   @override
//   Widget build(BuildContext context) {
//     final formatter = DateFormat.E(); // abrégé du jour

//     // Totaux par jour et par catégorie
//     Map<DateTime, Map<Category, double>> totals = {};
//     for (var day in days) {
//       final dailyExpenses = expenses.where((e) =>
//           e.date.year == day.year &&
//           e.date.month == day.month &&
//           e.date.day == day.day);
//       totals[day] = {};
//       for (var cat in Category.values) {
//         totals[day]![cat] =
//             dailyExpenses.where((e) => e.category == cat).fold(0.0, (a, b) => a + b.amount);
//       }
//     }

//     // Trouver le montant max pour normaliser la hauteur
//     double maxTotal = 0;
//     for (var dayTotals in totals.values) {
//       final daySum = dayTotals.values.fold(0.0, (a, b) => a + b);
//       if (daySum > maxTotal) maxTotal = daySum;
//     }
//     if (maxTotal == 0) maxTotal = 1; // éviter div par 0

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: days.map((day) {
//         final dayTotals = totals[day]!;
//         double cumulativeHeight = 0;

//         return Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Stack(
//               alignment: Alignment.bottomCenter,
//               children: dayTotals.entries.map((entry) {
//                 final barHeight = (entry.value / maxTotal) * 150;
//                 cumulativeHeight += barHeight;
//                 return Container(
//                   width: 20,
//                   height: barHeight,
//                   color: categoryColors[entry.key],
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 8),
//             Text(formatter.format(day)), // Mon, Tue ...
//           ],
//         );
//       }).toList(),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: const Text("Stacked Daily Chart")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: StackedDailyChart(
//           days: List.generate(7, (i) => DateTime.now().subtract(Duration(days: 6 - i))),
//           expenses: [
//             Expense(amount: 50, category: Category.foods, date: DateTime.now().subtract(const Duration(days: 6))),
//             Expense(amount: 30, category: Category.travel, date: DateTime.now().subtract(const Duration(days: 6))),
//             Expense(amount: 20, category: Category.leisure, date: DateTime.now().subtract(const Duration(days: 5))),
//             Expense(amount: 15, category: Category.work, date: DateTime.now().subtract(const Duration(days: 5))),
//             Expense(amount: 40, category: Category.foods, date: DateTime.now().subtract(const Duration(days: 4))),
//             Expense(amount: 25, category: Category.travel, date: DateTime.now().subtract(const Duration(days: 4))),
//           ],
//         ),
//       ),
//     ),
//   ));
// }
