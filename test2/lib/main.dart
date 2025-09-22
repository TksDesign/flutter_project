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
  var items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          // leading: const Icon(
          //   Icons.menu,
          //   size: 32,
          //   color: Colors.white,
          // ),
          title: DropdownButton(
            items: items,
            onChanged: null,
            icon: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Stack(children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/1.avif',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              color: const Color.fromARGB(158, 121, 85, 72),
            )
          ])),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const RowWidget(),
              Padding(padding: EdgeInsets.all(16)),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        color: Colors.blue,
                        height: 60,
                        width: 60,
                      ),
                      Padding(padding: EdgeInsets.all(16)),
                      Container(
                        color: Colors.amber,
                        height: 40,
                        width: 40,
                      ),
                      Padding(padding: EdgeInsets.all(16)),
                      Container(
                        color: Colors.brown,
                        width: 20,
                        height: 20,
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            radius: 100,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.yellow,
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.amber,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.brown,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        color: Colors.amber,
                      ),
                      const Center(
                        child: Text('End of the line'),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          color: Colors.yellow,
        ),
        Padding(padding: EdgeInsets.all(16.0)),
        Expanded(
            child: Container(
          color: Colors.amber,
          height: 40,
          width: 40,
        )),
        Padding(padding: EdgeInsets.all(16.0)),
        Container(
          color: Colors.brown,
          width: 40.0,
          height: 40.0,
        )
      ],
    );
  }
}
