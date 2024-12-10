import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:quizai/models/question.dart';
import 'package:quizai/utils/app_styles.dart';
//import 'package:quizai/screens/quiz_resoult_screen.dart';
import 'package:quizai/utils/session.dart';


class QuizFinishedScreen extends StatefulWidget {
    const QuizFinishedScreen ({super.key, required this.quesitonList, required this.subjectId, required this.refresh});

    final List<Question> quesitonList;
    final int subjectId;
    final Function refresh;

    @override
        State<QuizFinishedScreen> createState() => _QuizFinishedScreenState();
}



class _QuizFinishedScreenState extends State<QuizFinishedScreen> {

    bool _isProcessed = false;

    int totalQuestionNumber = 10;
    int correctQuestionNumber = 2;
    int accuracy = 10;


    void process(List<Question> questionList, Function fnc) {
        int total = questionList.length;
        int correct = 0;
        int accuracy = 0;
        
        for (var qw in questionList) {
                  if (qw.correctAnwser == qw.selectedAnwser) correct++;
                }

        accuracy = (correct/total*100).round();

        fnc(total,correct,accuracy);
    }

    void saveToApi(List<Question> questionList, int subjectId) async {
        Map<dynamic, dynamic> res = await Session.get("api/subject/$subjectId");
        String subjectName = res['name'];

        var body = {"number": 0, "subject": subjectName, "accuracy": accuracy};

        Map<dynamic, dynamic> quizRes = await Session.post2obj("api/history/quiz", body);
        int quizId = quizRes['id'];

        String prompt = "[";

        for (var qw in questionList) {
                  prompt += qw.prepare() + ",";
                }

            prompt = prompt.substring(0, prompt.length-1) + "]";
            print(prompt);

        int quantity = questionList.length;

        Future<dynamic> res1 = Session.post("api/history/quiz/$quizId/questions", prompt);
        Future<dynamic> res2 = Session.post("api/subject/$subjectId/resoults", '{"accuracy":$accuracy,"questions_quantity":$quantity}');

        await res1;
        await res2;

    }

    @override
        Widget build(BuildContext context) {

            if (!_isProcessed) {
                process(widget.quesitonList, (total, correct, accuracy) {setState(
                            () {
                            totalQuestionNumber = total;
                            correctQuestionNumber = correct;
                            this.accuracy = accuracy;
                            _isProcessed = true;
                            }
                            );
                        });
                saveToApi(widget.quesitonList, widget.subjectId);
            }

            return Scaffold(
                    backgroundColor: AppTheme.bg,
                    body: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            const Text(
                                "Wynik:",
                                style: TextStyle(
                                    color: AppTheme.accent, 
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    ),
                                ),
                            SizedBox(height: 30),

                            AnimatedRadialGauge(
                                duration: const Duration(),
                                curve: Curves.elasticOut,
                                value: correctQuestionNumber.toDouble(),
                                radius: 200,

                                axis: GaugeAxis(
                                    min: 0,
                                    max: totalQuestionNumber.toDouble(),
                                    degrees: 180,

                                    style: const GaugeAxisStyle(
                                        thickness: 20,
                                        background: AppTheme.accent,
                                        segmentSpacing: 4,
                                        ),
                                    pointer: GaugePointer.needle(
                                        width: 16,
                                        height: 200,
                                        borderRadius: 16,
                                        color: AppTheme.white,
                                        ),
                                    ),
                                ),
                                SizedBox(height: 30),

                                Text("ilość poprawnych odpowiedzi: $correctQuestionNumber/$totalQuestionNumber",style: const TextStyle(color: AppTheme.white)),
                                Text("procent poprawnych odpowiedzi: $accuracy", style: const TextStyle(color: AppTheme.white)),
                                SizedBox(height: 30),

                                ElevatedButton(
                                        child: const Text("powrót"),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.accent,
                                            foregroundColor: AppTheme.white,
                                            ),
                                        onPressed: () {
                                        Navigator.pop(context);
                                        widget.refresh();
                                        }
                                        )
                                    ]
                                    )
                                    ]
                                    )
                                    );
        }
}
 
