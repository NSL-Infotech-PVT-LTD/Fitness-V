//Api's references

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:volt/ResponseModel/StatusResponse.dart';
import 'package:volt/Methods/gymModal.dart';

import 'notificationList.dart';

String LOGIN = BASE_URL + "api/login";
String ROLE = BASE_URL + "api/roles";
String REGISTRATION = BASE_URL + "api/register";
String RESET_PASSWORD = BASE_URL + "api/reset-password";
String getTrainersList = BASE_URL + "api/trainers";
String trainers = BASE_URL + "api/trainer";
//String updateP = "https://dev.netscapelabs.com/volt/public/api/update/role";
String updateP = "https://app.voltfitness.ae/api/update/role";
String trainerReviews = BASE_URL + "api/trainer/reviews";
String getTrainersListRegister = BASE_URL + "api/register/trainers";
String trainersRegister = BASE_URL + "api/register/trainer";
String trainerReviewsRegister = BASE_URL + "api/register/trainer/reviews";
String profile = BASE_URL + "api/get-profile";
String logOut = BASE_URL + "api/logout";

String eventDetails = BASE_URL + "api/event";
String privacyUrl = BASE_URL + "api/config/privacy_policy";
String aboutUsUrl = BASE_URL + "api/config/about_us";
String termsConditionUrl = BASE_URL + "api/config/terms_and_conditions";
String updateProfileUrl = BASE_URL + "api/update";
String bookingUrl = BASE_URL + "api/bookings/store";
String allBookinsUrl = BASE_URL + "api/bookings";
String bookingDelete = BASE_URL + "api/booking/delete";
String getClassesListUrl = BASE_URL + "api/class-schedules";
String getClassesbyIdUrl = BASE_URL + "api/class-schedule";
String NortificationList = BASE_URL + "api/notification/list";

String CUSTOMER_ID = "";

//API's keys

String DEVICE_TYPE = "device_type";
String DEVICE_TOKEN = "device_token";

String ID = "id";
String trainer_id = "trainer_id";
String trainer_slot = "trainer_slot";
String ANDROID = "android";
String deviceTokenValue = "deviceTokenValue";
String fireDeviceToken = "deviceTokenValue";
String DEVICE_TOKEN_VALUE = "value";
String Authorization = "Authorization";
String Content_Type = "Content-Type";
String CUSTOMER_NAME = "customer_name";
String Product_ID = "product_id";
String trainerId = "trainer_id";

String SEARCH = "search";
String Date = "date";
String LIMIT = "limit";
String PAGE = "page";
String checkInKey = "check_in";
String checkOutKey = "check_out";

//signup keys
String NAME = "name";
String FIRSTNAME = "first_name";
String trainerPriceNew = "trainerPriceNew";
String LASTNAME = "last_name";
String MIDDLENAME = "middle_name";
String BIRTH_DATE = "birth_date";
String DESIGNATION = "designation";
String workplace = "workplace";
String imageProfile = "imageProfile";
String nationality = "nationality";
String about_us = "about_us";
String marital_status = "marital_status";
String ADDRESS = "address";
String CITY = "city";
String GENDER = "gender";
String WORKPLACE = "workplace";
String ROLE_ID = "role_id";
String ROLE_PLAN_ID = "role_plan_id";
String EMEREGENCY_NUMBER = "emergency_contact_no";
String CHILD = "child";
String MOBILE = "mobile";
String EMAIL = "email";
String PASSWORD = "password";
String EMIRATES_ID = "emirates_id";
String Nationality = "nationality";
String eventKey = "events";
String classSchedules = "class_schedules";
String trainerUsers = "trainer_users";
String trainerIds = "trainer_users";
String trainerData = "trainerData";
String sessionType = "sessions";


String tName = "tName";
String tExp = "tExp";
String tTrainess = "tTrainess";
String tReview = "tReview";
String tPrice = "tPrice";
var timage = "image";
var profileImage = "image";


//user data
String USER_AUTH = "USER_AUTH";
String Image_Path = BASE_URL + "/public/uploads/trainer-user/";
String USER_NAME = "USER_NAME";
String userImage = "userImage";
String userPlanImage = "userPlanImage";
String rolePlan = "rolePlan";
String sessions = "sessions";
String mySessions = "mySessions";
String roleName = "roleName";
String roleCategory = "roleCategory";
String roleId = "roleId";
String Id = "Id";
String USER_EMAIL = "USER_EMAIL";
String roleType = 'roleType';
String CONTENT_VALUE = "application/x-www-form-urlencoded";
String ORDER_BY = "price_high";

String BASE_URL = "https://app.voltfitness.ae/";
String DEALER_PROFILE_IMAGE = "uploads/dealer/profile_image/";
String IMAGE_URL = "uploads/roles/";
String imageUrlEvent = "uploads/events/";
String MORE_IMAGE_URL = "uploads/product/images/";
String BARCODE_URL = "uploads/product/barcode/";
String trainerUser = "uploads/trainer-user/";

String imageClassUrl = "uploads/class/";
//flutter build apk --release --target-platform=android-arm64
Future<StatusResponse> getLogin(Map<String, String> parms) async {
  final response = await http.post(Uri.parse(LOGIN),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  //print(response.body)
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getTrainersListApi(
    String auth, Map<String, String> parms) async {
  final response = await http.post(
      auth != null && auth.isNotEmpty
          ? Uri.parse(getTrainersListRegister)
          : Uri.parse(getTrainersList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
      body: jsonEncode(parms));
  print("Tranier " + response.body);
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

//its base url is static please change it manually/////////////////
Future<StatusResponse> upGradePlan(String auth, Map<String, String> parms) async {
  final response = await http.post(
      Uri.parse(updateP),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
      body: jsonEncode(parms));
  print("response of update " + response.body);
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}
Future<StatusResponse> logOutFun(String auth, Map<String, String> parms) async {
  final response = await http.post(
      Uri.parse(logOut),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
      body: jsonEncode(parms));
  print("response of logout " + response.body);
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getGroupClassListApi(
    String auth, Map<String, String> parms) async {
  final response = await http.post(Uri.parse(getClassesListUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
      body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getGroupClassDetailApi(
    String auth, Map<String, String> parms) async {
  final response = await http.post(Uri.parse(getClassesbyIdUrl),
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
  final response = await http.post(
      auth != null && auth.isNotEmpty ? Uri.parse(trainersRegister) : Uri.parse(trainers),
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
    Uri.parse(profile),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    },
  );
  print(response.body.toString());
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<NotificationList> notification(String auth) async {
  final response = await http.post(
    Uri.parse(NortificationList),
    headers: <String, String>{
      'Authorization': auth
    },
  );
  final jsonData = json.decode(response.body);
  print("jsonData"+jsonData.toString());
  var map = Map<String, dynamic>.from(jsonData);
  return NotificationList.fromJson(map);
}


Future<StatusResponse> getRoles() async {
  final response = await http.post(
    Uri.parse(ROLE),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<gymMember> gRoles(param) async {
  final response = await http.post(
    Uri.parse(ROLE),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(param),
  );
  print("gymMembership${response.body}");

  return gymMember.fromJson(json.decode(response.body));
}

//getChildsRoles

Future<StatusResponse> getChildsRoles(Map<String, String> parms) async {
  final response = await http.post(Uri.parse(ROLE),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(parms));
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> signupWithouImage(Map<String, String> parms) async {
  final response = await http.post(Uri.parse(REGISTRATION),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> signUpToServer(
    {File file,File file2,File file3, Map<String, String> parms, String type}) async {
  final postUri = Uri.parse(REGISTRATION);
  http.MultipartRequest request = http.MultipartRequest('POST', postUri);
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  request.fields.addAll(parms);
  request.headers.addAll(headers);
  if (file != null) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'image', file.path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
  } if (file2 != null) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'emirate_image1', file2.path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
  } if (file3 != null) {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'emirate_image2', file3.path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
  }
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  print("ApiResponse====>${response.body}");
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  return StatusResponse.fromJson(map);
  // final postUri = Uri.parse(REGISTRATION);
  // http.MultipartRequest request = http.MultipartRequest('POST', postUri);
  // Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8',};
  // request.headers.addAll(headers);
  // request.fields.addAll(parms);
  // print("new file"+ files.toString());
  // String fileName = files.path.split("/").last;
  // var stream = new http.ByteStream(Stream.castFrom(files.openRead()));
  // http.MultipartFile multipartFile = await http.MultipartFile('image',stream, 1, filename:fileName);
  // request.files.add(multipartFile);
  // var streamedResponse = await request.send();
  // var response = await http.Response.fromStream(streamedResponse);
  // print("check Status" + response.body.toString());
  // final jsonData = json.decode(response.body);
  // var map = Map<String, dynamic>.from(jsonData);
  // return StatusResponse.fromJson(map);
}

Future<StatusResponse> getTermsApi() async {
  final response = await http.get(Uri.parse(termsConditionUrl));
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> getPrivacyApi() async {
  final response = await http.get(Uri.parse(privacyUrl));
  print("Privacy${response.body}");
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> getAboutApi() async {
  final response = await http.get(Uri.parse(aboutUsUrl));
  return StatusResponse.fromJson(json.decode(response.body));
}

Future<StatusResponse> resetPassword(Map<String, String> parms) async {
  final response = await http.post(Uri.parse(RESET_PASSWORD),
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
  final response = await http.post(Uri.parse(eventDetails),
      headers: header(userAuth), body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  return StatusResponse.fromJson(map);
}

Future<StatusResponse> bookingDeleteApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(Uri.parse(bookingDelete),
      headers: header(userAuth), body: jsonEncode(parms));
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  return StatusResponse.fromJson(map);
}

Future<StatusResponse> bookingApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(Uri.parse(bookingUrl),
      headers: header(userAuth), body: jsonEncode(parms));
  print("Booking " + response.body);
  final jsonData = json.decode(response.body);

  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> getTrainerReviewsApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(
      userAuth != null && userAuth.isNotEmpty
          ? Uri.parse(trainerReviewsRegister)
          : Uri.parse(trainerReviews),
      headers: header(userAuth),
      body: jsonEncode(parms));

  print(userAuth);
  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);

  return StatusResponse.fromJson(map);
}

Future<StatusResponse> allBookingsApi(
    String userAuth, Map<String, String> parms) async {
  final response = await http.post(Uri.parse(allBookinsUrl),
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