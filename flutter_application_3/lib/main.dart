import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color.fromARGB(49, 246, 230, 230),
          title: const Text(
            'MybestBarber',
            style: TextStyle(
              color: Color.fromARGB(255, 90, 7, 7),
              fontSize: 40,
            ),
          ),
          actions: const <Widget>[
            Icon(
              Icons.desktop_access_disabled,
              color: Colors.black,
              size: 35,
            )
          ],
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'Service disponible',
              style: TextStyle(
                  color: Color.fromARGB(255, 117, 12, 12), fontSize: 30),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'assets/images/2.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      var route = MaterialPageRoute(
                          builder: (BuildContext context) => const home2(
                                val1: 'service disponible',
                                val2: 'assets/images/2.png',
                              ));
                      Navigator.of(context).push(route);
                    },
                    icon: const Icon(
                      Icons.integration_instructions_outlined,
                      color: Color.fromARGB(255, 117, 12, 12),
                      size: 45,
                    ),
                    label: const Text('Detail'))
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'Gamme de produit',
              style: TextStyle(
                  color: Color.fromARGB(255, 68, 207, 137), fontSize: 30),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'assets/images/1.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      var route = MaterialPageRoute(
                          builder: (BuildContext context) => const home2(
                                val1: 'Gamme de produit',
                                val2: 'assets/images/1.png',
                              ));
                      Navigator.of(context).push(route);
                    },
                    icon: const Icon(
                      Icons.integration_instructions_outlined,
                      color: Color.fromARGB(255, 68, 207, 137),
                      size: 45,
                    ),
                    label: const Text('Detail'))
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'Service Hammam',
              style: TextStyle(
                  color: Color.fromARGB(255, 231, 10, 10), fontSize: 30),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'assets/images/4.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      var route = MaterialPageRoute(
                          builder: (BuildContext context) => const home2(
                                val1: 'Service Hammam',
                                val2: 'assets/images/4.png',
                              ));
                      Navigator.of(context).push(route);
                    },
                    icon: const Icon(
                      Icons.integration_instructions_outlined,
                      color: Color.fromARGB(255, 217, 12, 32),
                      size: 45,
                    ),
                    label: const Text('Detail'))
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'Grille de prix',
              style:
                  TextStyle(color: Color.fromARGB(255, 9, 6, 0), fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'assets/images/3.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      var route = MaterialPageRoute(
                          builder: (BuildContext context) => const home2(
                                val1: 'Grille de prix',
                                val2: 'assets/images/3.png',
                              ));
                      Navigator.of(context).push(route);
                    },
                    icon: const Icon(
                      Icons.integration_instructions_outlined,
                      color: Color.fromARGB(255, 18, 11, 0),
                      size: 45,
                    ),
                    label: const Text('Detail'))
              ],
            ),
          ],
        )
            /* PageView.builder(
        itemBuilder: (BuildContext buildcontext, int index) =>
            pageWidget(entry: pages[index]),
        itemCount: pages.length,
      ),*/
            ));
  }
}

class home2 extends StatelessWidget {
  final String val1;
  final String val2;
  const home2({super.key, required this.val1, required this.val2});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "bienvenue",
            style: TextStyle(fontSize: 28),
          ),
          actions: const <Widget>[
            Icon(
              Icons.filter_drama,
              color: Colors.black,
              size: 35,
            )
          ],
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            //const Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              '$val1',
              style: TextStyle(color: Colors.black, fontSize: 45),
            ),
            //const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    '$val2',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            const Text(
              'Plus de pricision',
              style:
                  TextStyle(color: Color.fromARGB(255, 7, 6, 6), fontSize: 30),
            ),
            Container(
              height: 200,
              child: const Text(
                'Chaque nuit, mon sommeil était profond comme à laccoutumée, mais ce matin-là, contrairement aux autres, jouvris les yeux et, pendant une seconde, une sérénité et un calme parfaits mhabitèrent. Juste au moment où je commençais à en apprécier la douceur, les souvenirs revinrent avec',
              ),
            )
          ],
        )
            /* PageView.builder(
        itemBuilder: (BuildContext buildcontext, int index) =>
            pageWidget(entry: pages[index]),
        itemCount: pages.length,
      ),*/
            ));
  }
}

class Pageinfo {
  final String title;
  final String image;
  final String description;
  const Pageinfo(this.title, this.image, this.description);
}

final List<Pageinfo> pages = [
  const Pageinfo(
      'Meilleur modele 1', 'assets/images/1.png', ' 1er affiche cree'),
  const Pageinfo(
      'Meilleur modele 2', 'assets/images/2.png', ' 2eme affiche cree'),
  const Pageinfo(
      'Meilleur modele 3', 'assets/images/3.png', ' 3eme affiche cree'),
  const Pageinfo(
      'Meilleur modele 4', 'assets/images/4.png', ' 4eme affiche cree'),
];

class pageWidget extends StatefulWidget {
  const pageWidget({super.key, required this.entry});
  final Pageinfo entry;
  @override
  State<pageWidget> createState() => _pageWidgetState();
}

class _pageWidgetState extends State<pageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.entry.title,
                style: const TextStyle(color: Colors.blue, fontSize: 25),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            widget.entry.image,
            fit: BoxFit.cover,
          ),
          Text(
            widget.entry.description,
            style: const TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
