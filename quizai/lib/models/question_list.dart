import 'package:quizai/models/question.dart';

class QeustionList {
    List<Question> questions = <Question>[]; 

    void build(res) {
        for (int i = 0; i < res.length; i++) {
            Question qw = Question();
            //qw.build(res[i]);
            questions.add(qw);
        }
    }

    String toString() {
        return "Question List: \n $questions"; 
    }
}
