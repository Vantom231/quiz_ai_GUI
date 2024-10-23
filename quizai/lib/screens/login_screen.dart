import 'package:flutter/material.dart';
import 'package:quizai/screens/home_screen.dart';
import 'package:quizai/utils/app_styles.dart';

class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    @override
        Widget build(BuildContext context) {
            return Scaffold(
                    backgroundColor: AppTheme.dark,
                    body: Column(
                        children: [
                        Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.white,
                                        fontSize: 35,
                                        ),
                                    textAlign: TextAlign.center,
                                    ),]

                               ),
                               ),
                            Padding(
                             padding: EdgeInsets.all(16.0),
                             child: Row(
                                children: [
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            labelText: 'Username',
                                            hintText: 'Please enter your username',
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder(),
                                            ),
                                        maxLines: 3,
                                        onChanged: (text) {
                                        print('Entered value: $text');
                                        }

                                        ),
                                    ),
                                ]
                               ),
                               ),
                            Padding(
                                padding: EdgeInsets.all(16.0), 
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                    _mainButton(() {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const HomeScreen(title: "QuizAI"))
                                                );
                                        }, 'Button'),
                                    ],
                               )
                                ),
                            ],
                            ),
                            );
        }

    TextField textField(){
        return TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username',
            ),
        );
    }
    ElevatedButton _mainButton(Function()? onPressedf,String data) {
        return ElevatedButton(
                onPressed: onPressedf,
                child: Text(data)
                );
    }
}
