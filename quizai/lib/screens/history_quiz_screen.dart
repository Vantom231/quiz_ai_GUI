import 'package:flutter/material.dart';
import 'package:quizai/models/question.dart';
import 'package:quizai/screens/quiz_finished_screen.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/session.dart';


class QuizHistoryScreen extends StatefulWidget {
    const QuizHistoryScreen ({super.key, required this.id});

        final int id ;

    @override
        State<QuizHistoryScreen> createState() => _QuizHistoryScreenState();
}


class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
   
    bool _isQuizGenerated = false;      // indicated if Api was fetched or not
    int _selectedQuestion = 0;          // id of current displayed question
    String _subject = "Quiz";

    //question list with some placeholder before fetching from API
    List<Question> questionsList = [Question().loadNew("","","","","","a")];

    final double _quizFormWidth = 600;


    // builds questionsList from API
    void buildQuestions(Function fnc, id) async{
        List<dynamic> response = await Session.getMultiple("api/history/quiz/$id/questions");
        List<Question> list = [];
        
        for (var res in response) {
                 list.add(Question().loadHistory(res));
                 
                }
        fnc(list);

        }


    Widget questionIndicatorButton(int questionNumber) {
        return Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: questionNumber == _selectedQuestion? AppTheme.accent : AppTheme.secondary,
                        ),
                    constraints: const BoxConstraints(minWidth: 20, maxWidth: 25, minHeight: 10, maxHeight: 10),
                    icon: Container(),
                    onPressed: () {
                    setState(() {
                            _selectedQuestion = questionNumber;
                            });
                    },
                    ),
                );
    }

    Widget bottomButton(String text, IconData icon, IconAlignment iconAlignment, VoidCallback? pressed) {
        return ElevatedButton.icon(
                label: Text(text, style: TextStyle(color: AppTheme.white)),
                icon: Icon(icon, color: AppTheme.white),
                iconAlignment: iconAlignment,
                onPressed: pressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    )
                );
    }

    Widget radioListButton(BuildContext context, String text, Anwsers val) {
        Color bg = AppTheme.secondary;
        Color acc = Colors.red;

        if (val == questionsList[_selectedQuestion].selectedAnwser) bg = Colors.red;
        if (val == questionsList[_selectedQuestion].correctAnwser) bg = Colors.green;


        return Material(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppTheme.primary,
                            width: 3,
                            )
                        ),
                    child: RadioListTile<Anwsers>(
                        tileColor: bg,
                        selectedTileColor: acc, 
                        activeColor: AppTheme.accent,
                        title: Text(text, style: const TextStyle(color: AppTheme.white)),
                        value: val,
                        groupValue: questionsList[_selectedQuestion].selectedAnwser,
                        onChanged: (Anwsers? value) {
                        setState(() {
                                });
                        },
                        ),
                    ),
                    );
    }

    @override
        Widget build(BuildContext context) {
            //_screenWidth = MediaQuery.sizeOf(context).width;

            if (!_isQuizGenerated) {
                buildQuestions((list) {
                    setState(() {
                        questionsList = list;
                        _isQuizGenerated = true;
                        });
                    }, widget.id);
            }

            return Scaffold(
                backgroundColor: AppTheme.dark,
                  body: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 200, right: 200),
                          child: Container(
                              color: AppTheme.primary,
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                      Row(
                                      children: [
                                      IconButton(
                                      onPressed: () {
                                          Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close_rounded, size: 30, color: AppTheme.accent),
                                      ),
                                      ]
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          for (int i = 0; i < questionsList.length; i++) questionIndicatorButton(i),
                                          ]
                                         ),
                                      Expanded(
                                              child: SizedBox(
                                                  width: _quizFormWidth,
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                      Flexible(child: Text(questionsList[_selectedQuestion].question, style: TextStyle(color: AppTheme.white, fontSize: 25)))
                                                      ]
                                                      ),
                                                  ),
                                              ),
                                      Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                              SizedBox(
                                                  height: 260,
                                                  width: _quizFormWidth,
                                                  child: Column(
                                                      children: <Widget>[
                                                      radioListButton(context, questionsList[_selectedQuestion].anwserA, Anwsers.A),
                                                      radioListButton(context, questionsList[_selectedQuestion].anwserB, Anwsers.B),
                                                      radioListButton(context, questionsList[_selectedQuestion].anwserC, Anwsers.C),
                                                      radioListButton(context, questionsList[_selectedQuestion].anwserD, Anwsers.D),
                                                      ],
                                                      )
                                                  )
                                              ],
                                         ),
                                      Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                              Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                  bottomButton("Powrót", Icons.arrow_left_outlined, IconAlignment.start                                             
                                                      , _selectedQuestion <= 0? null : () {
                                                      setState((){_selectedQuestion--;});
                                                      })
                                                  ]
                                                  ),
                                              Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                  bottomButton("Następne", Icons.arrow_right_outlined, IconAlignment.end, 
                                                      _selectedQuestion >= questionsList.length-1 ? null : () {
                                                      setState((){_selectedQuestion++;});
                                                      }),
                                                  ]
                                                  ),
                                              ]
                                                  )
                                                  ]
                                                  ),
                                              ),
                                              ),
                                              ),
            );
        }
}
