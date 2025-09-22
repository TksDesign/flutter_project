import 'package:flutter/material.dart';
import 'package:quiz_app2/data/question.dart';
import 'package:quiz_app2/question_summary.dart';

class ResultatScreen extends StatefulWidget {
  final VoidCallback onRestart;
  final List<String> chooseAnswer;
  const ResultatScreen(
      {super.key, required this.chooseAnswer, required this.onRestart});

  @override
  State<ResultatScreen> createState() => _ResultatScreenState();
}

class _ResultatScreenState extends State<ResultatScreen>
    with SingleTickerProviderStateMixin {
  Color colorP = const Color.fromARGB(255, 91, 39, 140);
  Color colorS = const Color.fromARGB(255, 95, 52, 135);

  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _progressAnimation2;

  // void affiche() {
  //   print(chooseAnswer.);
  // }
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < widget.chooseAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answer[0],
        'user_answer': widget.chooseAnswer[i],
      });
    }
    return summary;
  }

  late List<Map<String, Object>> summaryData;
  late int numTotalQuestion;
  late int numCorrectQuestion;
  late int numWrongQuestion;
  late double pourcentageCompilation;
  late double? note20;

  @override
  void initState() {
    super.initState();

    summaryData = getSummaryData();
    numTotalQuestion = questions.length - 1;
    numCorrectQuestion = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    numWrongQuestion = summaryData.where((data) {
      return data['user_answer'] != data['correct_answer'];
    }).length;
    pourcentageCompilation = (((summaryData.where((data) {
              return data['user_answer'] != null;
            }).length) /
            numTotalQuestion) *
        100);
    note20 = numCorrectQuestion * 3;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: (numCorrectQuestion / 6))
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _progressAnimation2 =
        Tween<double>(begin: 400, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mapValues = {
      "leftValues": {
        "Pourcentage": {
          "title": pourcentageCompilation.toStringAsFixed(1),
          "description": "completion",
          "color": colorS,
          "isPercentage": true,
        },
        "Correct": {
          "title": numCorrectQuestion.toString(),
          "description": "correct",
          "color": Colors.green,
          "isPercentage": false
        },
      },
      "rightValue": {
        "Total": {
          "title": numTotalQuestion.toString(),
          "description": "total question",
          "color": colorS,
          "isPercentage": false
        },
        "Wrong": {
          "title": numWrongQuestion.toString(),
          "description": "wrong",
          "color": Colors.red,
          "isPercentage": false
        },
      }
    };
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorP,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 350,
                  width: double.infinity,
                  child: Stack(children: [
                    alignWidget(x: -2, y: -1, h: 200, w: 200),
                    alignWidget(x: 0, y: -1.5, h: 120, w: 120),
                    alignWidget(x: 0.5, y: -0.7, h: 70, w: 70),
                    alignWidget(x: 2, y: 0.5, h: 200, w: 200),
                    Align(
                      alignment: Alignment(0, 3.2),
                      child: Container(
                        height: 250,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: colorP.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, -1.8),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                child: Align(
                                  alignment: Alignment(0, -0.1),
                                  child: Text(
                                    '$note20',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: colorS,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, -1.6),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: Colors.transparent),
                                child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (context, child) {
                                      return CircularProgressIndicator(
                                        value: _progressAnimation.value,
                                        strokeWidth: 9,
                                        color: colorS,
                                        backgroundColor: const Color.fromARGB(
                                            255, 237, 229, 247),
                                      );
                                    }),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 80, left: 30, right: 30),
                              child: Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      centerWidget(
                                          resultgroup:
                                              mapValues["leftValues"]!),
                                      centerWidget(
                                          resultgroup:
                                              mapValues["rightValue"]!),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ]),
              SizedBox(
                height: 130,
              ),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_progressAnimation2.value, 0),
                      child: Container(
                        height: 320,
                        width: double.infinity,
                        child: QuestionSummary(summaryData),
                      ),
                    );
                  }),
              Container(
                child: OutlinedButton(
                    onPressed: () {
                      widget.onRestart();
                    },
                    child: Text('restart quiz')),
              )
            ],
          ),
        ),
      ),
    );
  }










  Center centerWidget({
    required final Map<String, Map<String, Object>> resultgroup,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: resultgroup.entries.map((key) {
          final value = key.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _buildCard(
                title: value["title"] as String,
                description: value["description"] as String,
                color: value["color"] as Color,
                isPercentage: value["isPercentage"] as bool),
          );
        }).toList(),
      ),
    );
  }

  Align alignWidget(
      {required double x,
      required double y,
      required double h,
      required double w}) {
    return Align(
      alignment: Alignment(x, y),
      child: Container(
        decoration: BoxDecoration(
          color: colorS,
          borderRadius: BorderRadius.circular(200),
        ),
        height: h,
        width: w,
      ),
    );
  }

  _buildCard(
      {required String title,
      required String description,
      required Color color,
      bool? isPercentage = true}) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, -10),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(100)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " ${title + (isPercentage == true ? "%" : "")}",
                  style: TextStyle(
                      fontSize: 18, color: color, fontWeight: FontWeight.bold),
                ),
                Transform.translate(
                  offset: const Offset(0, -5),
                  child: Text(
                    description,
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.8)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
