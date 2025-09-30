import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:textfield/data/categories.dart';
import 'package:textfield/models/grocery_item.dart';
import 'package:textfield/widgets/new_item.dart';

import 'package:http/http.dart' as http;

class GroceryListe extends StatefulWidget {
  const GroceryListe({super.key});

  @override
  State<GroceryListe> createState() => _GroceryListeState();
}

class _GroceryListeState extends State<GroceryListe> {
  List<GroceryItem> _groceryitem = [];
  var _isloadind = true;
  String? _error;

  // on initialise le widget pour la premier fois et donc voici le sujet
  @override
  void initState() {
    super.initState();
    // garanti que le methode s'executera
    loadItems();
  }

  // pour envoyer une demande
  void loadItems() async {
    final url = Uri.https(
        'text-field-58b90-default-rtdb.firebaseio.com', 'shopping-list.json');
    // pour gerer les cas d'erreur

    try {
      final List<GroceryItem> loadedItems = [];
      final reponse = await http.get(url);
      final listData = json.decode(reponse.body);
      if (listData is! Map<String, dynamic>) {
        setState(() {
          _error = "erreur lors de recuperation des donnees";
        });
      } else if (reponse.statusCode >= 400) {
        setState(() {
          _error = " Failed to fecth the data. please try again";
        });
        if (reponse.body == null) {
          setState(() {
            _isloadind = false;
          });
          return;
        }
      }
      for (final item in listData.entries) {
        final categorie = categories.entries
            .firstWhere(
                (cartItem) => cartItem.value.title == item.value['category'])
            .value;
        loadedItems.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantite: item.value['quantite'],
            category: categorie));
      }
      setState(() {
        _groceryitem = loadedItems;
        _isloadind = false;
      });
    } catch (e) {
      setState(() {
        _error = "erreur lors de recuperation des donnees";
      });
    }
  }

  void _addItem() async {
    final newItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx) => NewItem(),
    ));

// pour gerer l'ajout des elements en local
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryitem.add(newItem);
    });
  }

  deleteItem(GroceryItem grocery) {
    final groceryIndex = _groceryitem.indexOf(grocery);

    // Retirer localement
    setState(() {
      _groceryitem.removeAt(groceryIndex);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.endToStart,
            duration: const Duration(seconds: 3),
            content: const Text('Élément supprimé'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () {
                // Réinsérer si annulé
                setState(() {
                  _groceryitem.insert(groceryIndex, grocery);
                });
              },
            ),
          ),
        )
        .closed
        .then((reason) async {
      // Si l'utilisateur n'a PAS annulé → on supprime côté serveur
      if (!_groceryitem.contains(grocery)) {
        final url = Uri.https(
          'text-field-58b90-default-rtdb.firebaseio.com',
          'shopping-list/${grocery.id}.json',
        );
        await http.delete(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _groceryitem.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_groceryitem[index].id),
        onDismissed: (direction) {
          setState(() {
            deleteItem(_groceryitem[index]);
          });
        },
        direction: DismissDirection.endToStart,
        background: Container(
          padding: EdgeInsets.only(right: 20),
          color: Colors.red[900],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ),
        child: ListTile(
          title: Text(_groceryitem[index].name),
          leading: Container(
            height: 24,
            width: 24,
            color: _groceryitem[index].category.color,
          ),
          trailing: Text(_groceryitem[index].quantite.toString()),
        ),
      ),
    );
    if (_groceryitem.isEmpty) {
      content = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No data... ')],
        ),
      );
    }
    if (_isloadind) {
      content = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator()],
        ),
      );
    }
    if (_error != null) {
      content = Center(
        child: Text(
          _error!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your grocery',
            textAlign: TextAlign.center,
          ),
          actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
        ),
        body: content);
  }
}
