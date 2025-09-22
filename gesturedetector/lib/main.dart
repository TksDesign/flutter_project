import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  String info = '';
  bool change = true;
  String b = 'assets/images/2.HEIC';
  String a = 'assets/images/1.HEIC';
  String c = 'assets/images/3.HEIC';
  String d = 'assets/images/4.HEIC';
  void onSubmit(String value) {
    setState(() {
      info = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.blue[200],
        title: Text('welcom daphane'),
        actions: const <Widget>[
          Icon(
            Icons.add,
            size: 35,
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Mouvement de la souris: $info',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    change ? a : d,
                    height: 170,
                    width: 170,
                  ),
                  Image.asset(
                    change ? c : b,
                    height: 170,
                    width: 170,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (change == true) {
                      change = false;
                      onSubmit("un click");
                    } else {
                      change = true;
                    }
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    if (change == true) {
                      change = true;
                      onSubmit("double click");
                    } else {
                      change = false;
                    }
                  });
                },
                onTapCancel: () {
                  onSubmit("click annulé ");
                },
                onLongPress: () {
                  onSubmit("long  click");
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      'Validation',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
