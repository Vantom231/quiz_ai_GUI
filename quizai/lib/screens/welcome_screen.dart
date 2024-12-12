import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/session.dart';


class Dashboard{

    bool isFetched = false;

  List<String> topics = [
    "Język Polski",
    "Język Angielski",
    "Informatyka",
    "Matematyka",
  ];

  String firstName = "Jan";
  String lastName = "Kowalski";
  String nickname = "Janek123";

  int completedQuizzes = 0;
  int activeSubjects = 1;
  int createdSubjects = 2;
  int quizesGenerated = 3;

      

  Future<Widget> build(BuildContext context) async {

      Future<Map<dynamic, dynamic>> dashboardPromise = Session.get('api/user/dashboard');
      Future<List<dynamic>> subjectListPromise = Session.getMultiple('api/subject');

      Map<dynamic, dynamic> dashboard = await  dashboardPromise;

      firstName = dashboard["name"];
      lastName = dashboard["email"];
      nickname = "janek123";

      completedQuizzes = dashboard["finished_quizes"];
      activeSubjects = dashboard['subject_active'];
      createdSubjects = dashboard['subject_created'];
      quizesGenerated = dashboard['quizes_generated'];
      
      List<dynamic> subjectList = await subjectListPromise;
      
      List<String> tempList = [];

      for (var subj in subjectList) {
              tempList.add(subj["name"]); 
            }

      topics = tempList;

    return Scaffold(
      body: Row(
        children: [
          // Lewa kolumna: Aktywne tematy
          Expanded(
            flex: 1,
            child: Container(
              color: AppTheme.primary,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aktywne tematy",
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            topics[index],
                            style: TextStyle(color: AppTheme.white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Prawa kolumna: Statystyki użytkownika
          Expanded(
            flex: 2,
            child: Container(
              color: AppTheme.bg,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kafelek: Ukończone quizy
                  Expanded(
                    child: StatTile(
                      title: "Ukończone quizy",
                      value: completedQuizzes.toString(),
                      backgroundColor: AppTheme.secondary,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Kafelek: Streak
                  Expanded(
                    child: StatTile(
                      title: "Ilość tematów aktywnych",
                      value: activeSubjects.toString(),
                      backgroundColor: AppTheme.accent,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Expanded(
                    child: StatTile(
                      title: "Ilość tematów stworzonych",
                      value: createdSubjects.toString(),
                      backgroundColor: AppTheme.secondary,
                    ),
                  ),
                  SizedBox(height: 16),

                  Expanded(
                    child: StatTile(
                      title: "Ilość quizów wygenerowanych",
                      value: quizesGenerated.toString(),
                      backgroundColor: AppTheme.accent,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Kafelek: Informacje o użytkowniku
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Imię: $firstName",
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Nazwisko: $lastName",
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Nick: $nickname",
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;

  const StatTile({
    required this.title,
    required this.value,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 18,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
