import 'package:flutter/material.dart';
import 'package:quiz_app/data/question.dart';
import 'package:quiz_app/models/answer_bouton.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestioScreen extends StatefulWidget {
  const QuestioScreen({super.key});

  @override
  State<QuestioScreen> createState() => _QuestioScreenState();
}

class _QuestioScreenState extends State<QuestioScreen>
    with TickerProviderStateMixin {
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

  void animatedBackContainer() async {
    setState(() {
      _showContentOpacity = 0.5;
      _backContainerTop = -0.2;
      _backContainerHeight = 440;
      _frontContainerHeight = 400;
      _fontContainerTop = -0.7;
      _colorTranstition = Colors.white70;
      _frontContainerwith = 0.87;
      _backContainerwith = 0.93;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      _showContentOpacity = 0;
      _backContainerTop = 1.6; // monte plus haut pour un bel effet
      _colorTranstition = Colors.white60;
      _fontContainerTop = -0.6;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _backContainerHeight = 400;
      _frontContainerHeight = 440;
      _frontContainerwith = 0.93;
      _backContainerwith = 0.87;
      cuurrentQuestionIndex++;
      if (cuurrentQuestionIndex >= questions.length) {
        cuurrentQuestionIndex = 0; // Reset to the first question
      }
    });
    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      _fontContainerTop = -0.7;
      _backContainerTop = -1;
      _colorTranstition = Colors.white70;
      _showContentOpacity = 1;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      _colorTranstition = Colors.white;
      _fontContainerTop = -0.7;
    });
  }

  @override
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 12),
        height: _frontContainerHeight,
        width: width * _frontContainerwith,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: _colorTranstition,
        ),
        child: AnimatedOpacity(
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
                            cuurrentQuestionIndex.toString(),
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('of',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(width: 2),
                      const Text('09',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                              onTap: animatedBackContainer,
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
      ),
    );
  }
}
