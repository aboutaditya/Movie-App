import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

 class APIController {
  static Future getMovie() async {
    try {
      final req = await http
          .get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
      if (req.statusCode == 200) {
        final body = req.body;
        final res = json.decode(body);
        print(res);
        return res;
      }
    } catch (e) {
      log("getYtexception: $e");
    }
  }
  static Future getInfo(String link) async {
    try {
      final req = await http
          .get(Uri.parse(link));
      if (req.statusCode == 200) {
        final body = req.body;
        final res = json.decode(body);
        print(res);
        return res;
      }
    } catch (e) {
      log("getYtexception: $e");
    }
  }
  }