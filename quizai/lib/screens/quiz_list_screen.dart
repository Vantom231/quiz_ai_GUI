import 'package:flutter/material.dart';
import 'package:quizai/screens/quiz_generation_screen.dart';
import 'package:quizai/screens/quiz_screen.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/app_utils.dart';
import 'package:quizai/utils/session.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<QuizItem> quizItems = [];
  bool _isListCreated = false;

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
                    level:quiz["difficulty"].toString() + "/4", 
                    finishedQuizzes: quiz["id"], 
                    subject: AppUtils.toUtf16(quiz["name"]),
                    numberofQuestions: quiz["number_of_questions"],
                    levelClass: quiz['level_class'] ?? null,
                    difficulty: quiz["difficulty"],
                    question: quiz['question'] ?? null,
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
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      "Temat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Id",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Poziom",
                      style: TextStyle(color: Colors.white),
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
                      DataCell(Text(quizItem.subject, style: TextStyle(color: Colors.white))),
                      DataCell(Text(quizItem.finishedQuizzes.toString(), style: TextStyle(color: Colors.white))),
                      DataCell(Text(quizItem.level, style: TextStyle(color: Colors.white))),
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
  final String level;
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

