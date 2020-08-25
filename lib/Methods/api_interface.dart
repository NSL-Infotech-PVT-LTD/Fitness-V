//Api's references

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:volt/ResponseModel/StatusResponse.dart';

String LOGIN = BASE_URL + "api/login";
String ROLE = BASE_URL + "api/roles";
String REGISTRATION = BASE_URL + "api/register";
String GETPROFILE = BASE_URL + "api/get-profile";
String RESET_PASSWORD = BASE_URL + "api/reset-password";
String getTrainersList = BASE_URL + "api/trainers";
String trainers = BASE_URL + "api/trainer";
String profile = BASE_URL + "api/get-profile";
String trainerReviews = BASE_URL + "api/trainer/reviews";
String eventDetails = BASE_URL + "api/event";
String privacyUrl = BASE_URL + "api/event";
String aboutUsUrl = BASE_URL + "api/config/about_us";
String termsConditionUrl = BASE_URL + "api/config/terms_and_conditions";
String updateProfileUrl = BASE_URL + "api/update";
String bookingUrl = BASE_URL + "api/bookings/store";
String allBookinsUrl = BASE_URL + "api/bookings";

String CUSTOMER_ID = "";

//API's keys

String DEVICE_TYPE = "device_type";
String DEVICE_TOKEN = "device_token";

String ID = "id";
String trainer_id = "trainer_id";
String ANDROID = "android";
String DEVICE_TOKEN_VALUE = "value";
String Authorization = "Authorization";
String Content_Type = "Content-Type";
String CUSTOMER_NAME = "customer_name";
String Product_ID = "product_id";
String trainerId = "trainer_id";

String SEARCH = "search";
String LIMIT = "limit";
String PAGE = "page";

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
String MOBILE = "mobile";
String EMAIL = "email";
String PASSWORD = "password";
String EMIRATES_ID = "emirates_id";
String eventKey = "events";
String classSchedules = "class_schedules";
String trainerUsers = "trainer_users";

//user data
String USER_AUTH = "USER_AUTH";
String USER_NAME = "USER_NAME";
String userImage = "userImage";
String USER_EMAIL = "USER_EMAIL";
String CONTENT_VALUE = "application/x-www-form-urlencoded";
String ORDER_BY = "price_high";

String BASE_URL = "https://dev.netscapelabs.com/volt/public/";
String DEALER_PROFILE_IMAGE = "uploads/dealer/profile_image/";
String IMAGE_URL = "uploads/roles/";
String imageUrlEvent = "uploads/events/";
String MORE_IMAGE_URL = "uploads/product/images/";
String BARCODE_URL = "uploads/product/barcode/";
String trainerUser = "uploads/trainer-user/";
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

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getProfileDetailApi(String auth) async {
  final response = await http.post(
    profile,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    },
  );
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

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
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> getTermsApi() async {
  final response = await http.get(termsConditionUrl);
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> getPrivacyApi() async {
  final response = await http.get(privacyUrl);
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> getAboutApi() async {
  final response = await http.get(aboutUsUrl);
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

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getEventDetailsApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(eventDetails,
      headers: header(userAuth), body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  return StatusResponse.fromJson(map);
}

Future<StatusResponse> bookingApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(bookingUrl,
      headers: header(userAuth), body: jsonEncode(parms));

  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getTrainerReviewsApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(trainerReviews,
      headers: header(userAuth), body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> allBookingsApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(allBookinsUrl,
      headers: header(userAuth), body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  return StatusResponse.fromJson(map);
}

Future<StatusResponse> updateUserProfileApi(
    String userAuth, File file, Map<String, String> parms) async {
  final postUri = Uri.parse(updateProfileUrl);
  http.MultipartRequest request = http.MultipartRequest('POST', postUri);

  request.headers['Authorization'] = userAuth;
  request.fields.addAll(parms);
  if (file != null) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'image', file.path); //returns a Future<MultipartFile>

    request.files.add(multipartFile);
  }
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  return StatusResponse.fromJson(map);
}

header(String auth) => {
      Content_Type: 'application/json; charset=UTF-8',
      Authorization: auth,
    };
