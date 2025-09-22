import 'package:flutter/material.dart';

class MaximumBi extends StatefulWidget {
  const MaximumBi({super.key});

  @override
  State<MaximumBi> createState() => _MaximumBiState();
}

class _MaximumBiState extends State<MaximumBi> {
  var _maxbid = 0.0;
  _increasedMyMaxbi() {
    setState(() {
      _maxbid += 50.0;
    });
  }

  _DeincreasedMyMaxbi() {
    setState(() {
      if (_maxbid <= 0) {
        _maxbid -= 0.0;
      } else {
        _maxbid -= 50.0;
      }
    });
  }

  final Map<String, String> contryCapital = {
    'cameroun': 'yaounde',
    'france': 'paris',
    'germany': 'berlin',
    'usa': 'washington D.C'
  };
  String _getEmojis() {
    if (_maxbid <= 200) {
      return '😞';
    } else {
      return '😊';
    }
  }

  Runes myEmojis = Runes('\u{1f607}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 231, 231),
        leading: const Icon(
          Icons.menu_outlined,
          size: 40,
        ),
        title: Text('Daphane'),
        actions: const <Widget>[
          Icon(
            Icons.search,
            size: 40,
          )
        ],
      ),
      body: Container(
        decoration:
            BoxDecoration(color: const Color.fromARGB(255, 228, 231, 231)),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: ListView(
                    children: contryCapital.entries.map(
                  (e) {
                    return ListTile(
                      leading: Icon(Icons.flag),
                      title: Text(
                        e.key,
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(e.value),
                    );
                  },
                ).toList()),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                'Votre score eihn de  $_maxbid ${_getEmojis()}',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: _increasedMyMaxbi,
                    label: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 151, 220, 173)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: _DeincreasedMyMaxbi,
                    label: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 220, 151, 151),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
