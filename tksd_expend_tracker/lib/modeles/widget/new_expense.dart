import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tksd_expend_tracker/modeles/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  String input = "";
  var _enteredTitle = '';
  var _enteredAmount = 0.0;
  var _titleController = TextEditingController();
  var _AmountController = TextEditingController();
  final FocusNode _noteFocus = FocusNode();
  final FocusNode _noteFocus2 = FocusNode();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.foods;
  bool showCustomKeyboard = true;

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
    _noteFocus2.addListener(() {
      if (_noteFocus2.hasFocus) {
        setState(() {
          showCustomKeyboard = true;
        });
      }
    });
  }

  void dispose() {
    _AmountController.dispose();
    _titleController.dispose();
    _noteFocus.dispose();
    super.dispose();
  } //permet a flutter de supprimer se controleur de la memoire quand le widget n'est plus utilisé

  void _saveTitleInput(String inputvalue) {
    _enteredTitle = inputvalue;
  }

  void _saveAmountInput(String inputvalue) {
    // Supprimer les + et - avant de convertir
    String cleanValue = inputvalue.replaceAll(RegExp(r'[+-]'), '');
    _enteredAmount = double.tryParse(cleanValue) ?? 0.0;
  }

  // methode pour valideer les textfields
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_AmountController.text.replaceAll(
        RegExp(r'[-+]'), '')); // tryParse(''hello)=null or tryParse('2.5')=2.5
    final amountIsInValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInValid ||
        _selectedDate == null) {
      // show error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure you entered valid title, amount, date and category'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('okay'),
                  )
                ],
              ));
      return;
      // la methode pour ajouter
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    // pour s'assurer de bien fermer
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    // pour obtenir tous les dates je dois creer une variable de type date
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickerDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    // element date picker etand par defaut un element de type future c'est dire qui est la mais qui devras etre ajouté plus tard
    setState(() {
      _selectedDate = pickerDate;
    });
    // permet de mettre a jour l'interface utilisateur
  }

  void onKeyTap(String value) {
    setState(() {
      if (value == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '-' || value == '+') {
        if (!input.startsWith(value)) {
          input = input.replaceAll(RegExp(r'[- +]'), '');
          input = value + input;
        }
      } else {
        input += value;
      }
      _AmountController.text = input;
      // Curseur à la fin
      _AmountController.selection = TextSelection.fromPosition(
          TextPosition(offset: _AmountController.text.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
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
      "+",
      "0",
      ".",
      "⌫",
      "-"
    ];

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, keyboardSpace),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0, 34, 0, 0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 241, 239),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
                              )),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: _submitExpenseData,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.all(2)),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'New Expense',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    ExpenseInput(
                                      readOnly: false,
                                      value: _noteFocus,
                                      controller: _titleController,
                                      Title: 'Title',
                                      hinText: 'titre',
                                      icon: Icons.badge,
                                      type: TextInputType.text,
                                    ),
                                    ligneExpense(),
                                    ExpenseInput(
                                      value: _noteFocus2,
                                      controller: _AmountController,
                                      readOnly: false,
                                      Title: 'Amount*',
                                      hinText: "-19.99",
                                      icon: Icons.attach_money_rounded,
                                      type: TextInputType.number,
                                    ),
                                    ligneExpense(),
                                    InputDate()
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Categories*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'See All',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: Category.values.map((category) {
                                      final isSelect =
                                          _selectedCategory == category;
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 20, 0),
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: isSelect
                                                  ? categoryColors[category]
                                                  : Colors.transparent,
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 12, 20, 12),
                                              side: BorderSide(
                                                  width: 1,
                                                  color:
                                                      categoryColors[category]
                                                          as MaterialColor),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          onPressed: () {
                                            setState(() {
                                              _selectedCategory = category;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: isSelect
                                                        ? Colors.white
                                                        : categoryColors[
                                                            category],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Icon(
                                                  categoryIcons[category],
                                                  color: isSelect
                                                      ? categoryColors[category]
                                                      : Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                category.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: isSelect
                                                        ? Colors.white
                                                        : categoryColors[
                                                            category]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // child: Column(
                  //   children: [
                  //     TextField(
                  //       controller: _titleController,
                  //       maxLength: 50,
                  //       decoration: InputDecoration(label: Text('Title')),
                  //     ),
                  //     Row(
                  //       children: [
                  //         //champ pour le montant
                  //         Expanded(
                  //           child: TextField(
                  //             controller: _AmountController,
                  //             keyboardType: TextInputType.number,
                  //             maxLength: 2,
                  //             decoration: const InputDecoration(
                  //                 label: Text('Amount'), prefix: Text('\$')),
                  //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //           ),
                  //         ),
                  //         Expanded(
                  //             child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Text(_selectedDate == null
                  //                 ? 'No date selected'
                  //                 : formater.format(_selectedDate!)),
                  //             IconButton(
                  //               onPressed: _presentDatePicker,
                  //               icon: const Icon(Icons.calendar_month),
                  //             )
                  //           ],
                  //         ))
                  //       ],
                  //     ),
                  //     const SizedBox(height: 16),
                  //     Row(
                  //       children: [
                  //         DropdownButton(
                  //             value:
                  //                 _selectedCategory, //pour afficher une valeur par defaut
                  //             items: Category.values
                  //                 .map((category) => DropdownMenuItem(
                  //                       // valeur interne pour chaque element deroulant
                  //                       value: category,
                  //                       child: Text(category.name.toUpperCase()),
                  //                     ))
                  //                 .toList(),
                  //             onChanged: (value) {
                  //               if (value == null) {
                  //                 return;
                  //               }
                  //               setState(() {
                  //                 _selectedCategory = value;
                  //               });
                  //             }),
                  //         const Spacer(),
                  //         TextButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: const Text('cancel')),
                  //         // const Spacer(),
                  //         const SizedBox(width: 16),
                  //         ElevatedButton(
                  //             onPressed: _submitExpenseData,
                  //             child: const Text('save child')),
                  //       ],
                  //     )
                  //   ],
                  // ),
                ),
                if (showCustomKeyboard && width < 660)
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 198, 208, 215)),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                buildKey(keys[0]),
                                buildKey(keys[1]),
                                buildKey(keys[2]),
                              ],
                            ),
                            Row(
                              children: [
                                buildKey(keys[3]),
                                buildKey(keys[4]),
                                buildKey(keys[5]),
                              ],
                            ),
                            Row(
                              children: [
                                buildKey(keys[6]),
                                buildKey(keys[7]),
                                buildKey(keys[8]),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  buildKey2(keys[10]),
                                  buildKey(keys[11]),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(4, 8, 0, 0),
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: _submitExpenseData,
                                            child: const Text(
                                              'Done',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                        buildKey3(keys[9]),
                                        buildKey3(keys[13]),
                                      ],
                                    )),
                              ),
                              Expanded(flex: 1, child: buildKey(keys[12]))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKey(String label) {
    return GestureDetector(
      onTap: () => onKeyTap(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 34, vertical: 22),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(200),
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

  Widget buildKey2(String label) {
    return GestureDetector(
      onTap: () => onKeyTap(label),
      child: Container(
        width: 180,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildKey3(String label) {
    return GestureDetector(
      onTap: () => onKeyTap(label),
      child: Container(
        width: 180,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding InputDate() {
    final DateFormat formater = DateFormat.yMd();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
      child: Row(
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(Icons.calendar_month),
                ),
                const SizedBox(
                  width: 1,
                ),
                const Text(
                  'Date',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(alignment: Alignment.centerRight),
                onPressed: _presentDatePicker,
                child: Text(
                  style: TextStyle(color: Colors.black),
                  _selectedDate == null
                      ? 'No date selected'
                      : formater.format(_selectedDate!),
                  textAlign: TextAlign.end,
                )),
          )
        ],
      ),
    );
  }

  Container ligneExpense() {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: const Color.fromARGB(72, 158, 158, 158)))),
    );
  }
}

class ExpenseInput extends StatelessWidget {
  const ExpenseInput(
      {super.key,
      required this.controller,
      required this.Title,
      required this.hinText,
      required this.icon,
      required this.type,
      this.value,
      required this.readOnly});

  final TextEditingController controller;
  final String Title;
  final String hinText;
  final IconData icon;
  final TextInputType type;
  final FocusNode? value;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(
                  width: 4,
                ),
                Text(
                  Title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: TextField(
              readOnly: readOnly, // ✅ empêche l'ouverture du clavier système
              focusNode: value,
              controller: controller,
              maxLength: 50,
              textAlign: TextAlign.right,
              keyboardType: type,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500, //
              ),
              decoration: InputDecoration(
                hintText: hinText,
                hintStyle: TextStyle(color: Colors.grey),
                counterText: "", // cache "0/50"
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
