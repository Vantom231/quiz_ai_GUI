import 'package:flutter/material.dart';
import 'package:quizai/screens/home_screen.dart';
import 'package:quizai/utils/app_styles.dart';

enum Anwsers {A, B, C, D, N}

class QuizScreen extends State<HomeScreen>{
    void state;

    QuizScreen(Function state) {
        this.state = state;
    }

    Anwsers? _anwser = Anwsers.N;

    @override
        Widget build(BuildContext context) {
            return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [Text("that funny thin that's shows which question is that", style: TextStyle(color: AppTheme.white))
                        ]
                       ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("that funny thing that shows you a question", style: TextStyle(color: AppTheme.white))
                        ]
                       ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(
                            height: 600,
                            width: 600,
                            child: Column(
                                children: <Widget>[
                                Flexible(
                                    child: RadioListTile<Anwsers>(
                                        title: const Text('ODP. A'),
                                        value: Anwsers.A,
                                        groupValue: _anwser,
                                        onChanged: (Anwsers? value) {
                                        () { state(() {
                                                _anwser = value;
                                                })
                                        },
                                        ),
                                    ),
                                Flexible(
                                    child: RadioListTile<Anwsers>(
                                        title: const Text('ODP.B'),
                                        value: Anwsers.B,
                                        groupValue: _anwser,
                                        onChanged: (Anwsers? value) {
                                        state(() {
                                                _anwser = value;
                                                });
                                        },
                                        ),
                                    ),
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
                                                Text("that funny thing called back button", style: TextStyle(color: AppTheme.white))
                                                ]
                                                ),
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                Text("that funny thing called next button", style: TextStyle(color: AppTheme.white))
                                                ]
                                                ),
                                            ]
                                       )
                                        ]
                                        );
        }
}
