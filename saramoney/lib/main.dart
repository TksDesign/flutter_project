import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginSara',
      home: Myhomepage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.white),
    );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  var number = '';
  var password = '';
  String? selectedValue;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isValidBtn = false;
  bool isPasswordVisible = false;
  validationForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      debugPrint('$number');
      debugPrint('$password');
      formKey.currentState!.reset();
      setState(() {
        isValidBtn = false;
      });
    } else {
      debugPrint('Error....');
    }
  }

  void ValidityBtn() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      setState(() {
        isValidBtn = true; //
      });
    } else {
      setState(() {
        isValidBtn = false;
      });
    }
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                height: 350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/imageBack.jpeg'),
                    fit: BoxFit.contain,
                    alignment: Alignment(1, 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(children: <Widget>[
                    Container(
                        height: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              gradient: RadialGradient(colors: [
                                const Color.fromARGB(183, 255, 255, 255),
                                Colors.white.withOpacity(1),
                              ], radius: 0.5)),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.menu,
                                size: 28,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Padding(padding: EdgeInsets.all(20)),
                                  Icon(
                                    Icons.ac_unit_sharp,
                                    color: Color.fromARGB(71, 0, 0, 0),
                                    size: 24,
                                  ),
                                  Icon(
                                    Icons.import_contacts,
                                    color: Color.fromARGB(71, 0, 0, 0),
                                    size: 24,
                                  ),
                                  Icon(
                                    Icons.access_time_filled_rounded,
                                    color: Color.fromARGB(71, 0, 0, 0),
                                    size: 24,
                                  ),
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Color.fromARGB(71, 0, 0, 0),
                                    size: 24,
                                  ),
                                ],
                              ),
                              Text(
                                'Découvrir',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 211, 50, 50)),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 40),
                            height: 100,
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(53, 0, 0, 0),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Form(
                  key: formKey,
                  onChanged: ValidityBtn,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                const Row(
                                  children: <Widget>[
                                    Text(
                                      'Connectez-vous avec Sara !',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 34,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Numero de téléphone',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                IntlPhoneField(
                                  validator: (value) {
                                    if (value == null || value.number.isEmpty) {
                                      return 'Veuillez entrer un numéro de téléphone valide';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color.fromARGB(255, 211, 50, 50),
                                  initialCountryCode: 'CM',
                                  onSaved: (phone) =>
                                      number = phone!.completeNumber,
                                  showCountryFlag: false,
                                  showDropdownIcon: true,
                                  dropdownIconPosition: IconPosition.trailing,
                                  dropdownIcon: const Icon(
                                    Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                  flagsButtonMargin: EdgeInsets.all(12),
                                  dropdownTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    suffixIcon: const Icon(
                                      Icons.account_circle_outlined,
                                      color: Colors.black54,
                                    ),
                                    labelText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 211, 50, 50),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  languageCode: "en",
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                  },
                                  onCountryChanged: (country) {
                                    print(
                                        'Country changed to: ' + country.name);
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Mot de passe',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        isPasswordVisible?
                                        Icons.visibility_outlined :Icons.visibility_off,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: 'Entrez votre mot de passe',
                                    hintStyle: TextStyle(
                                        color:
                                            const Color.fromARGB(83, 0, 0, 0)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 211, 50, 50),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  validator: (value1) {
                                    if (value1 == null || value1.isEmpty) {
                                      return 'Veuillez entrer votre numéro mot de pass';
                                    }
                                    return null;
                                  },
                                  obscureText: isPasswordVisible,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) => password = value!,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Mot de passe oublié ?',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 211, 50, 50),
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Vous n'avez pas de compte ?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Créer un compte",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 211, 50, 50),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: isValidBtn
                                  ? () {
                                      validationForm();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => home2(),
                                        ),
                                      );
                                    }
                                  : () {
                                      debugPrint('Error....');
                                    },
                              child: Text(
                                'Continuer',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isValidBtn
                                    ? const Color.fromARGB(255, 211, 50, 50)
                                    : Color.fromARGB(255, 224, 7, 7)
                                        .withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 160, vertical: 10),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: const Text(
                      'Bienvenue dans l\'application miroir Sara! By',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Text(
                '@TksDesign',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 224, 7, 7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: const Text(
                  'Continuer',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 211, 50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
