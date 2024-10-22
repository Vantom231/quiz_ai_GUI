import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';

class QuizScreen {
static Widget quizScreen() {
    return const Column(
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
            Text("That funny thing that shows you an anwser", style: TextStyle(color: AppTheme.white))
            ]
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
