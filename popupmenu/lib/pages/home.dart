import 'package:flutter/material.dart';

class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'welcom',
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.menu,
              size: 28,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[Text('data')],
        ),
      ),
    );
  }
}
