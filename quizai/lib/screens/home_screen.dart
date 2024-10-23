import 'package:flutter/material.dart';
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
    int _selectedQuestion = 1;
    Anwsers? _anwser = Anwsers.N;

    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppTheme.white);


    void _onItemTapped(int index) {
        setState(() {
                _selectedIndex = index;
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
            const Text(
                    'Index 0: Home',
                    style: optionStyle,
                    ),
                  Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 200, right: 200),
                          child: Container(
                              color: AppTheme.primary,
                              child: Padding(
                              padding: EdgeInsets.all(20),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        questionIndicatorButton(1),
                                        questionIndicatorButton(2),
                                        questionIndicatorButton(3),
                                        questionIndicatorButton(4),
                                        questionIndicatorButton(5),
                                        questionIndicatorButton(6),
                                        questionIndicatorButton(7),
                                        questionIndicatorButton(8),
                                        ]
                                       ),
                                    Expanded(
                                      child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("this\n is\n some\n text\n", style: TextStyle(color: AppTheme.white, fontSize: 20))
                                          ]
                                          ),
                                    ),
                                    Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            SizedBox(
                                                height: 260,
                                                width: 500,
                                                child: Column(
                                                    children: <Widget>[
                                                    radioListButton(context, "ODP. A", Anwsers.A),
                                                    radioListButton(context, "ODP. B", Anwsers.B),
                                                    radioListButton(context, "ODP. C", Anwsers.C),
                                                    radioListButton(context, "ODP. D", Anwsers.D),
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
                                                , _selectedQuestion <= 1? null : () {
                                                  setState((){_selectedQuestion--;});
                                                   })
                                                ]
                                                ),
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                bottomButton("Następne", Icons.arrow_right_outlined, IconAlignment.end, 
                                                _selectedQuestion >= 8? null : () {
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
                                     const Text(
                                             'Index 2: School',
                                             style: optionStyle,
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
