import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.app_registration),
            backgroundColor: Colors.amberAccent,
            title: Text('my app bar'),
            actions: <Widget>[Icon(Icons.ac_unit_rounded)],
            bottom: const TabBar(tabs: <Widget>[
              Tab(
                child: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 186, 102, 94),
                  size: 40,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.phone,
                  color: Color.fromARGB(255, 228, 115, 104),
                  size: 40,
                ),
              )
            ]),
          ),
          /* body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),*/
          body: TabBarView(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.network(
                              'https://media.istockphoto.com/id/1852596277/photo/international-workers-group-and-team-leader-having-teamwork-discussion-managing-project-at.jpg?s=1024x1024&w=is&k=20&c=rDvdYMMz0GCryH4cqxjUU2i9C8rVhKvVOWpg_bnrjXg=',
                              height: 600,
                              width: 400,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ClipRRect(
                            child: Image.network(
                              'https://media.istockphoto.com/id/1852596277/photo/international-workers-group-and-team-leader-having-teamwork-discussion-managing-project-at.jpg?s=1024x1024&w=is&k=20&c=rDvdYMMz0GCryH4cqxjUU2i9C8rVhKvVOWpg_bnrjXg=',
                              height: 600,
                              width: 400,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ClipRRect(
                            child: Image.network(
                              'https://media.istockphoto.com/id/1852596277/photo/international-workers-group-and-team-leader-having-teamwork-discussion-managing-project-at.jpg?s=1024x1024&w=is&k=20&c=rDvdYMMz0GCryH4cqxjUU2i9C8rVhKvVOWpg_bnrjXg=',
                              height: 600,
                              width: 400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://media.istockphoto.com/id/1591572504/photo/cheerful-businesswomen-shaking-hands-in-meeting-room.jpg?s=1024x1024&w=is&k=20&c=GYtKvPPbShP3JOyGRZdlakcQE2_h0skl6g6bU0r83qk=',
                        height: 300,
                        width: 300,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://media.istockphoto.com/id/1186129185/photo/were-always-positive-and-productive-when-we-work-together.jpg?s=1024x1024&w=is&k=20&c=aGfUqCdHYVtMRoad8iZqoW4BFJ9QCwrznb4QlxfD0fg=',
                        height: 300,
                        width: 300,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      child: Image.network(
                        'https://media.istockphoto.com/id/1852596277/photo/international-workers-group-and-team-leader-having-teamwork-discussion-managing-project-at.jpg?s=1024x1024&w=is&k=20&c=rDvdYMMz0GCryH4cqxjUU2i9C8rVhKvVOWpg_bnrjXg=',
                        height: 300,
                        width: 300,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      child: Image.network(
                        'https://media.istockphoto.com/id/1852596277/photo/international-workers-group-and-team-leader-having-teamwork-discussion-managing-project-at.jpg?s=1024x1024&w=is&k=20&c=rDvdYMMz0GCryH4cqxjUU2i9C8rVhKvVOWpg_bnrjXg=',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
