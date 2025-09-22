import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: soir(), debugShowCheckedModeBanner: false);
  }
}

class soir extends StatefulWidget {
  const soir({super.key});

  @override
  State<soir> createState() => _soirState();
}

enum Reponse { OUI, NON, SAIS_PAS }

class _soirState extends State<soir> {
  @override
  //declaration de variable
  int val1 = 0;
  int _id = 0;
  String a = '';
  String _value = '';
  String _valeur = '';
  Widget ic = Container();
  String msg = '';
  String _var = '';

  //datepicker initialisation
  Future<DateTime?> _selectFullDate() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030));
    if (picker != null)
      setState(() {
        _var = picker.toString();
      });
  }

  List<BottomNavigationBarItem> item1 = [];
  void _setvaleur(String a) {
    setState(() {
      _valeur = a;
    });
  }

  void _setmsg(String b) {
    setState(() {
      msg = b;
    });
  }

  void _seticon(Widget c) {
    setState(() {
      ic = c;
    });
  }

  Future info(String a, Widget ic) async {
    final result = await showDialog<Reponse>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              a.toString(),
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('OUI'),
                onPressed: () {
                  Navigator.pop(context, Reponse.OUI);
                },
              ),
              SimpleDialogOption(
                  child: Text('NON'),
                  onPressed: () {
                    Navigator.pop(context, Reponse.NON);
                  }),
              SimpleDialogOption(
                child: Text('je sais pas'),
                onPressed: () {
                  Navigator.pop(context, Reponse.SAIS_PAS);
                },
              )
            ],
          );
        });
    switch (result) {
      case Reponse.OUI:
        _setvaleur('OUI, je suis satisfait du service');
        break;
      case Reponse.NON:
        _setvaleur("NON, L'utilisateur n'est pas satisfait(e).");
        break;
      case Reponse.SAIS_PAS:
        _setvaleur("L'utilisateur est confu.");
        break;

      default:
        _setvaleur("Aucune option sélectionnée.");
    }
  }

  void affiche() {
    setState(() {
      val1++;
    });
  }

  void showSnackbar() {
    setState(() {});
    final snackBar = SnackBar(
      content: Text('Êtes-vous sûr de vouloir supprimer?'),
      action: SnackBarAction(
        label: 'Supprimer',
        onPressed: () {
          showDeleteMessage();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showDeleteMessage() {
    final deleteSnackBar = SnackBar(
      content: Text('message supprimé'),
    );

    ScaffoldMessenger.of(context).showSnackBar(deleteSnackBar);
  }

  void initState() {
    super.initState();
    item1 = [];
    item1.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.food_bank_outlined,
          color: Colors.deepPurple,
        ),
        label: 'person'));

    item1.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.food_bank_sharp,
          color: Colors.deepPurple,
          size: 20,
        ),
        label: 'application'));
    item1.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.phone_android_sharp,
          color: Colors.deepPurple,
          size: 20,
        ),
        label: 'about'));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Bienvenu Daphane',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: affiche,
            icon: Icon(
              Icons.article,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'account',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            title: Text(
              'dashbord',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('page1'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('page2'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('page4'),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              '$val1',
              style: TextStyle(color: Colors.blue, fontSize: 29),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text('$_value'),

            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'point de vu: $_valeur',
              style: TextStyle(color: Colors.black),
            ),
            //icon
            ic,
            //date picker
            ElevatedButton(
                onPressed: _selectFullDate, child: Text('click ici')),
            Text(
              'mon aniiversaire est le :$_var',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
                onPressed: showSnackbar,
                child: Text(
                  'supprimer',
                  style: TextStyle(color: Colors.black),
                )),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        items: item1,
        currentIndex: _id,
        onTap: (int item) {
          _id = item;
          setState(() {
            if (_id == 0) {
              _setmsg('etes-vous satisfait(e) du service restaurant');
            }
            if (_id == 1) {
              _setmsg('estes-vous satisfait(e) du service poissonerie');
            }
            if (_id == 2) {
              _setmsg('etes-vous satisfait(e) du service dannce');
            }
            //a = _id + 1;
            //_value = 'vous etes sur la page numero $a';
            info(msg, ic);
          });
        },
      ),
    );
  }
}
