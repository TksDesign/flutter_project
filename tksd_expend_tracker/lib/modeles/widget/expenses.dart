import 'package:flutter/material.dart';
import 'package:tksd_expend_tracker/modeles/widget/StackedDailyChart.dart';
import 'package:tksd_expend_tracker/modeles/widget/expense_list/expense_list.dart';
import 'package:tksd_expend_tracker/modeles/expense.dart';
import 'package:tksd_expend_tracker/modeles/widget/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'resataut',
        amount: 8225,
        date: DateTime.now().subtract(Duration(days: 3)),
        category: Category.foods),
    Expense(
        title: 'flutter course',
        amount: 1229,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'cinema',
        amount: 12225,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'transport',
        amount: 5225,
        date: DateTime.now().subtract(Duration(days: 1)),
        category: Category.work),
    Expense(
        title: 'fast & firious',
        amount: 8225,
        date: DateTime.now().subtract(Duration(days: 2)),
        category: Category.leisure),
    Expense(
        title: 'aas',
        amount: 4225,
        date: DateTime.now().subtract(Duration(days: 3)),
        category: Category.work),
    Expense(
        title: 'balade',
        amount: 4225,
        date: DateTime.now().subtract(Duration(days: 4)),
        category: Category.leisure),
    Expense(
        title: 'dormir',
        amount: 14225,
        date: DateTime.now().subtract(Duration(days: 5)),
        category: Category.work)
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
        // pour le chevauchement d'element
        useSafeArea: true,
        // pour avoir l'espace lors de l'ouverture
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  // pour ajouter les elements
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // remove item

  void _removeExpense(Expense expense) {
    // pour obtenir l'index
    final expensesIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 3000),
      content: const Text('Expense delete'),
      action: SnackBarAction(
          label: 'Annuler',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expensesIndex, expense);
            });
          }),
    ));
  }

  List<String> FilterOption = ["Day", "Week", "Month", "Year"];

  int? _indexSelectione;

  Widget outline(String label, int index) {
    final isSelect = _indexSelectione == index;
    return Container(
      padding: EdgeInsets.fromLTRB(9.5, 0, 9.4, 0),
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1, color: Colors.grey),
          ),
          borderRadius: BorderRadius.circular(2),
          color: isSelect ? Colors.white : Colors.transparent),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _indexSelectione = index;
          });
        },
        child: Text(
          label,
          style: TextStyle(
              fontSize: 9,
              color: isSelect
                  ? Colors.green
                  : const Color.fromARGB(255, 123, 123, 123)),
        ),
        style: OutlinedButton.styleFrom(
            side: BorderSide(width: 0, color: Colors.transparent),
            shape: RoundedRectangleBorder(),
            backgroundColor: Colors.transparent),
      ),
    );
  }

  double get totalAmount {
    return _registeredExpenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget mainContent = const Center(
      child: Text('no expenses found. Start adding me'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Padding(
        padding: const EdgeInsets.all(12.0),
        child: ExpenseList(
            expenses: _registeredExpenses, onRemoveExpenses: _removeExpense),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Expenses Tracker'),
          actions: [
            IconButton(onPressed: openAddExpenseOverlay, icon: Icon(Icons.add))
          ],
        ),
        body: width < 660
            ? Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 220, 220),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(FilterOption.length,
                                        (index) {
                                      return Expanded(
                                          child: outline(
                                              FilterOption[index], index));
                                    })),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_indexSelectione == null
                                      ? 'This week'
                                      : "This ${FilterOption[_indexSelectione!]}"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '-' + totalAmount.toString() + 'xaf',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        StackedDailyChart(
                            expenses: _registeredExpenses,
                            days: List.generate(
                                7,
                                (i) => DateTime.now()
                                    .subtract(Duration(days: 6 - i)))),
                      ],
                    ),
                  ),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 220, 220),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(FilterOption.length,
                                        (index) {
                                      return Expanded(
                                          child: outline(
                                              FilterOption[index], index));
                                    })),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_indexSelectione == null
                                      ? 'This week'
                                      : "This ${FilterOption[_indexSelectione!]}"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '-' + totalAmount.toString() + 'xaf',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        StackedDailyChart(
                            expenses: _registeredExpenses,
                            days: List.generate(
                                7,
                                (i) => DateTime.now()
                                    .subtract(Duration(days: 6 - i)))),
                      ],
                    ),
                  ),
                  Expanded(child: mainContent)
                ],
              ));
  }
}
