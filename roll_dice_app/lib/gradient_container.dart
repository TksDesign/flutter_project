import 'package:flutter/material.dart';
import 'package:roll_dice_app/Roll_Dice.dart';

const startAlignement = Alignment.topCenter;
const endAlignement = Alignment.centerLeft;

class GradientContainer extends StatefulWidget {
  const GradientContainer(
      this.colors1, this.colors2, this.colors3, this.colors4, this.colors5,
      {super.key});

  final Color colors1;
  final Color colors2;
  final Color colors3;
  final Color colors4;
  final Color colors5;

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _AnimationStart;
  late Animation<Alignment> _AnimationEnd;

  @override
  void initState() {
    super.initState();
//  controller la duree de l'animation
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

// Animation de positionnement
    _AnimationStart = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.topCenter,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _AnimationEnd = AlignmentTween(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    
// ce qui declanchee l'animation
    _controller.forward();
  }

 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: _AnimationStart.value,
              end: _AnimationEnd.value,
              stops: [0.1, 0.5, 0.7, 0.9, 1],
              colors: [
                widget.colors1,
                widget.colors2,
                widget.colors3,
                widget.colors4,
                widget.colors5,
              ],
            )),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              child: Center(
                  child: _controller.isCompleted ? RollDice() : const SizedBox()),
            ),
          );
        });
  }
}
