import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';

class QuizScreen extends StatefulWidget {
    const QuizScreen({super.key});

    @override
    State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
    @override
        Widget build(BuildContext context) {
            return Scaffold(
                    backgroundColor: AppTheme.dark,
                    body: Text(
                    'Quiz_Screen',
                    style: TextStyle(
                    color: AppTheme.white,
                    )
                    )
                    );
        }
}
