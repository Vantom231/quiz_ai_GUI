import 'dart:convert';

enum Anwsers {A, B, C, D, N}
class Question {
    String question = "";
    String anwserA = "";
    String anwserB = "";
    String anwserC = "";
    String anwserD = "";
    Anwsers? correctAnwser;
    Anwsers? selectedAnwser;


    //changes Utf8 from api to Utf16 for flutter
    String _toUtf16(String str) {
        var runes = str.runes.toList();
        return utf8.decode(runes);
    }

    //changes strings from api for Anwsers enum
    Anwsers _findAnwser(string) {
        switch (string) {
                  case "a":
                     return Anwsers.A;
                  case "b":
                     return Anwsers.B;
                  case "c":
                     return Anwsers.C;
                  case "d":
                     return Anwsers.D;
                  default:
                     throw Exception("anwser not found!!");
                }
    }

    //changes Anwsers enum for strings for api
    String _anwserToString(Anwsers? anw) {
        switch (anw) {
                  case Anwsers.A:
                     return "a";
                  case Anwsers.B:
                     return "b";
                  case Anwsers.C:
                     return "c";
                  case Anwsers.D:
                     return "d";
                  default:
                     return "n";
                }
    }

    // loads data by strings for new questions
    Question loadNew(question, anwserA, anwserB, anwserC, anwserD, correctAnwser) {
        this.question = question;
        this.anwserA = anwserA;
        this.anwserB = anwserB;
        this.anwserC = anwserA;
        this.anwserD = anwserD;
        this.correctAnwser = _findAnwser(correctAnwser);
        this.selectedAnwser = Anwsers.N;

        return this;
    }

    //loads data from /api/subject/{id}/generate API response
    Question loadNewGenerated(res) {
        this.question = res['q'];
        this.anwserA = res['a'];
        this.anwserB = res['b'];
        this.anwserC = res['c'];
        this.anwserD = res['d'];
        this.correctAnwser = _findAnwser(res['anw']);
        this.selectedAnwser = Anwsers.N;

        return this;
    }

    
    //loads data from /api/history/quiz/{id}/questions API response
    Question loadHistory(res) {
        this.question = res['question'];
        this.anwserA = res['anw_a'];
        this.anwserB = res['anw_b'];
        this.anwserC = res['anw_c'];
        this.anwserD = res['anw_d'];
        this.correctAnwser = _findAnwser(res['anw_correct']);
        this.selectedAnwser = _findAnwser(res['anw']);

        return this;
    }

    // form a json string suitable for API
    String prepare() {
        String str = "{";
        str += '"question":"' + this.question + '",';
        str += '"anw_a":"' + this.anwserA + '",';
        str += '"anw_b":"' + this.anwserB + '",';
        str += '"anw_c":"' + this.anwserC + '",';
        str += '"anw_d":"' + this.anwserD + '",';
        str += '"anw":"' + _anwserToString(selectedAnwser) + '",';
        str += '"anw_correct":"' + _anwserToString(correctAnwser) + '"';
        str += '}';

        return str;
    }

}
