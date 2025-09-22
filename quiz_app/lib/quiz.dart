import 'package:flutter/material.dart';
import 'package:quiz_app/questio_screen.dart';
import 'package:quiz_app/start_screm.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
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

  void switchScreen() {
    setState(() {
      activeScreen = 'questionscreen';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidget = activeScreen == 'startPage'
        ? StartScrem(
            switchScreen,
            const Color.fromARGB(255, 137, 59, 213),
            const Color.fromARGB(255, 173, 121, 243),
            const Color.fromARGB(255, 57, 23, 89),
            const Color.fromARGB(255, 100, 103, 159),
            const Color.fromARGB(255, 88, 86, 142),
            key: const ValueKey('startPage'),
          )
        : const QuestioScreen(
            key: ValueKey('questionscreen'),
          );
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: screenWidget);
  }
}
