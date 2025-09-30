import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:textfield/data/categories.dart';
import 'package:textfield/models/Category.dart';
// import 'package:textfield/models/grocery_item.dart';

import 'package:http/http.dart' as http;
import 'package:textfield/models/grocery_item.dart'; //pour dire tout ce qui est fourni ici pourrai etre regroupe dams 'http'

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<
      FormState>(); //specifie lelemt que la cle global doit surveiller
  String _currentName = '';
  int _currentQuantity = 1;
  var _selectCategory = categories[Categorie.vegetables]!;
  var _isSending = false;

  void _saveItems() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'text-field-58b90-default-rtdb.firebaseio.com', 'shopping-list.json');
      final reponse = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': _currentName,
            'quantite': _currentQuantity,
            'category': _selectCategory.title
          }));
      // print(response.body);
      // print(response.statusCode);

      final Map<String, dynamic> restData = json.decode(reponse.body);
      if (!context.mounted) {
        return;
      } //verifie si le context n'est pas monte alors on ne quitte pas la page v

      // Navigator.of(context).pop();
// pour la sauvegarde et l'envoie des donnee en local sans envoye une requete

      Navigator.of(context).pop(GroceryItem(
          id: restData['name'],
          name: _currentName,
          quantite: _currentQuantity,
          category: _selectCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new items'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: InputDecoration(label: Text('name')),
                  validator: (Value) {
                    if (Value == null ||
                        Value.isEmpty ||
                        Value.trim().length <= 1 ||
                        Value.trim().length > 50) {
                      return 'Error message';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _currentName = value!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _currentQuantity.toString(),
                        decoration:
                            const InputDecoration(label: Text('quantity')),
                        validator: (Value) {
                          if (Value == null ||
                              Value.isEmpty ||
                              int.tryParse(Value) == null ||
                              int.tryParse(Value)! <= 0) {
                            return 'Must be valid positive number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _currentQuantity = int.parse(value!);
                          // converti le string en int
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _selectCategory,
                          items: [
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                  value: category.value,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        color: category.value.color,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(category.value.title)
                                    ],
                                  )),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectCategory = value!;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: Text('reset')),
                    ElevatedButton(
                        onPressed: _isSending ? null : _saveItems,
                        child: _isSending
                            ? const CircularProgressIndicator.adaptive()
                            : const Text('add item'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
