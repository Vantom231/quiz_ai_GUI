import 'package:flutter/material.dart';
import 'dart:io';
import 'package:quizai/screens/history_list.dart';
import 'package:quizai/screens/quiz_generation_screen.dart';
import 'package:quizai/screens/quiz_list_screen.dart';
import 'package:quizai/screens/welcome_screen.dart';
import 'package:quizai/utils/app_styles.dart';


class HomeScreen extends StatefulWidget {
    const HomeScreen ({super.key, required this.title});

    final String title;

    @override
        State<HomeScreen> createState() => _HomeScreenState();
}


enum Anwsers {A, B, C, D, N}
class _HomeScreenState extends State<HomeScreen> {


    int _selectedIndex = 0;

    Widget historyList = Text("if you seeing this, means that must be an error :("); 

    // Quiz Screen
    int _selectedQuestion = 1;
    Anwsers? _anwser = Anwsers.N;

    void _onItemTapped(int index) {
        setState(() {
                _selectedIndex = index;
                });
    }

    void _buildHistoryList(context) async {
        Widget temp = await HistoryList().build(() {}, context);
        setState(() {
                historyList = temp;
                });
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
                label:  Text(text, style: const TextStyle(color: AppTheme.white)),
                icon: Icon(icon, color: AppTheme.white),
                iconAlignment: iconAlignment,
                onPressed: pressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    )
                );
    }

    Widget radioListButton(BuildContext context, String text, Anwsers val) {
        return Material(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppTheme.primary,
                            width: 3,
                            )
                        ),
                    child: RadioListTile<Anwsers>(
                        tileColor: AppTheme.secondary,
                        selectedTileColor: AppTheme.accent,
                        activeColor: AppTheme.accent,
                        title: Text(text, style: const TextStyle(color: AppTheme.white)),
                        value: val,
                        groupValue: _anwser,
                        onChanged: (Anwsers? value) {
                        setState(() {
                                _anwser = value;
                                });
                        },
                        ),
                    ),
                    );
    }

    List<Widget> buildList(BuildContext context) {
        return <Widget>[
                  ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 900,
                              maxWidth: 1000,
                              minHeight: 500,
                              maxHeight: 600,
                              ),
                          child: DashboardScreen(),
                          ),// history view
                  // Quiz Generation view
                  ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 900,
                              maxWidth: 1000,
                              minHeight: 500,
                              maxHeight: 600,
                              ),
                          child: QuizList(),
                          ),// history view
                  ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 900,
                              maxWidth: 1000,
                              minHeight: 500,
                              maxHeight: 600,
                              ),
                          child: historyList,
                          ),
                      ];
    }

@override
Widget build(BuildContext context) {
    List<Widget> widgetOptions = buildList(context);     

    return Scaffold(
            backgroundColor: AppTheme.bg,
            appBar: AppBar(
                backgroundColor: AppTheme.bg,
                title: Text(widget.title, 
                    style: const TextStyle(
                        color: AppTheme.white,
                        )
                    ),
                leading: Builder(
                    builder: (context) {
                    return IconButton(
                            icon: const Icon(Icons.menu, color: AppTheme.accent),
                            onPressed: () {
                            Scaffold.of(context).openDrawer();
                            },
                            );
                    },
                    ),
                ),
            body: Center(
                child: widgetOptions[_selectedIndex],
                ),
            drawer: Drawer(
                    backgroundColor: AppTheme.primary,
                    // Add a ListView to the drawer. This ensures the user can scroll
                    // through the options in the drawer if there isn't enough vertical
                    // space to fit everything.
                    child: ListView(
                        // Important: Remove any padding from the ListView.
                        padding: EdgeInsets.zero,
                        children: [
                        const DrawerHeader(
                            decoration: BoxDecoration(
                                color: AppTheme.secondary,
                                ),
                            child: Text('Menu',
                                style: TextStyle(
                                    color: AppTheme.white,
                                    )
                                ),
                            ),
                        ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text('DashBoard'),
                            textColor: AppTheme.white,
                            iconColor: AppTheme.white,
                            hoverColor: AppTheme.secondary,
                            selectedColor: AppTheme.accent,
                            selected: _selectedIndex == 0,
                            onTap: () {
                            // Update the state of the app
                            _onItemTapped(0);
                            // Then close the drawer
                            Navigator.pop(context);
                            },
                            ),
                        ListTile(
                                leading: const Icon(Icons.quiz),
                                title: const Text('Quizy'),
                                textColor: AppTheme.white,
                                iconColor: AppTheme.white,
                                hoverColor: AppTheme.secondary,
                                selectedColor: AppTheme.accent,
                                selected: _selectedIndex == 1,
                                onTap: () {
                                // Update the state of the app
                                _onItemTapped(1);
                                // Then close the drawer
                                Navigator.pop(context);
                                },
                                ),
                        ListTile(
                                leading: const Icon(Icons.history),
                                title: const Text('Historia'),
                                textColor: AppTheme.white,
                                iconColor: AppTheme.white,
                                hoverColor: AppTheme.secondary,
                                selectedColor: AppTheme.accent,
                                selected: _selectedIndex == 2,
                                onTap: () {
                                _buildHistoryList(context);
                                _onItemTapped(2);
                                Navigator.pop(context);
                                }
                                ),
                        const Divider(),
                        ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Wyloguj'),
                                textColor: AppTheme.white,
                                iconColor: AppTheme.white,
                                hoverColor: AppTheme.secondary,
                                selectedColor: AppTheme.accent,
                                selected: _selectedIndex == 4,
                                onTap: () {
                                // Then close the drawer
                                Navigator.pop(context);
                                Navigator.pop(context);
                                },
                                ),
                        ListTile(
                                leading: const Icon(Icons.exit_to_app),
                                title: const Text('Wyjdź'),
                                textColor: AppTheme.white,
                                iconColor: AppTheme.white,
                                hoverColor: AppTheme.secondary,
                                selectedColor: AppTheme.accent,
                                selected: _selectedIndex == 5,
                                onTap: () {
                                    exit(0);
                                },
                                ),


                        ],
                        ),
                        ),
                        );
}
}
