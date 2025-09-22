import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.white),
        home: home(),
        debugShowCheckedModeBanner: false);
  }
}
/*
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String? def = null;

  List<DropdownMenuItem<String>>? listmonths = [];

  void months() {
    listmonths?.clear();
    listmonths?.add(DropdownMenuItem(
      value: 'janvier',
      child: const Text(
        'Janvier',
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ));
    listmonths?.add(DropdownMenuItem(
      value: 'fevrier',
      child: const Text(
        'fevrier',
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ));
    listmonths?.add(DropdownMenuItem(
      value: 'mars',
      child: const Text(
        'mars',
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    months();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'work',
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(
              Icons.work,
              color: Colors.black,
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
          ),
        ],
        title: Text('Dropdownlist'),
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                    scaffoldBackgroundColor:
                        const Color.fromARGB(255, 14, 192, 201)),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: def,
                              elevation: 0,
                              items: listmonths,
                              hint: const Text(
                                'selectioner le Mois',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              onChanged: (value) {
                                def = value!;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(85),
                          child: Text(
                            'votre mois est de : $def',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}*/

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  final List<String> items = [
    'Janvier',
    'fevrier',
    'mars',
    'avril',
  ];
  String? selectedValue;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          size: 25,
        ),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () {},
            label: Text(
              'UP',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            icon: Icon(Icons.upcoming),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
          ),
        ],
        title: Text(
          'DAPHANE',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 75, vertical: 159),
        child: Row(
          children: <Widget>[
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        'Selectionner la date',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 14),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.black),
                      // color: Colors.pink[50]
                    ),
                    elevation: 0),
                menuItemStyleData: const MenuItemStyleData(height: 40),
                dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color.fromARGB(255, 245, 235, 238)),
                    elevation: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
