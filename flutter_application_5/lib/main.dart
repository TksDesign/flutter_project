import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: homee(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class homee extends StatefulWidget {
  const homee({super.key});

  @override
  State<homee> createState() => _homeeState();
}

class _homeeState extends State<homee> {
  Widget movies(String name, String image, String movie) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 12, 13, 5),
              foregroundColor: Colors.white,
              backgroundImage: image.isNotEmpty ? AssetImage(image) : null,
              radius: 30,
              child: Text(
                image.length == 0 ? name[0].toUpperCase() : '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            subtitle: Text(
              movie,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 197, 133, 56)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 25,
          ),
          backgroundColor: const Color.fromARGB(163, 77, 64, 24),
          centerTitle: true,
          title: const Text(
            'Daphane',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          actions: const <Widget>[
            Icon(
              Icons.add_ic_call_rounded,
              size: 35,
              color: Colors.white,
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            child: MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemBuilder: (context, index) {
                return showimage(verif: infos[index]);
              },
              itemCount: infos.length,
            ))
        // Circle Avatar
        /* ListView(children: <Widget>[
        movies('Daphane Tissie', "assets/images/5.jpeg",
            "Daphanetissi24@gmail.com"),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        movies('Kennys SIMO', "assets/images/6.jpeg", "KennysSimo@gmail.com"),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        movies('Duchel Ngueche', "assets/images/7.jpeg",
            "Daphanetissie@gmail.com"),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        movies('Shanonn Tissie', "", "Daphanetissi2@gmail.com"),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        movies(
            'shanonn Kuate', "assets/images/8.jpeg", "shanonnkuate@gmail.com"),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        movies('Billy Samar', "", " billy_samar@gmail.com"),
        Divider(
          height: 10,
          color: Colors.black,
        ),
      ]),*/
        );
  }
}

class Info {
  late String images;
  late String titles;
  late String city;
  Info({required this.images, required this.titles, required this.city});
}

List<Info> infos = [
  Info(
      images: 'assets/images/5.jpeg', titles: 'DaphaneTissie', city: 'yaounde'),
  Info(images: 'assets/images/6.jpeg', titles: 'Simo kennys', city: 'toronto'),
  Info(
      images: 'assets/images/7.jpeg',
      titles: 'Duchel ngueche',
      city: 'luxembour'),
  Info(
      images: 'assets/images/8.jpeg',
      titles: 'shanonn kuate',
      city: 'los angeles'),
];

class showimage extends StatelessWidget {
  final Info verif;
  const showimage({super.key, required this.verif});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //pour avoir une image de type
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            verif.images,
          ),
        ),
        Text(
          verif.titles,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          verif.city,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
