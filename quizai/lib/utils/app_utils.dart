import 'dart:convert';

class AppUtils {
    static String toUtf16(String str) {
        var runes = str.runes.toList();
        return utf8.decode(runes);
    }
}
