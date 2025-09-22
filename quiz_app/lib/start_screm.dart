import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';

class StartScrem extends StatefulWidget {
  const StartScrem(this.startQuiz, this.colors1, this.colors2, this.colors3,
      this.colors4, this.colors5,
      {super.key});
  final Color colors1;
  final Color colors2;
  final Color colors3;
  final Color colors4;
  final Color colors5;
  final void Function() startQuiz;
  @override
  State<StartScrem> createState() => _StartScremState();
}

const startAlignement = Alignment.center;
const endAlignement = Alignment.center;

class _StartScremState extends State<StartScrem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _AnimationStart;
  late Animation<Alignment> _AnimationEnd;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _AnimationStart = AlignmentTween(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _AnimationEnd = AlignmentTween(
      begin: Alignment.centerLeft,
      end: endAlignement,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _ispressed = true;
  bool _ishover = true;
  IconData direction = Icons.arrow_circle_right_outlined;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.colors1,
                  widget.colors2,
                  widget.colors3,
                  widget.colors4,
                  widget.colors5,
                ],
                begin: _AnimationStart.value,
                end: _AnimationEnd.value,
                stops: const [0.1, 0.3, 0.5, 0.7, 0.9],
              ),
            ),
            child: Center(
              child: _controller.isCompleted
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Opacity(
                          opacity: 0.5,
                          child: Image(
                            image: AssetImage('assets/images/quiz-logo.png'),
                            height: 300,
                            width: 300,
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        SizedBox(
                          width: 210,
                          child: Text(
                            'click on the button to answer the quiz',
                            style: TextStyle(
                              fontSize: 18,
                              color: widget.colors3,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        OutlinedButton(
                          onHover: (value) {
                            setState(() {
                              _ishover = !_ishover;
                            });
                          },
                          onPressed: () async {
                            setState(() {
                              _ispressed = !_ispressed;
                            });
                            await Future.delayed(const Duration(milliseconds: 400));
                            widget.startQuiz();
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: _ishover
                                  ? widget.colors3
                                  : const Color.fromARGB(150, 255, 255, 255),
                              foregroundColor:
                                  _ishover ? Colors.white : widget.colors5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              side:
                                  BorderSide(width: 2, color: widget.colors3)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('participe'),
                              const SizedBox(
                                width: 10,
                              ),
                              AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: _ispressed
                                      ? const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          key: ValueKey('icon'),
                                        )
                                      : const SizedBox(
                                          key: ValueKey('empty'),
                                        )),
                            ],
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
            ),
          );
        });
  }
}
