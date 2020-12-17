
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getString(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String value = prefs.getString(key);
  return value;
}

setString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

clearedShared() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
