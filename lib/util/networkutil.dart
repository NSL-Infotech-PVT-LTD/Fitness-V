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

  Future<http.Response> post(context, String url,
      {Map<String, String> headers, body, encoding}) {
    print(Constants.baseUrl + url);

    return http
        .post(Constants.baseUrl + url,
            body: utf8.encode(json.encode(body)),
            headers: {"Content-Type": "application/json","Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjQwZDVhZWZlNmYwN2RjZTU1NTM4NDRhODgwZDcyNzkzYTAyZWRmMzBiMjA3NWVmMTY1NmFjZTAyYmE4MjIxMTUwYjEwZjBkYTNlM2JiNjhmIn0.eyJhdWQiOiIxIiwianRpIjoiNDBkNWFlZmU2ZjA3ZGNlNTU1Mzg0NGE4ODBkNzI3OTNhMDJlZGYzMGIyMDc1ZWYxNjU2YWNlMDJiYTgyMjExNTBiMTBmMGRhM2UzYmI2OGYiLCJpYXQiOjE1OTU0MzA0MDUsIm5iZiI6MTU5NTQzMDQwNSwiZXhwIjoxNjI2OTY2NDA1LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.nezk0C85q5WpC_o05jDb6lemejbD0L2q4rTKXY7o5ZXC74IWMb5KZIkUosfc4JtWnbtbpCLGnrtruSNhu8hw3ZyNCT4C954aKF-k3ZHbhvR6ERVolymvceSBq2XkwrnVaW_E_60ZF3xU-ySExKBV7wETKEJIYBbEmY_d04IByv_W486g3OztW76N5sXCOCTZLIlk2zcvJtmCRo32KykcpnzF0Md-CSJSJHdM19JLN9VQVsO7McG0jvgP4QkeESGEONBpo37DRCbgSRtW1sPzwq3r3m1i32Ap1m_VoG5OBeJYScQqmUWPYsmlqBIA1MAJO4AsYQv_z6r2fcKsaVi15o-wrP35B7zYgXYE9cmXfhngvj-8KNv_DEhPx4ZTSsgmQNPBAu8lKC9bhw9C54Isky6vIBxwDLoOJ80iv2Ogd0A09MrJndRmKyTqSAhJbLXTBoHzURj4yWhOdfY2bK9GSsZ6gTlvvyFx4hUi4r7GL-re_yE-_G7FPAD-QooSu_cf6BEBHufCC0Qbjj85Ci798sxh3XTPeqPrNpsMChAP72PvhwGWaMADhjccaT5i4k1lpudcfeYFT73B9oRZUWoTA2UFAZ1zd0tHRpfE775X_aQyfxZ8P_BSPO2v8yTSOwnGTn5mXzhZ8VRo27b83d3Stcaqd4EShWLdL5udttZe6ZE"},


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
