import 'package:flutter/material.dart';
import 'package:quiz_app2/data/question.dart';
import 'package:quiz_app2/models/answer_bouton.dart';
import 'package:quiz_app2/models/quiz_question.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestioScreen extends StatefulWidget {
  const QuestioScreen({super.key, required this.onAnswerSelected});
  final void Function(String answer) onAnswerSelected;

  @override
  State<QuestioScreen> createState() => _QuestioScreenState();
}

class _QuestioScreenState extends State<QuestioScreen>
    with TickerProviderStateMixin {
// animation de progressif bar

  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _progressAnimation;

  void initState() {
    super.initState();

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: const Color.fromARGB(210, 137, 80, 191),
    ).animate(_colorController)
      ..addListener(() {
        setState(() {
          _colorTranstition = _colorAnimation.value!;
        });
      });
  }
// animation de progressif bar

  Color colorP = const Color.fromARGB(255, 91, 39, 140);
  double _backContainerTop = -1;
  double _fontContainerTop = -0.7;
  Color _colorTranstition = Colors.white;
  double _backContainerHeight = 400;
  double _frontContainerHeight = 440;
  double _showContentOpacity = 1;
  double _frontContainerwith = 0.93;
  double _backContainerwith = 0.87;

  // question current
  var cuurrentQuestionIndex = 0;

  // si le quiz est terminé
  bool quizFinished = false;

  void animatedBackContainer(String selecteAnswer) async {
    if (cuurrentQuestionIndex < questions.length - 1) {
      setState(() {
        _showContentOpacity = 0.5;
        _backContainerTop = -0.2;
        _backContainerHeight = 440;
        _frontContainerHeight = 400;
        _fontContainerTop = -0.7;
        _colorTranstition = Colors.white70;
        _frontContainerwith = 0.70;
        _backContainerwith = 0.93;
      });

      await Future.delayed(const Duration(milliseconds: 350));

      setState(() {
        _showContentOpacity = 0;
        _backContainerTop = 1.6;
        _colorTranstition = Colors.white60;
        _fontContainerTop = -0.6;
      });

      setState(() {
        _backContainerHeight = 400;
        _frontContainerHeight = 440;
        _frontContainerwith = 0.93;
        _backContainerwith = 0.87;
        // changement de question
        cuurrentQuestionIndex++;
      });
      await Future.delayed(const Duration(milliseconds: 350));

      setState(() {
        _fontContainerTop = -0.7;
        _backContainerTop = -1;
        _colorTranstition = Colors.white70;
        _showContentOpacity = 1;
      });

      await Future.delayed(const Duration(milliseconds: 350));

      setState(() {
        _colorTranstition = Colors.white;
        _fontContainerTop = -0.7;
      });
    }

    // Si c'est la dernière question
    if (cuurrentQuestionIndex == questions.length - 1) {
      setState(() {
        quizFinished = true;
        _showContentOpacity = 0;
      });
      // Animation de fin
      await Future.delayed(const Duration(milliseconds: 00));
      setState(() {
        _backContainerHeight = 0;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _colorTranstition = Colors.white; // Couleur de la barre
      });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _backContainerTop = -0.2;
        _frontContainerHeight = 10; // Barre fine
        _colorTranstition = Colors.white; // Couleur de la barre
      });
      await Future.delayed(const Duration(milliseconds: 550));
      _colorController.forward(); // Démarrer l'animation de couleur
    }
    await Future.delayed(const Duration(milliseconds: 2150));

    widget.onAnswerSelected(selecteAnswer);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorP,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          'Questionnaire',
          style: TextStyle(color: Colors.white, fontSize: 21),
        ),
      ),
      body: Container(
        color: colorP,
        width: double.infinity,
        child: Stack(children: [
          _buildBackContainer(context),
          _buildFrontContainer(context),
        ]),
      ),
    );
  }

  Widget _buildBackContainer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedAlign(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment(0, _fontContainerTop),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _backContainerHeight,
        width: width * _backContainerwith,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white60,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFrontContainer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentQuestion = questions[cuurrentQuestionIndex];

    return AnimatedAlign(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment(0, _backContainerTop),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 12),
        height: _frontContainerHeight,
        width: width * _frontContainerwith,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: _colorTranstition,
        ),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Container(
                  width: width * _frontContainerwith * _progressAnimation.value,
                  height: 10, // Hauteur fine
                  decoration: const BoxDecoration(
                    color: const Color.fromARGB(210, 137, 80, 191),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _showContentOpacity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(1, -4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 4, color: colorP),
                              ),
                            ),
                            child: Text(
                              (cuurrentQuestionIndex + 1).toString(),
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('of',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(width: 2),
                        const Text('06',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        currentQuestion.text,
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ...currentQuestion.getshuffledAnswers().map((answer) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              AnswerBouton(
                                text: answer,
                                onTap: () {
                                  animatedBackContainer(answer);
                                },
                              ),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
