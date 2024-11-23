import 'package:flutter/material.dart';
import 'package:quizai/models/question.dart';
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

        Map<dynamic, dynamic> quizRes = await Session.post2("api/history/quiz", '{ "number": 0, "subject": "$subjectName", "accuracy":$accuracy}');
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

//        Navigator.pop(context);
//        Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => QuizResultScreen())
//        );
        


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
             body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("correctly anwsered: $correctQuestionNumber/$totalQuestionNumber"),
                    Text("accuracy: $accuracy"),
                    ElevatedButton(
                    child: Text("back"),
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
