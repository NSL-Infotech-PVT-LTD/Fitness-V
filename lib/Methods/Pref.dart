
import 'dart:convert';

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

readUserData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return json.decode(prefs.getString(key));
}

saveUser(String key, value) async {
  //print("fjsnhk ${value.toString()}");
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, json.encode(value));
}

/////Method of Fetch//////

// readUser(userData).then((value) => user = value).whenComplete(() {
// setState(() {
// //print("userModel  $user");
// _name.text = user["name"];
// brief.text = user['description'];
// _avatar = user["avatar"];
// });
// });
