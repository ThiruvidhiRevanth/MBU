import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mbu/browser/browerclass.dart';


class browserapi {
  static Future<List<Useres>> fetechuser() async {
    const url = "https://thiruvidhirevanth.github.io/mbujson/browser.json";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['browser'] as List<dynamic>;
    final user = result.map((e) {
      return Useres(
        browsertext: e['browsertext'],
        browsertitle: e['browsertitle'],
        browserurl: e['browserurl'],
        browserpic: e['browserpic'],
      );
    }).toList();
    return user;
  }
}
