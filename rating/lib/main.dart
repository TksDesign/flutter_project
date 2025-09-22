import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

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
  @override
  int maxstar = 5;
  double rate = 3;
  double rate1 = 5;
  double rate3 = 3;
  double rate4 = 3.5;
  List<BottomNavigationBarItem> items1 = [];
  int _id = 0;
  void initState() {
    super.initState();
    items1 = [];
    items1.add(const BottomNavigationBarItem(
        icon: Icon(
          Icons.house,
          color: Colors.white,
          size: 25,
        ),
        label: 'person'));
    items1.add(const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.white,
          size: 25,
        ),
        label: 'house'));
    items1.add(const BottomNavigationBarItem(
        icon: Icon(
          Icons.event_outlined,
          color: Colors.white,
        ),
        label: 'person'));
  }

  Widget details(String image, String hotel, double rate, Color colors) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 197, 219, 225),
                          width: 5),
                      borderRadius: BorderRadius.circular(16)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: 400,
                    height: 240,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 125,
                  child: Text(
                    hotel,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                StarRating(
                  size: 40.0,
                  rating: rate,
                  color: colors,
                  borderColor: colors,
                  starCount: maxstar,
                  onRatingChanged: (rate) => setState(() {
                    if (hotel == "hotel Hilton") {
                      this.rate1 = rate;
                    } else if (hotel == "Le Best hotel") {
                      this.rate = rate;
                    } else if (hotel == "CoFE hotel") {
                      this.rate3 = rate;
                    } else
                      this.rate4 = rate;
                  }),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                    width: 50,
                    child: Text(
                      '$rate',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(245, 14, 14, 14),
        leading: const Icon(
          Icons.menu,
          size: 25,
          color: Colors.white,
        ),
        title: const Text(
          'bonjour daphane',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: const [
          Icon(
            Icons.alarm,
            size: 35,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        color: const Color.fromARGB(245, 14, 14, 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: <Widget>[
                details(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTg4Ff6bdknN2JQQr7Qf5ZsG91YtFClblwVyK6hS9-n2HPnj-FLQHXr3H1Sngzcgnxa-_M&usqp=CAU',
                    'hotel Hilton',
                    rate1,
                    Colors.white),
                details(
                    'https://www.hotelproafrica.com/wp-content/uploads/2018/03/le-best-hotelproafrica00.jpg',
                    'Le Best hotel',
                    rate,
                    Colors.white),
                details(
                    'https://cf.bstatic.com/xdata/images/hotel/max1024x768/568863540.jpg?k=650fcb968d4e528d3d734e42dcd820dd7ee1af3dba1cbef24afda3a84c2540b7&o=&hp=1',
                    'CoFE hotel',
                    rate3,
                    Colors.white),
                details(
                    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=414x232',
                    'Hotel a Khon Khae',
                    rate4,
                    Colors.white),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: Colors.white,
        items: items1,
        currentIndex: _id,
        onTap: (int item) {
          _id = item;
          int a = _id + 1;
        },
      ),
    );
  }
}
