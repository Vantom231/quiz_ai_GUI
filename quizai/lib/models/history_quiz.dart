import '../utils/app_utils.dart';

class HistoryQuiz {
    int id = -1;
    int number = -1;
    String subject = "";
    int accuracy = -1;

    HistoryQuiz();

    void create(id, number, subject, accuracy) {
        this.id = id;
        this.number = number;
        this.subject = subject;
        this.accuracy = accuracy;
    }

    void createFromResponse(res) {
        id = res["id"];
        number = res["number"];
        subject = AppUtils.toUtf16(res["subject"]);
        accuracy = res["accuracy"];
    }

    String toString() {
        String res = "HistoryQuiz object: \n"
                + "    id = $id \n"
                + "    number = $number\n"
                + "    subject = $subject\n"
                + "    accuracy = $accuracy\n\n";
        return res;
    }
}
