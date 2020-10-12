import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../AuthScreens/SignupScreen.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Methods/Method.dart';
import '../Methods/api_interface.dart';
import '../Value/Strings.dart';
import '../Value/Strings.dart';

class SpouseType extends StatefulWidget {
  List response;
  String type = "";
  int plan_index = 0;
  String roleId = "";

  SpouseType({this.response, this.plan_index, this.type, this.roleId});

  @override
  _SpouseTypeState createState() => _SpouseTypeState();
}

class _SpouseTypeState extends State<SpouseType> {
  bool acceptTerms = false;
  double setWidth;
  bool _isIos;
  String deviceType = '';
  String roleId = "";
  String deviceToken = "";
  var errorMessage = '';
  var errorMessage1 = '';

  String rolePlanId = "";
  var result, result1;

  @override
  void initState() {
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';
    super.initState();
  }

  _navigateAndDisplaySelection(BuildContext context, String formType) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
                formType: formType,
                editData: result,
                isSingle: false,
              isCityTrue: true,
              isEmailError: errorMessage1.contains("email has") ? true : false,
              )),
    );

    setState(() {});
  }

  _navigateAndDisplaySelection1(BuildContext context, String formType) async {
    result1 = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
                formType: formType,
                editData: result1,
                isSingle: false,
              isCityTrue: false, isEmailError: errorMessage1.contains("email 1") ? true : false,
              )),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    rolePlanId = widget.response[widget.plan_index]['id'].toString();

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          if (result != null || result1 != null) {
            exitDialog(context);
            return new Future(() => false);
          } else {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: CColor.WHITE,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: topMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/two_lady.jpg',
                        width: SizeConfig.screenWidth,
                        height: 234,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Container(
                    height: 72,
                    width: SizeConfig.screenWidth,
                    color: Colors.black,
                    padding: EdgeInsets.only(left: padding25),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            child: Text(
                              fill,
                              style: TextStyle(
                                color: CColor.WHITE,
                                fontSize: textSize18,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              padding: EdgeInsets.only(
                                  right: padding25, top: padding20),
                              child: Text(
                                couple +
                                    widget.response[widget.plan_index]
                                        ['fee_type'],
                                style: TextStyle(
                                  color: CColor.WHITE,
                                  fontSize: textSize10,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black,
                              padding: EdgeInsets.only(right: padding25),
                              child: Text(
                                aed +
                                    widget.response[widget.plan_index]['fee']
                                        .toString(),
                                style: TextStyle(
                                  color: CColor.WHITE,
                                  fontSize: textSize18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            height: SizeConfig.screenHeight * 0.20,
                            width: SizeConfig.screenWidth * 0.40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(
                                  width: errorMessage1.contains("email has")
                                      ? 2
                                      : 1.5,
                                  color: errorMessage1.contains("email has")
                                      ? Colors.red
                                      : Color(0xFFBDBDBD),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                color: result != null
                                    ? Colors.black
                                    : Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
//                                Padding(
//                                  padding: EdgeInsets.all(10),
//                                ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Text(
                                      result != null
                                          ? result[FIRSTNAME]
                                          : 'Spouse#1',
                                      style: TextStyle(
                                        color: result != null
                                            ? CColor.WHITE
                                            : Colors.black,
                                        fontSize: textSize12,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        baseImageAssetsUrl + 'user.svg',
                                        color: result != null
                                            ? Colors.white
                                            : Colors.black,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(top: padding15),
                                    height: 40,
                                    width: SizeConfig.screenWidth * 0.33,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: result != null
                                              ? Colors.white
                                              : Colors.black45,
                                        )),
                                    child: RaisedButton(
                                      onPressed: () {
                                        _navigateAndDisplaySelection(
                                            context, "");
                                      },
                                      color: result != null
                                          ? Colors.black
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Fill Details',
                                            style: TextStyle(
                                                color: result != null
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 10),
                                          ),
                                          Visibility(
                                              visible: errorMessage1
                                                      .contains("email has")
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                child: Align(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                    size: 16,
                                                  ),
                                                  alignment: Alignment.center,
                                                ),
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: SizeConfig.screenHeight * 0.20,
                            width: SizeConfig.screenWidth * 0.40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(
                                  width: errorMessage1.contains("email 1")
                                      ? 2
                                      : 1.5,
                                  color: errorMessage1.contains("email 1")
                                      ? Colors.red
                                      : Color(0xFFBDBDBD),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                color: result1 != null
                                    ? Colors.black
                                    : Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Text(
                                      result1 != null
                                          ? result1[FIRSTNAME + "_1"]
                                          : 'Spouse#2',
                                      style: TextStyle(
                                        color: result1 != null
                                            ? CColor.WHITE
                                            : Colors.black,
                                        fontSize: textSize12,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        baseImageAssetsUrl + 'user.svg',
                                        color: result1 != null
                                            ? Colors.white
                                            : Colors.black,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: padding15),
                                  height: 40,
                                  width: SizeConfig.screenWidth * 0.33,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: result1 != null
                                            ? Colors.white
                                            : Colors.black45,
                                      )),
                                  child: RaisedButton(
                                    onPressed: () {
                                      _navigateAndDisplaySelection1(
                                          context, "_1");
                                    },
                                    color: result1 != null
                                        ? Colors.black
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Fill Details',
                                          style: TextStyle(
                                              color: result1 != null
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 10),
                                        ),
                                        Visibility(
                                            visible: errorMessage1
                                                    .contains("email 1")
                                                ? true
                                                : false,
                                            child: Padding(
                                              child: Align(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                                alignment: Alignment.center,
                                              ),
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: padding10),
                        height: 45,
                        width: setWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.white),
                        child: RaisedButton(
                          onPressed: () {
                            var count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 2;
                            });
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            'Have Child?',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    child: checkbox(iaccept, termsofService, acceptTerms),
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: padding15, left: 20, right: 20),
                    height: button_height,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        color: Colors.white),
                    child: RaisedButton(
                      onPressed: () {
                        if (result != null && result1 != null && acceptTerms) {
                          Map<String, String> parms = {
                            /**
                             * single form detail
                             */

                            FIRSTNAME: result[FIRSTNAME],
                            MIDDLENAME: result[MIDDLENAME],
                            LASTNAME: result[LASTNAME],
                            MOBILE: result[MOBILE],
                            EMAIL: result[EMAIL],
                            PASSWORD: result[PASSWORD],
                            BIRTH_DATE: result[BIRTH_DATE],
                            EMIRATES_ID: result[EMIRATES_ID],
                            ROLE_ID: widget.roleId,
                            ROLE_PLAN_ID: rolePlanId,
                            EMEREGENCY_NUMBER: result[EMEREGENCY_NUMBER],
                            DESIGNATION: result[DESIGNATION],
                            ADDRESS: result[ADDRESS],
                            GENDER: result[GENDER],
                            CITY: result[CITY],
                            /**
                             * form 1 details
                             */
                            FIRSTNAME + "_1": result1[FIRSTNAME + "_1"],
                            MIDDLENAME + "_1": result1[MIDDLENAME + "_1"],
                            LASTNAME + "_1": result1[LASTNAME + "_1"],
                            MOBILE + "_1": result1[MOBILE + "_1"],
                            EMAIL + "_1": result1[EMAIL + "_1"],
                            PASSWORD + "_1": result1[PASSWORD + "_1"],
                            BIRTH_DATE + "_1": result1[BIRTH_DATE + "_1"],
                            EMIRATES_ID + "_1": result1[EMIRATES_ID + "_1"],
                            GENDER + "_1": result1[GENDER + "_1"],
                            DEVICE_TYPE: deviceType,
                            DEVICE_TOKEN:deviceTokenValue,
                          };
                          print("bjbfjj$parms");
//                          isConnectedToInternet().then((internet) {
//                            if (internet != null && internet) {
//                              showProgress(context, "Please wait.....");
//
//                              signUpToServer(parms).then((response) {
//                                dismissDialog(context);
//                                if (response.status) {
//                                  Navigator.pushAndRemoveUntil(
//                                    context,
//                                    ScaleRoute(page: SuccessScreen()),
//                                    (r) => false,
//                                  );
//                                } else {
//                                  dismissDialog(context);
//
//                                  if (response.error != null)
//                                    showDialogBox(
//                                        context, "Error!", response.error);
//                                  else {
//                                    errorMessage1 = '';
//                                    if (response.errors != null) {
//                                      var value = response.errors.toJson();
//
//                                      if (value['email'] != null) {
//                                        errorMessage = response.errors.email;
//                                        setState(() {
//                                          errorMessage1 = response.errors.email;
//                                        });
//                                      } else if (response.errors.email_1 !=
//                                          null) {
//                                        errorMessage = response.errors.email_1;
//                                        setState(() {
//                                          errorMessage1 =
//                                              response.errors.email_1;
//                                        });
//                                      } else if (response.errors.email_2 !=
//                                          null) {
//                                        errorMessage = response.errors.email_2;
//                                        setState(() {
//                                          errorMessage1 =
//                                              response.errors.email_2;
//                                        });
//                                      } else if (response.errors.email_3 !=
//                                          null) {
//                                        errorMessage = response.errors.email_3;
//                                        setState(() {
//                                          errorMessage1 =
//                                              response.errors.email_3;
//                                        });
//                                      }
//
//                                      showDialogBox(
//                                          context, error, errorMessage);
//                                    }
//                                  }
//                                }
//                              });
//                            } else {
//                              showDialogBox(context, internetError,
//                                  pleaseCheckInternet);
//                              dismissDialog(context);
//                            }
//                            dismissDialog(context);
//                          });
//                        } else if (!acceptTerms) {
//                          showDialogBox(context, termsofService,
//                              'Please read & accept our terms of services');
//                        } else {
//                          showDialogBox(context, error, 'Please fill details');
                        }
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Text(
                        signup,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
//
                ],
              ),
            ),
          ),
        ));
  }

  Widget checkbox(String title, String richTExt, bool boolValue) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                acceptTerms = value;
                if (value) {
                  //  termsBottom('Terms of Services');
                }
              });
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new RichText(
                text: new TextSpan(
                  text: title,
                  style: TextStyle(fontSize: textSize10, color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: richTExt,
                        style: TextStyle(
                            fontSize: textSize10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ],
                ),
              ),
            ),
            onTap: () {
              getTerms();
            },
          ),
        ],
      ),
    );
  }

  void getTerms() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        getTermsApi().then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              if (response.data.config != null &&
                  response.data.config.isNotEmpty)
                termsBottom('Terms & Conditions', response.data.config);
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  void termsBottom(String title, String msg) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Container(
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(50.0),
                          topRight: const Radius.circular(50.0))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child: Padding(
                          child: Align(
                            child: Icon(Icons.close),
                            alignment: Alignment.topRight,
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Html(data:msg),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                baseImageAssetsUrl + 'logo_black.png',
                                height: 90,
                                color: Color(0xff8B8B8B),
                                width: 120,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                baseImageAssetsUrl + 'vector_lady.svg',
                                height: 90,
                                width: 120,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              volt_rights,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff8B8B8B),
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: open_italic),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  )),
            ));
          });
        });
  }
}
