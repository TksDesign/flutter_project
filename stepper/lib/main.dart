/*import 'package:flutter/material.dart';

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
  //confirguration de stepper
  int initial_step = 0;
  List<Step> steps = [
    const Step(
      title: Text(
        'confirmer votre nom et prenom',
        style: TextStyle(color: Colors.blue),
      ),
      content: Text('DaphaneTissie'),
      isActive: true,
      subtitle: Text('Etape 1'),
    ),
    const Step(
      title: Text(
        'confirmer votre adress',
        style: TextStyle(color: Colors.orange),
      ),
      content: Text('Yaounde emana tradex'),
      isActive: true,
      subtitle: Text('Etape 2'),
    ),
    const Step(
      title: Text(
        'confirmer votre numero de telephone',
        style: TextStyle(color: Colors.purple),
      ),
      content: Text('+237 657 055 553'),
      isActive: true,
      subtitle: Text('Etape 3'),
    ),
    const Step(
      title: Text(
        'donner votre sexe',
        style: TextStyle(color: Colors.red),
      ),
      content: Text('Masculin'),
      isActive: true,
      subtitle: Text('Etape 4'),
    ),
    Step(
      title: const Text(
        'MERCI',
        style: TextStyle(color: Colors.green),
      ),
      content: Image.network(
          'https://img.freepik.com/vecteurs-premium/mot-merci-sourire-langue-francaise-merci-creation-vectorielle-fond-blanc_644677-1320.jpg?semt=ais_hybrid'),
      isActive: true,
      state: StepState.complete,
      subtitle: Text('FIN'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        leading: const Icon(
          Icons.menu,
          size: 35,
        ),
        title: Text('Bonjour'),
        actions: const <Widget>[
          Icon(
            Icons.phone,
            size: 35,
          )
        ],
      ),
      body: Stepper(
        currentStep: this.initial_step,
        steps: steps,
        type: StepperType.vertical,
        onStepTapped: (Step) {
          setState(() {
            initial_step = Step;
          });
        },
        //suite au click qu'est ce qui va se passer
        onStepContinue: () {
          setState(() {
            if (initial_step < steps.length - 1) {
              initial_step = initial_step + 1;
            } else {
              initial_step = 0;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (initial_step > 0) {
              initial_step = initial_step - 1;
            } else {
              initial_step = 0;
            }
          });
        },
      ),
      /* body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Bonjour',
              style: TextStyle(fontSize: 35),
            )
          ],
        ),
      ),*/
    );
  }
}
*/

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepperWithIcons(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StepperWithIcons extends StatefulWidget {
  @override
  _StepperWithIconsState createState() => _StepperWithIconsState();
}

class _StepperWithIconsState extends State<StepperWithIcons> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validation achats'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 47, 186, 221),
                              width: 5),
                          borderRadius: BorderRadius.circular(29),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 76, 175, 162)
                                  .withOpacity(0.1),
                              spreadRadius: 10,
                              blurRadius: 5,
                              offset: Offset(0, 1), // Décalage de l'ombre
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://media.istockphoto.com/id/2165462299/photo/woman-shopping-at-a-convenience-store-and-checking-her-receipt.jpg?s=1024x1024&w=is&k=20&c=20k3OyDFJo2mLUnZI-frcd1-bOYvrhQrl_IlrGtk-Lo='),
                      ),
                    ),
                  ),
                ),
                _buildStep(
                  stepIndex: 0,
                  icon: Icons.person,
                  title: 'Étape 1',
                  description: 'Création de votre profil.',
                  isActive: _currentStep == 0,
                  isCompleted: _currentStep > 0,
                ),
                _buildStep(
                  stepIndex: 1,
                  icon: Icons.shopping_cart,
                  title: 'Étape 2',
                  description: 'Ajout des produits au panier.',
                  isActive: _currentStep == 1,
                  isCompleted: _currentStep > 1,
                ),
                _buildStep(
                  stepIndex: 2,
                  icon: Icons.payment,
                  title: 'Étape 3',
                  description: 'Validation de la commande.',
                  isActive: _currentStep == 2,
                  isCompleted: _currentStep > 2,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (_currentStep > -1)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentStep--;
                            });
                          },
                          child: const Text(
                            'Précédent',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 162, 58, 50)),
                          ),
                        ),
                      if (_currentStep < 3)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentStep++;
                            });
                          },
                          child: Text(
                            'Suivant',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 73, 186, 192),
                            elevation: 3,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required int stepIndex,
    required IconData icon,
    required String title,
    required String description,
    required bool isActive,
    required bool isCompleted,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isCompleted
            ? Colors.green
            : (isActive
                ? const Color.fromARGB(255, 29, 137, 161)
                : Colors.grey),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(title),
      subtitle: Text(description),
      trailing: isCompleted
          ? Icon(
              Icons.check,
              color: Colors.green,
            )
          : null,
    );
  }
}
