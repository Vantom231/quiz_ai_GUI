
import 'package:flutter/material.dart';
import 'package:quizai/screens/history_quiz_screen.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/models/history_quiz.dart';
import 'package:quizai/utils/session.dart';

class HistoryList {

    TextStyle style1 = TextStyle(
        color: AppTheme.white,
        fontSize: 16,
    );
    TextStyle style2 = TextStyle(
        color: AppTheme.accent,
        fontSize: 16,
    );

    Future<List<HistoryQuiz>> _prepare() async{
        List<HistoryQuiz> list = [];
        var response = await Session.getMultiple("api/history/quiz");

        for (int i = response.length-1; i >= 0; i--) {
            HistoryQuiz quiz = HistoryQuiz();
            quiz.createFromResponse(response[i]);
            list.add(quiz);
            print(quiz.toString());

        }

        return list;
    }


    Future<Widget> build(Function onPressed, context) async {
        var quizes = await _prepare();


        print(quizes.length);

        return Container(
                child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                    Column(
                    children:[
                    ...quizes.map((i) { return Padding(
                        padding: EdgeInsets.all(5),
                      child: Container(
                          height: 70,
                          color: AppTheme.secondary,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Row(
                                children: [
                                Text("numer: ", style: style1),
                                Text(i.number.toString(), style: style2),
                                ]
                               ),
                            Row(
                                children: [
                                Text("Przedmiot: ", style: style1),
                                Text(i.subject, style: style2),
                                ]
                               ),
                            Row(
                            children: [
                                Text("Poprawne: ", style: style1),
                                Text(i.accuracy.toString(), style: style2),
                            ]),
                            ElevatedButton.icon(
                                onPressed: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => QuizHistoryScreen(id: i.id))
                                        );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.accent,
                                ),
                                label: Text("Otwórz", style: TextStyle(color: AppTheme.white),textAlign: TextAlign.center,),
                                icon: Icon(Icons.arrow_right, color: AppTheme.white),
                                iconAlignment: IconAlignment.end,
                            )
                            ]
                            ),
                          ),
                          ),
                    );
                    }).toList(),
                    ]),
                    ],
                    )
                );
    }

}
