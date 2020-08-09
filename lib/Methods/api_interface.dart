//Api's references

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:volt/ResponseModel/StatusResponse.dart';

String LOGIN = BASE_URL + "api/login";
String ROLE = BASE_URL + "api/roles";
String REGISTRATION = BASE_URL + "api/register";
String GETPROFILE = BASE_URL + "api/get-profile";
String RESET_PASSWORD = BASE_URL + "api/reset-password";
String getTrainersList = BASE_URL + "api/trainers";
String trainers = BASE_URL + "api/trainer";

String CUSTOMER_ID = "";

//API's keys

String DEVICE_TYPE = "device_type";
String DEVICE_TOKEN = "device_token";

String ID = "id";
String ANDROID = "android";
String DEVICE_TOKEN_VALUE = "value";
String Authorization = "Authorization";
String Content_Type = "Content-Type";
String CUSTOMER_NAME = "customer_name";
String Product_ID = "product_id";

String SEARCH = "search";
String LIMIT = "limit";

//signup keys
String NAME = "name";
String FIRSTNAME = "first_name";
String LASTNAME = "last_name";
String MIDDLENAME = "middle_name";
String BIRTH_DATE = "birth_date";
String DESIGNATION = "designation";
String ADDRESS = "address";
String ROLE_ID = "role_id";
String ROLE_PLAN_ID = "role_plan_id";
String EMEREGENCY_NUMBER = "emergency_contact_no";
String CHILD = "child";
String EMAIL = "email";
String MOBILE = "mobile";
String PASSWORD = "password";
String EMIRATES_ID = "emirates_id";

//user data
String USER_AUTH = "USER_AUTH";
String USER_NAME = "USER_NAME";
String USER_EMAIL = "USER_EMAIL";
String CONTENT_VALUE = "application/x-www-form-urlencoded";
String ORDER_BY = "price_high";

String BASE_URL = "https://dev.netscapelabs.com/volt/public/";
String DEALER_PROFILE_IMAGE = "uploads/dealer/profile_image/";
String IMAGE_URL = "uploads/roles/";
String MORE_IMAGE_URL = "uploads/product/images/";
String BARCODE_URL = "uploads/product/barcode/";
//flutter build apk --release --target-platform=android-arm64
Future<StatusResponse> getLogin(Map<String, String> parms) async {
  final response = await http.post(LOGIN,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getTrainersListApi(
    String auth, Map<String, String> parms) async {
  final response = await http.post(getTrainersList,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
      body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  print("ResponseTrainersList--->" + map.toString());

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getTrainersDetailApi(
    String auth, Map<String, String> parms) async {
  final response = await http.post(trainers,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
      body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  print("ResponseTrainersList--->" + map.toString());

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getRoles() async {
  final response = await http.post(
    ROLE,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> signUpToServer(Map<String, String> parms) async {
  final response = await http.post(REGISTRATION,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(parms));
  print("signUpResponse---->" + response.body.toString());
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> resetPassword(Map<String, String> parms) async {
  final response = await http.post(RESET_PASSWORD,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  print("resetPassword==>" + map.toString());

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getProfile(String userAuth) async {
  final response = await http.post(
    GETPROFILE,
    headers: header(userAuth),
  );

  return StatusResponse.fromJson(json.decode(response.body));
}

header(String auth) => {
      Content_Type: 'application/json; charset=UTF-8',
      Authorization: auth,
    };
