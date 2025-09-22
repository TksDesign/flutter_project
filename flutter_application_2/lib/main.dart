import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: soir(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class soir extends StatefulWidget {
  const soir({super.key});

  @override
  State<soir> createState() => _soirState();
}

// ignore: camel_case_types
class _soirState extends State<soir> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 8, 64, 109),
                title: const Text(
                  'Bienvenue Daph',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                actions: const <Widget>[
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.videogame_asset_off,
                      color: Colors.white,
                      size: 39,
                    ),
                  )
                ],
                bottom: const TabBar(tabs: <Widget>[
                  Tab(
                    child: Icon(
                      Icons.add_ic_call,
                      color: Colors.red,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.invert_colors_on_sharp,
                      color: Colors.amber,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.cabin,
                      color: Colors.amberAccent,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.add_sharp,
                      color: Colors.amberAccent,
                    ),
                  )
                ]),
              ),
              // ignore: non_constant_identifier_names
              body: TabBarView(children: [
                Card(
                  child: Image.asset(
                    'assets/images/1.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Card(
                  child: Image.asset(
                    'assets/images/2.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Card(
                  child: Image.asset(
                    'assets/images/3.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Card(
                  child: Image.asset(
                    'assets/images/4.png',
                    height: 200,
                    width: 200,
                  ),
                )
              ])
              /* OrientationBuilder(builder: (context, Orientation) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            children: List.generate(4, (index) {
              return Image.asset(
                'images/${index + 1}.png',
                height: 40,
                width: 40,
              );
            }),
          );
        })*/
              /*Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'tableau de bord CAMAIR-CO',
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 81, 137),
                    fontSize: 27,
                  ),
                ),
              ],
            ),
            Container(
              height: 600,
              width: 400,
              //color: const Color.fromARGB(255, 255, 255, 255),
              child: viewer(),
            ),
            const Text(
              'BON V0YAGE',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ],
        ),
      ),
                ListView(
              children: <Widget>[
                Image.asset(
                  'assets/images/1.png',
                  width: 600,
                  height: 240,
                )
              ],
            ),*/
              )),
    );
  }
}

Widget viewer() {
  return ListView(
    children: const <Widget>[
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_land_rounded,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'atterisage 3:05PM',
          style: TextStyle(
            color: Color.fromARGB(255, 203, 9, 9),
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_land,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'atterisage 3:05PM',
          style: TextStyle(
            color: Color.fromARGB(255, 223, 18, 18),
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.flight_takeoff,
          color: Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          'BAMOUGOUM-YAOUNDE',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'decolage 2:45PM',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      )
    ],
  );
}
