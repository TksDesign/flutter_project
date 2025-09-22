import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roll_dice_app/style_text.dart';

class RollDice extends StatefulWidget {
  RollDice({super.key});
  @override
  State<RollDice> createState() {
    return _RollDiceState();
  }
}

class _RollDiceState extends State<RollDice> {
  bool _isPressed = false;

  var _activeDiceImage = "assets/images/1.webp";
  void Roll_dice() {
    setState(() {
      _isPressed = !_isPressed;
      switch (_activeDiceImage) {
        case "assets/images/1.webp":
          _activeDiceImage = "assets/images/2.png";
          break;
        case "assets/images/2.png":
          _activeDiceImage = "assets/images/3.webp";
          break;
        case "assets/images/3.webp":
          _activeDiceImage = "assets/images/4.png";
          break;
        case "assets/images/4.png":
          _activeDiceImage = "assets/images/5.webp";
          break;
        case "assets/images/5.webp":
          _activeDiceImage = "assets/images/6.png";
          break;
        default:
          _activeDiceImage = "assets/images/1.webp";
          break;
      }
      print('1');
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      //  occupe tout l'espace disponible
      children: [
        const StyleText(
          'Let\'s play a game',
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 4, 4, 4).withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            width: 200,
            height: 200,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                final rotateAnim =
                    Tween(begin: 0.0, end: pi).animate(animation);
                return AnimatedBuilder(
                  animation: rotateAnim,
                  child: child,
                  builder: (context, child) {
                    final isUnder = (ValueKey(_activeDiceImage) != child!.key);
                    var tilt = isUnder
                        ? min(rotateAnim.value, pi / 2)
                        : rotateAnim.value;
                    return Transform(
                      transform: Matrix4.rotationZ(tilt),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                );
              },
              child: Image.asset(
                _activeDiceImage,
                key: ValueKey(_activeDiceImage),
                fit: BoxFit.contain,
              ),
            )),
        const SizedBox(
          height: 16,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: _isPressed ? EdgeInsets.all(12) : const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isPressed
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(255, 57, 23, 89),
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: TextButton(
            onPressed: Roll_dice,
            child: Text(
              'Roll Dice',
              style: TextStyle(
                  color: _isPressed
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : const Color.fromARGB(255, 57, 23, 89),
                  fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
