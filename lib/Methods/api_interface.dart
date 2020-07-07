//Api's references

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:volt/ResponseModel/StatusResponse.dart';

String LOGIN = BASE_URL + "api/login";
String REGISTRATION = BASE_URL + "api/register";
String GETPROFILE = BASE_URL + "api/getprofile";

String CUSTOMER_ID = "";

//API's keys

String DEVICE_TYPE = "device_type";
String DEVICE_TOKEN = "device_token";
String NAME = "name";
String FIRSTNAME = "first_name";
String LASTNAME = "last_name";
String EMAIL = "email";
String GENDER = "gender";
String MOBILE = "mobile";
String NATIONALID = "national_id";
String PASSWORD = "password";
String ID = "id";
String ANDROID = "android";
String DEVICE_TOKEN_VALUE = "value";
String Authorization = "Authorization";
String Content_Type = "Content-Type";
String CUSTOMER_NAME = "customer_name";
String Product_ID = "product_id";

//add product api's keys

String SEARCH = "search";

//signup keys
String COMPANY_SERVICE_NAME = "company_service_provider_name";
String PAN_CARD = "pan_card";
String ADHAR_CARD = "aadhar_card";
String LATITUDE = "latitude";
String LONGITUDE = "longitude";
String ADDRESS = "address";

//user data
String USER_AUTH = "USER_AUTH";
String USER_NAME = "USER_NAME";
String COMPANY_NAME = "COMPANY_NAME";
String USER_NUMBER = "USER_NUMBER";
String USER_PROFILE = "USER_PROFILE";
String PANCARD = "PANCARD";
String ADHARCARD = "ADHARCARD";
String USER_ADDRESS = "ADDRESS";
String GSTIN = "GSTIN";
String USER_EMAIL = "USER_EMAIL";
String CONTENT_VALUE = "application/x-www-form-urlencoded";
String ORDER_BY = "price_high";

String BASE_URL = "https://dev.netscapelabs.com/getmech/";
String DEALER_PROFILE_IMAGE = "uploads/dealer/profile_image/";
String IMAGE_URL = "uploads/product/image/";
String MORE_IMAGE_URL = "uploads/product/images/";
String BARCODE_URL = "uploads/product/barcode/";

Future<StatusResponse> getLogin(Map<String, String> parms) async {
  final response = await http.post(LOGIN,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(parms));
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

Future<StatusResponse> getProfile(String userAuth) async {
  final response = await http.post(
    GETPROFILE,
    headers: header(userAuth),
  );
  print("json Data "+json.decode(response.body));

  return StatusResponse.fromJson(json.decode(response.body));
}

header(String auth) => {
      Content_Type: 'application/json; charset=UTF-8',
      Authorization: auth,
    };
