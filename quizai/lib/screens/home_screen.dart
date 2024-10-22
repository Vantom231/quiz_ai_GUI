import 'package:flutter/material.dart';
import 'package:quizai/screens/quiz_screen.dart';
import 'package:quizai/utils/app_styles.dart';


class HomeScreen extends StatefulWidget {
    const HomeScreen ({super.key, required this.title});

    final String title;

    @override
        State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    int _selectedIndex = 0;

    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppTheme.white);

    static final List<Widget> _widgetOptions = <Widget>[
        const Text(
                'Index 0: Home',
                style: optionStyle,
            ),
        QuizScreen.quizScreen(),
        const Text(
                'Index 2: School',
                style: optionStyle,
            ),
    ];

    void _onItemTapped(int index) {
        setState(() {
                _selectedIndex = index;
                });
    }

    @override
        Widget build(BuildContext context) {
            return Scaffold(
                    backgroundColor: AppTheme.bg,
                    appBar: AppBar(
                        backgroundColor: AppTheme.bg,
                        title: Text(widget.title, 
                            style: TextStyle(
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
                        child: _widgetOptions[_selectedIndex],
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
                                    child: Text('Drawer Header',
                                        style: TextStyle(
                                            color: AppTheme.white,
                                            )
                                        ),
                                    ),
                                ListTile(
                                    leading: const Icon(Icons.home),
                                    title: const Text('Home'),
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
                                        title: const Text('Quiz'),
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
                                        title: const Text('History'),
                                        textColor: AppTheme.white,
                                        iconColor: AppTheme.white,
                                        hoverColor: AppTheme.secondary,
                                        selectedColor: AppTheme.accent,
                                        selected: _selectedIndex == 2,
                                        onTap: () {
                                        // Update the state of the app
                                        _onItemTapped(2);
                                        // Then close the drawer
                                        Navigator.pop(context);
                                        },
                                        ),
                                const Divider(),
                                ListTile(
                                        leading: const Icon(Icons.settings),
                                        title: const Text('Settings'),
                                        textColor: AppTheme.white,
                                        iconColor: AppTheme.white,
                                        hoverColor: AppTheme.secondary,
                                        selectedColor: AppTheme.accent,
                                        selected: _selectedIndex == 3,
                                        onTap: () {
                                        // Update the state of the app
                                        _onItemTapped(2);
                                        // Then close the drawer
                                        Navigator.pop(context);
                                        },
                                        ),
                                ListTile(
                                        leading: const Icon(Icons.logout),
                                        title: const Text('Logout'),
                                        textColor: AppTheme.white,
                                        iconColor: AppTheme.white,
                                        hoverColor: AppTheme.secondary,
                                        selectedColor: AppTheme.accent,
                                        selected: _selectedIndex == 4,
                                        onTap: () {
                                        // Update the state of the app
                                        _onItemTapped(2);
                                        // Then close the drawer
                                        Navigator.pop(context);
                                        },
                                        ),
                                ListTile(
                                        leading: const Icon(Icons.exit_to_app),
                                        title: const Text('Exit'),
                                        textColor: AppTheme.white,
                                        iconColor: AppTheme.white,
                                        hoverColor: AppTheme.secondary,
                                        selectedColor: AppTheme.accent,
                                        selected: _selectedIndex == 5,
                                        onTap: () {
                                        // Update the state of the app
                                        _onItemTapped(2);
                                        // Then close the drawer
                                        Navigator.pop(context);
                                        },
                                        ),


                                ],
                                ),
                                ),
                                );
        }
}
