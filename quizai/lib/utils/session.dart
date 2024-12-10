import 'dart:convert';

import 'package:http/http.dart' as http;

class Session {
    static Map <String, String> headers = {'Content-Type': 'application/json; charset=utf-8'};
    
    static void updateCookie(http.Response response) {
        String? rawCookie = response.headers['set-cookie'];
        if (rawCookie != null) {
          int index = rawCookie.indexOf(';');
          headers['cookie'] =
              (index == -1) ? rawCookie : rawCookie.substring(0, index);
        }
      }

    static Future<Map> get(String path) async {
        Uri uri = Uri(scheme: "http", host:"127.0.0.1", path:path, port:8000);
        http.Response response = await http.get(uri, headers: headers);
        updateCookie(response);
        return json.decode(utf8.decode(response.bodyBytes));
    }

    
    static Future<List<dynamic>> getMultiple(String path) async {
        Uri uri = Uri(scheme: "http", host:"127.0.0.1", path:path, port:8000);
        http.Response response = await http.get(uri, headers: headers);
        updateCookie(response);
        print(utf8.encode(utf8.decode(response.bodyBytes)));
        return json.decode(utf8.decode(response.bodyBytes));
    }

    static Future<http.Response> post(String path, String body) async {
        Uri uri = Uri(scheme: "http", host:"127.0.0.1", path:path, port:8000);
        http.Response response = await http.post(uri, body: body, headers: headers);
        updateCookie(response);
        print("URI: $uri");
        print("Headers: $headers");
        return response;
      }
      
          static Future<Map<dynamic, dynamic>> post2obj(String path, dynamic body) async {
        Uri uri = Uri(scheme: "http", host:"127.0.0.1", path:path, port:8000);
        http.Response response = await http.post(uri, body: jsonEncode(body), headers: headers);
        updateCookie(response);
        print("URI: $uri");
        print("Headers: $headers");
        return json.decode(response.body);
      }


    static Future<dynamic> del(String path) async{
        Uri uri = Uri(scheme: "http", host:"127.0.0.1", path:path, port:8000);
        http.Response response = await http.delete(uri, headers: headers);
        return response;
    }
}
