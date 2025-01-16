import 'package:flutter/material.dart';
import 'package:quizai/screens/quiz_generation_screen.dart';
import 'package:quizai/screens/quiz_screen.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/session.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<QuizItem> quizItems = [];
  bool _isListCreated = false;

  final List<String> _degrees = ["szkoła podstawowa", "liceum", "studia inżynierskie/licencjackie", "studia magisterskie"];
  final List<String> _difficulties = ["bardzo łatwe", "łatwe", "średnie", "trudne", "bardzo trudne"];

  QuizItem? selectedQuizItem;

  void _deleteQuizItem(QuizItem item) async {
      int id = item.id;
      await Session.del('api/subject/$id');
      setState(() {
                _isListCreated = false;
              });
  }
  
  // builds quiz list from API
  void buildQuizList(Function fnc) async {
       List<dynamic> quizList = await Session.getMultiple("api/subject"); 
       List<QuizItem> items = [];

       for (var quiz in quizList) {
               items.add(QuizItem(
                    id: quiz["id"], 
                    level: quiz["level"], 
                    finishedQuizzes: quiz["number_finished"], 
                    subject: quiz["name"],
                    numberofQuestions: quiz["number_of_questions"],
                    levelClass: quiz['level_class'] ?? null,
                    difficulty: quiz["difficulty"],
                    question: quiz['question'] ?? 'brak',
                    ));
              }

       fnc(items);
  }


  void _generateNewQuiz() {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuizGenerationScreen(refresh: () {
            setState(() {
                          _isListCreated = false;
                        });
            }))
      );
  }

  void _confirmSelection() {
    if (selectedQuizItem != null) {
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen(id: selectedQuizItem!.id, refresh: () {
                      setState(() {
                              _isListCreated = false;
                              });
                      }))
              );
    }
  }

  @override
  Widget build(BuildContext context) {

    if (!_isListCreated) {
        buildQuizList((quizList) {
            setState(() {
                    quizItems = quizList;
                    _isListCreated = true;
                });
        });
    }

    return Scaffold(
      backgroundColor: AppTheme.primary, // Set background color to make white text more visible
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                dividerThickness: 0.5,
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Przedmiot",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Temat",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Poziom krztałcenia",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Klasa/Rok",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Id",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Ilość pytań",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Trudność",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Ilość wykonanych",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Usuń",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                rows: quizItems.map((quizItem) {
                  return DataRow(
                    selected: selectedQuizItem == quizItem,
                    onSelectChanged: (isSelected) {
                      setState(() {
                        selectedQuizItem = isSelected! ? quizItem : null;
                      });
                    },
                    cells: <DataCell>[
                      DataCell(
                        SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(quizItem.subject, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                              Text(quizItem.question ?? "brak", style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        )
                      ),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_degrees[quizItem.level], style: TextStyle(color: Colors.white)),
                            Text(quizItem.levelClass?.toString() ?? "brak", style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ),
                      DataCell(
                        Column(
                          children: [
                            Text(quizItem.id.toString(), style: TextStyle(color: Colors.white)),
                            Text(quizItem.numberofQuestions.toString(), style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_difficulties[quizItem.difficulty], style: TextStyle(color: Colors.white)),
                            Text(quizItem.finishedQuizzes.toString(), style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => _deleteQuizItem(quizItem),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _generateNewQuiz,
                  child: Text("Stwórz nowy"),
                ),
                ElevatedButton(
                  onPressed: selectedQuizItem != null ? _confirmSelection : null,
                  child: Text("Generuj Quiz"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      selectedQuizItem != null ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizItem {
  final int id;
  final String subject;
  final int finishedQuizzes;
  final int level;
  final String? question;
  final int difficulty;
  final int? levelClass;
  final int numberofQuestions;

  QuizItem({
    required this.id,
    required this.subject,
    required this.finishedQuizzes,
    required this.level,
    required this.question,
    required this.difficulty,
    required this.levelClass,
    required this.numberofQuestions,
  });
}

