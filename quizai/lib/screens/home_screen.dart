import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
        Widget build(BuildContext context) {
            return Scaffold(
                    backgroundColor: AppTheme.dark,
                    body: Column(
                        children: [
                        Row(
                            children: [Text("homeScreen"),]

                        ),
                        Row(
                            children: [
                                _mainButton(() {
                                        Navigator.pop(context);
                                    }, "go back"),
                            ]
                        ),
                        ],
                        ),
                    );
        }

    ElevatedButton _mainButton(Function()? onPressed,String data) {
        return ElevatedButton(
                onPressed: onPressed,
                child: Text(data)
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
