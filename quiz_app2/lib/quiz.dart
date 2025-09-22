import 'package:flutter/material.dart';
import 'package:quiz_app2/data/question.dart';
import 'package:quiz_app2/questio_screen.dart';
import 'package:quiz_app2/resultat_screen.dart';
import 'package:quiz_app2/start_screm.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  List<String> selectAnswe = [];

  var activeScreen = 'startPage';
  // Widget? activeScreen;
  @override
  // void initState() {
  //   activeScreen = StartScrem(
  //     switchScreen,
  //     const Color.fromARGB(255, 137, 59, 213),
  //     const Color.fromARGB(255, 173, 121, 243),
  //     const Color.fromARGB(255, 57, 23, 89),
  //     const Color.fromARGB(255, 100, 103, 159),
  //     const Color.fromARGB(255, 88, 86, 142),
  //   );
  //   // TODO: implement initState
  //   super.initState();
  // }

// c'est ici qu'on va jouter les question selectionnées

  void chooseAnswer(String answer) {
    print('Answer received: $answer');
    selectAnswe.add(answer);

    if (selectAnswe.length == questions.length - 1) {
      setState(() {
        // Reset the quiz to the start page
        activeScreen = 'resultatscreen';
      });
    }
  }

  void onRestart() {
    setState(() {
      selectAnswe.clear();
      activeScreen = 'questionscreen';
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questionscreen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    if (activeScreen == 'startPage') {
      screenWidget = StartScrem(
        switchScreen,
        const Color.fromARGB(255, 137, 59, 213),
        const Color.fromARGB(255, 173, 121, 243),
        const Color.fromARGB(255, 57, 23, 89),
        const Color.fromARGB(255, 100, 103, 159),
        const Color.fromARGB(255, 88, 86, 142),
        key: const ValueKey('startPage'),
      );
    } else if (activeScreen == 'questionscreen') {
      screenWidget = QuestioScreen(
        onAnswerSelected: chooseAnswer,
        key: ValueKey('questionscreen'),
      );
    } else if (activeScreen == 'resultatscreen') {
      screenWidget = ResultatScreen(
        onRestart: onRestart,
        chooseAnswer: selectAnswe,
        key: ValueKey('value'),
      );
    } else {
      screenWidget = SizedBox();
    }

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 00),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: screenWidget);
  }
}
