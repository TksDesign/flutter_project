import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

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

  // Controller for the carousel
  final PageController _pageController = PageController();

  // Colors associated with each image
  final List<Color> _appBarColors = [
    const Color.fromARGB(94, 5, 40, 4),
    const Color.fromARGB(255, 48, 1, 1),
    const Color.fromARGB(145, 1, 1, 1),
    const Color.fromARGB(227, 82, 11, 11),
  ];
  // Index to keep track of the current image
  int _currentImageIndex = 0;
  void _onImageChanged(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  Widget imagecarousel = Container(
      height: 250,
      child: AnotherCarousel(
        boxFit: BoxFit.cover,
        images: const [
          AssetImage('assets/images/1.png'),
          AssetImage('assets/images/2.png'),
          AssetImage('assets/images/3.png'),
          AssetImage('assets/images/4.png'),
        ],
        onImageChange: (prev, covariant) {},
      ));
  Widget backColor = Container(
    height: 1500,
    color: Colors.amber,
    child: const Text('login page'),
  );
  String value = '';
  String name = '';
  String phone = '';
  String password = '';
  final formkey = new GlobalKey<FormState>();
  validationForm() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      debugPrint('$name');
      debugPrint('$phone');
      debugPrint('$password');
      formkey.currentState!.reset();
    } else {
      debugPrint('Error....');
    }
  }

  /*void submit(String a) {
    setState(() {
      value = 'message envoyer $a';
    });
  }
*/
  void affichage(String b) {
    setState(() {
      value = 'bienvenue $b';
    });
  }
  //2Color.fromARGB(255, 48, 1, 1) 4color.fromARGB(227, 82, 11, 11) 1Color.fromARGB(94, 5, 40, 4) 3const Color.fromARGB(145, 1, 1, 1)

  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        centerTitle: true,
        backgroundColor: _appBarColors[_currentImageIndex],
      ),*/
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          /*title: const Text(
            'Welcom daphane',
            style: TextStyle(
                color: Color.fromARGB(255, 44, 73, 190), fontSize: 29),
          ),*/
          centerTitle: true,
          pinned: false,
          floating: false,
          expandedHeight: 250,
          backgroundColor: _appBarColors[_currentImageIndex],
          flexibleSpace: FlexibleSpaceBar(
              background: ListView(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: AnotherCarousel(
                  boxFit: BoxFit.cover,
                  images: const [
                    AssetImage('assets/images/1.png'),
                    AssetImage('assets/images/2.png'),
                    AssetImage('assets/images/3.png'),
                    AssetImage('assets/images/4.png'),
                  ],
                  onImageChange: (prev, current) {
                    _onImageChanged(current);
                  },
                ),
              ),
            ],
          )),
        ),
        SliverFixedExtentList(
          itemExtent: 900,
          delegate: SliverChildListDelegate([
            // backColor,
            Form(
              key: formkey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Login to SuperApp',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '$value',
                      style: const TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'nom',
                        hintText: 'entrer le nom',
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) =>
                          val?.length == 0 ? "valider votre nom" : null,
                      onSaved: (val) => name = val!,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'numero',
                        hintText: 'entrer votre numero',
                        icon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre numero de telephone"
                          : null,
                      onSaved: (val) => phone = val!,
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'entrer votre mot de passe',
                        icon: Icon(
                          Icons.key,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre mot de passe"
                          : null,
                      onSaved: (val) => password = val!,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'nom',
                        hintText: 'entrer le nom',
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) =>
                          val?.length == 0 ? "valider votre nom" : null,
                      onSaved: (val) => name = val!,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'numero',
                        hintText: 'entrer votre numero',
                        icon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre numero de telephone"
                          : null,
                      onSaved: (val) => phone = val!,
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'entrer votre mot de passe',
                        icon: Icon(
                          Icons.key,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre mot de passe"
                          : null,
                      onSaved: (val) => password = val!,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'nom',
                        hintText: 'entrer le nom',
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) =>
                          val?.length == 0 ? "valider votre nom" : null,
                      onSaved: (val) => name = val!,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'numero',
                        hintText: 'entrer votre numero',
                        icon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre numero de telephone"
                          : null,
                      onSaved: (val) => phone = val!,
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'entrer votre mot de passe',
                        icon: Icon(
                          Icons.key,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre mot de passe"
                          : null,
                      onSaved: (val) => password = val!,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'nom',
                        hintText: 'entrer le nom',
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) =>
                          val?.length == 0 ? "valider votre nom" : null,
                      onSaved: (val) => name = val!,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'numero',
                        hintText: 'entrer votre numero',
                        icon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre numero de telephone"
                          : null,
                      onSaved: (val) => phone = val!,
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      autofocus: true,
                      onChanged: affichage,
                      //onSubmitted: submit,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'entrer votre mot de passe',
                        icon: Icon(
                          Icons.key,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      validator: (val) => val?.length == 0
                          ? "valider votre mot de passe"
                          : null,
                      onSaved: (val) => password = val!,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      //onSubmitted: submit,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 45)),
                    ElevatedButton(
                        onPressed: validationForm,
                        child: const Text(
                          'validation',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
