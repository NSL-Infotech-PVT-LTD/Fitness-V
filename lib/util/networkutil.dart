import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Future<http.Response> get(String url) {
    return http.get(Constants.baseUrl + url).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      return response;
    });
  }

  Future<http.Response> post(context, String url,String auth,
      {Map<String, String> headers, body, encoding}) {

    print(Constants.baseUrl+" ndfjhb" + auth);

    return http
        .post(Constants.baseUrl + url,
            body: utf8.encode(json.encode(body)),
            headers: {
              "Content-Type": "application/json",
              "Authorization": auth
            },
            encoding: encoding)
        .then((http.Response response) {
      if (response == null) {
        print("ull data");
        throw new Exception("Error while fetching data");
      }
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 400) {
//        var res = response.body as JsonDecoder;
//             showDialogBox(context, 'Error',res.error.toString());
//        print(res.toString());
        throw new Exception(response);
      }

      return response;
    }).catchError((error) {
      throw new Exception("Error" + error.toString());
    });
  }
}
