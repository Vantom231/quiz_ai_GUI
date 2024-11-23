import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/session.dart';

class QuizGenerationScreen extends StatefulWidget {
    const QuizGenerationScreen({super.key, required this.refresh});

    final Function refresh;

    @override
    State<QuizGenerationScreen> createState() => _QuizGenerationScreenState();
}

class _QuizGenerationScreenState extends State<QuizGenerationScreen> {

    final List<String> _subjects = ["biologia", "fizyka", "informatyka", "język angielski"];
    final List<String> _degrees = ["szkoła podstawowa", "liceum", "studia inżynierskie/licencjackie", "studia magisterskie"];
    final List<String> _difficulties = ["bardzo łatwe", "łatwe", "średnie", "trudne", "bardzo trudne"];
    final Map<String, dynamic> _degreesToClasses = {
        "szkoła podstawowa": 8,
        "liceum": 5,
        "studia inżynierskie/licencjackie": 4,
        "studia magisterskie": 2,
    };
    
    String? _selectedSubject;
    String? _selectedQuestion;
    String? _selectedDegree;
    String? _selectedDifficulty;
    int? _selectedClass;
    int _numberOfQuestions = 10;

    final TextEditingController _customSubjectController = TextEditingController();

    void _showCustomSubjectDialog() {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                backgroundColor: AppTheme.bg,
                title: Text("Enter Custom Subject", style: TextStyle(color: AppTheme.white)),
                content: TextField(
                    controller: _customSubjectController,
                    style: TextStyle(color: AppTheme.white),
                    decoration: InputDecoration(
                        hintText: "Custom Subject",
                        hintStyle: TextStyle(color: AppTheme.white),
                    ),
                ),
                actions: [
                    TextButton(
                        child: Text("Cancel", style: TextStyle(color: AppTheme.white)),
                        onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                        child: Text("Add", style: TextStyle(color: AppTheme.white)),
                        onPressed: () {
                            setState(() {
                                _subjects.add(_customSubjectController.text);
                                _selectedSubject = _customSubjectController.text;
                            });
                            _customSubjectController.clear();
                            Navigator.pop(context);
                        },
                    ),
                ],
            ),
        );
    }

    int _findIndex(String? val, List<String> list) {
        for (int i = 0; i < list.length; i++) {
            if (list[i] == val) return i;
        }
        return 0;
    }

    void _saveSubject(Function refresh) async {
        int diff = _findIndex(_selectedDifficulty, _difficulties);
        int deg = _findIndex(_selectedDegree, _degrees);

        String prompt = "{";
        prompt += '"number_of_questions": $_numberOfQuestions,';
        prompt += '"name": "$_selectedSubject",';
        prompt += '"level": $deg,';
        prompt += '"difficulty": $diff,';
        if (_selectedClass != null) prompt += '"level_class": $_selectedClass,';
        if (_selectedQuestion != null) prompt += '"question": "$_selectedQuestion"';
        prompt += "}";


        await Session.post('api/subject' ,prompt);

        refresh();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppTheme.bg,
            body: Container(
                padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                color: AppTheme.primary,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    IconButton(
                        onPressed: () {
                        Navigator.pop(context);
                        },
                        icon: Icon(Icons.close_rounded, size: 30, color: AppTheme.accent),
                        ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text("Generowanie Quizu: ", style: TextStyle(color: AppTheme.accent, fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                  children: [
                                      Expanded(
                                          child: DropdownButtonFormField<String>(
                                              style: TextStyle(color: AppTheme.white),
                                              dropdownColor: AppTheme.secondary,
                                              decoration: InputDecoration(
                                                  labelText: "Przedmiot",
                                                  floatingLabelStyle: TextStyle(color: AppTheme.white),
                                                  labelStyle: TextStyle(color: AppTheme.white),
                                                  filled: true,
                                                  fillColor: AppTheme.secondary,
                                              ),
                                              value: _selectedSubject,
                                              items: _subjects.map((subject) {
                                                  return DropdownMenuItem(
                                                      value: subject,
                                                      child: Text(subject),
                                                  );
                                              }).toList(),
                                              onChanged: (value) {
                                                  setState(() {
                                                      _selectedSubject = value;
                                                  });
                                              },
                                          ),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.add, color: AppTheme.accent),
                                          onPressed: _showCustomSubjectDialog,
                                      ),
                                  ],
                              ),
                              _selectedSubject != null? TextField(
                                    style: TextStyle(color: AppTheme.white),
                                    decoration: InputDecoration(
                                        labelText: "Temat (opcjonalnie)",
                                        labelStyle: TextStyle(color: AppTheme.white),
                                        filled: true,
                                        fillColor: AppTheme.secondary,
                                    ),
                                    onChanged: (value) {
                                        setState( () {
                                                _selectedQuestion = value;
                                            });
                                    }
                                 ): Container(),

                              SizedBox(height: 16.0),
                              DropdownButtonFormField<String>(
                                  dropdownColor: AppTheme.secondary,
                                  style: TextStyle(color: AppTheme.white),
                                  decoration: InputDecoration(
                                      labelText: "Poziom wykształcenia",
                                      labelStyle: TextStyle(color: AppTheme.white),
                                      filled: true,
                                      fillColor: AppTheme.secondary,
                                  ),
                                  value: _selectedDegree,
                                  items: _degrees.map((degree) {
                                      return DropdownMenuItem(
                                          value: degree,
                                          child: Text(degree),
                                      );
                                  }).toList(),
                                  onChanged: (value) {
                                      setState(() {
                                          _selectedClass = null;
                                          _selectedDegree = value;
                                      });
                                  },
                              ),

                              _selectedDegree != null ? DropdownButtonFormField<int>(
                                  dropdownColor: AppTheme.secondary,
                                  style: TextStyle(color: AppTheme.white),
                                  decoration: InputDecoration(
                                      labelText: _degreesToClasses[_selectedDegree] < 5? "Rok (opcjonalnie)": "Klasa (opcjonalnie)",
                                      labelStyle: TextStyle(color: AppTheme.white),
                                      filled: true,
                                      fillColor: AppTheme.secondary,
                                  ),
                                  value: _selectedClass,
                                  items: List.generate(_degreesToClasses[_selectedDegree], (index) => 1 + index).map((number) {
                                      return DropdownMenuItem(
                                          value: number,
                                          child: Text(number.toString()),
                                      );
                                  }).toList(),
                                  onChanged: (value) {
                                      setState(() {
                                          _selectedClass = value;
                                      });
                                  },
                              ): Container(),

                              SizedBox(height: 16.0),
                              DropdownButtonFormField<String>(
                                  dropdownColor: AppTheme.secondary,
                                  style: TextStyle(color: AppTheme.white),
                                  decoration: InputDecoration(
                                      labelText: "Poziom pytań",
                                      labelStyle: TextStyle(color: AppTheme.white),
                                      filled: true,
                                      fillColor: AppTheme.secondary,
                                  ),
                                  value: _selectedDifficulty,
                                  items: _difficulties.map((difficulty) {
                                      return DropdownMenuItem(
                                          value: difficulty,
                                          child: Text(difficulty),
                                      );
                                  }).toList(),
                                  onChanged: (value) {
                                      setState(() {
                                          _selectedDifficulty = value;
                                      });
                                  },
                              ),
                              SizedBox(height: 16.0),
                              DropdownButtonFormField<int>(
                                  dropdownColor: AppTheme.secondary,
                                  style: TextStyle(color: AppTheme.white),
                                  decoration: InputDecoration(
                                      labelText: "Liczba Pytań",
                                      labelStyle: TextStyle(color: AppTheme.white),
                                      filled: true,
                                      fillColor: AppTheme.secondary,
                                  ),
                                  value: _numberOfQuestions,
                                  items: List.generate(6, (index) => 5 + index).map((number) {
                                      return DropdownMenuItem(
                                          value: number,
                                          child: Text(number.toString()),
                                      );
                                  }).toList(),
                                  onChanged: (value) {
                                      setState(() {
                                          _numberOfQuestions = value ?? 5;
                                      });
                                  },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        ElevatedButton(
                                            child: Text("Generuj Quiz", style: TextStyle(color: AppTheme.white)),
                                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent),
                                            onPressed: () {
                                                _saveSubject(() {
                                                    Navigator.pop(context);
                                                    widget.refresh();
                                                    });
                                            },
                                        ),
                                    ],
                                ),
                              )
                          ],
                      ),
                    ),
                  ],
                ),
            ),
        );
    }
}

