import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizai/screens/home_screen.dart';
import 'package:quizai/utils/app_styles.dart';

import '../utils/session.dart';

class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
    TextEditingController loginController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    @override
      void dispose() {
          loginController.dispose();
          passwordController.dispose();

          super.dispose();
      }

    void handleLogin() async {
        String login = loginController.text;
        String password = passwordController.text;

        http.Response response = await Session.post("api/login", ' { "email": "$login", "password": "$password"}');

        print(response.statusCode);

        // if password and email don't match
        if (response.statusCode == 403) {
            showDialog(
                    
                    context:  context,
                    builder: (context) {
                    return AlertDialog(
                            content: Text("Błędny adres e-mail lub hasło")
                            );
                    }
                    );
            return;
        };

        if (response.statusCode != 200) {
            showDialog(
                    context: context,
                    builder: (context) {
                    return AlertDialog(
                            content: Text("Błąd serwera!!")
                            );
                    }
                    );
            return;
        };



        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen(title: "QuizAI"))
                );

    }

    
    Widget _loginForm() {
        return Column(
                        children: [
                        Padding(
                            padding: EdgeInsets.all(10.0),
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
                             padding: EdgeInsets.all(10.0),
                             child: ConstrainedBox(
                                constraints: BoxConstraints(
                                        minWidth: 100,
                                        maxWidth: 300,
                                        minHeight: 40,
                                        maxHeight: 50,
                                ),
                               child: TextField(
                                        controller: loginController,
                                          style: TextStyle(
                                        
                                            color: AppTheme.white,
                                          ),
                                          decoration: InputDecoration(
                                              labelText: 'Username',
                                              hintText: 'Please enter your username',
                                              prefixIcon: Icon(Icons.person),
                                              border: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppTheme.accent, width: 2.0)
                                              )
                                              ),
                                          maxLines: 3,
                               
                                          ),
                             ),
                                    ),
                              
                             Padding(
                             padding: EdgeInsets.all(10.0),
                             child:  ConstrainedBox(
                                constraints: BoxConstraints(
                                        minWidth: 100,
                                        maxWidth: 300,
                                        minHeight: 40,
                                        maxHeight: 50,
                                ),
                               child: TextField(
                                          controller: passwordController,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          style: TextStyle(
                                              color: AppTheme.white
                                          ),
                                          decoration: InputDecoration(
                                              focusColor: AppTheme.accent,
                                              labelText: 'Password',
                                              hintText: 'Please enter password',
                                              prefixIcon: Icon(Icons.key),
                                              border: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppTheme.accent, width: 2.0)
                                              )
                                              ),
                                          maxLines: 1,
                               
                                          ),
                             ),
                                    ),
                                
  
                            Padding(
                                padding: EdgeInsets.all(10.0), 
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                    ElevatedButton.icon(
                                        label: Text("Zaloguj", style: TextStyle(color: AppTheme.white)),
                                        icon: Icon(Icons.login),
                                        iconAlignment: IconAlignment.end,
                                        style: ElevatedButton.styleFrom(
                                            iconColor: AppTheme.white,
                                            textStyle: TextStyle(color: AppTheme.white),
                                            backgroundColor: AppTheme.accent,
                                        ),
                                        onPressed: () {
                                            handleLogin();
                                                                                    }
                                        ),
                                    ],
                               )
                                ),
                            ],
                            );
    }


    @override
        Widget build(BuildContext context) {
            return Scaffold(
                    backgroundColor: AppTheme.dark,
                    body: Row(
                        children: [
                            Expanded(child: Column()),
                            Column(
                             children: [
                             Expanded(child: Row()),
                             Row(
                                children: [
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: 100,
                                        maxWidth: 500,
                                        minHeight: 100,
                                        maxHeight: 500,
                                    ),
                                    child: _loginForm()
                                ),
                                ],
                             ),
                             Expanded(child: Row()),
                             ],
                            ),
                            Expanded(child: Column()),
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
   }
