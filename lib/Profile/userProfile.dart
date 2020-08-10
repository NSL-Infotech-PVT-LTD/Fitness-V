import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  String baseImageUrl = 'assets/images/';

  final formKey = GlobalKey<FormState>();

  /// @AuthScreens Controllers
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middletNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emergencyController = TextEditingController();
  var emailController = TextEditingController();
  var dobController = TextEditingController();
  var designationController = TextEditingController();
  var emiratesController = TextEditingController();
  var addressController = TextEditingController();

  bool _isIos;
  bool _isEnable = true;
  String deviceType = '';
  String deviceToken = "";

  var fromDate, toDate;
  var formatter = new DateFormat("yyyy-MM-dd");

  void fromDatePicker() async {
    var order = await getData();
    setState(() {
      if (order != null) fromDate = formatter.format(order);
    });
  }

  Future<DateTime> getData() {
    return showDatePicker(
        context: context,
        initialDate: DateTime(2019),
        firstDate: DateTime(1980),
        lastDate: DateTime(2020),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.fallback(),
            child: child,
          );
        });
  }

  void _getProfileDetail(String auth) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        getProfileDetailApi(auth).then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              firstNameController.text = response.data.user.first_name;
              middletNameController.text = response.data.user.middle_name;
              lastNameController.text = response.data.user.last_name;
              mobileController.text = response.data.user.mobile;
              emergencyController.text =
                  response.data.user.emergency_contact_no;
              emailController.text = response.data.user.email;
              designationController.text = response.data.user.designation;
              emiratesController.text = response.data.user.emirates_id;
              addressController.text = response.data.user.address;
              fromDate = response.data.user.birth_date;
              setState(() {});
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, 'Internet Error', pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  @override
  void initState() {
    _isIos = Platform.isIOS;

    deviceType = _isIos ? 'ios' : 'android';
    String auth = '';
    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {_getProfileDetail(auth)});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: topMargin,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    baseImageAssetsUrl + 'logo_black.png',
                    width: 60,
                    height: 30,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ))
                ],
              ),
            ),
            Container(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: SvgPicture.asset(
                      baseImageAssetsUrl + 'horizontal.svg',
                      width: SizeConfig.screenWidth,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 15,
                    child: Image.asset(
                      baseImageAssetsUrl + 'circleuser.png',
                      height: 105,
                      width: 105,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              updateProfile,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            Icon(Icons.camera_alt),
            SizedBox(
              height: 30,
            ),
            myDivider(),
            WillPopScope(
                onWillPop: () {
//                  Navigator.pop(context, widget.editData);
                  return new Future(() => false);
                },
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            padding30, padding10, padding30, padding30),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: _isEnable,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z]"))
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  }
                                  return null;
                                },
                                controller: firstNameController,
                                decoration: InputDecoration(
                                    hintText: firstname + '*',
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: _isEnable,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z]"))
                                ],
                                controller: middletNameController,
                                decoration: InputDecoration(
                                    hintText: midlename,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: _isEnable,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z]"))
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  }
                                  return null;
                                },
                                controller: lastNameController,
                                decoration: InputDecoration(
                                    hintText: lastname + '*',
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),

//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            child + '*',
//                            style: TextStyle(color: Colors.black54),
//                          ),
//                          radiobutton('1'),
//                          radiobutton('2'),
//                          radiobutton('None'),
//                        ],
//                      ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                maxLength: 15,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  } else if (value.length < 9) {
                                    return 'Please Enter Valid Number';
                                  }
                                  return null;
                                },
                                controller: mobileController,
                                decoration: InputDecoration(
                                    hintText: mobile,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                maxLength: 15,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  } else if (value.length < 9) {
                                    return 'Please enter valid number';
                                  }
                                  return null;
                                },
                                controller: emergencyController,
                                decoration: InputDecoration(
                                    hintText: emergencyContact,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  } else if (!validateEmail(value)) {
                                    return 'Please enter valid email';
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: email + '*',
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),

                            Container(
                              margin:
                                  EdgeInsets.only(top: margin20, bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(button_radius)),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        fromDate == null
                                            ? birthDate
                                            : fromDate.toString(),
                                        style: TextStyle(
                                            fontSize: textSize12,
                                            color: fromDate == null
                                                ? Colors.black45
                                                : Colors.black),
                                      )),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: fromDatePicker,
                                    child: Container(
                                      height: 50,
                                      width: 40,
                                      color: Color(0xFFDFDFDF),
                                      child: Image(
                                        image: AssetImage(
                                            baseImageUrl + 'calendar.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: _isEnable,
                                controller: designationController,
                                decoration: InputDecoration(
                                    hintText: designation,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: _isEnable,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  }
                                  return null;
                                },
                                controller: emiratesController,
                                decoration: InputDecoration(
                                    hintText: emiratesId,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: _isEnable,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  }
                                  return null;
                                },
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: address,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: padding25),
                              height: button_height,
                              width: SizeConfig.screenWidth,
                              child: RaisedButton(
                                onPressed: () {
                                  _isEnable = false;
                                  setState(() {

                                  });
//                                _buildMagnifierScreen();
//                                        if (formKey.currentState.validate()) {
//                                          if (fromDate == null) {
//                                            showDialogBox(context, 'Date of Birth',
//                                                'Please fill your date of birth');
//                                          } else if (widget.isSingle && !acceptTerms) {
//                                            showDialogBox(context, termsofService,
//                                                'Please read & accept our terms of services');
//                                          } else {
//                                            parms = {
//                                              FIRSTNAME + widget.formType:
//                                              firstNameController.text
//                                                  .toString()
//                                                  .trim(),
//                                              MIDDLENAME + widget.formType:
//                                              middletNameController.text
//                                                  .toString()
//                                                  .trim(),
//                                              LASTNAME + widget.formType:
//                                              lastNameController.text
//                                                  .toString()
//                                                  .trim(),
////                                  CHILD: radioItem.toString(),
//                                              MOBILE + widget.formType: mobileController
//                                                  .text
//                                                  .toString()
//                                                  .trim(),
//
//                                              EMAIL + widget.formType: emailController
//                                                  .text
//                                                  .toString()
//                                                  .trim(),
//                                              PASSWORD + widget.formType:
//                                              passwordController.text
//                                                  .toString()
//                                                  .trim(),
//                                              BIRTH_DATE + widget.formType: fromDate,
//
//                                              EMIRATES_ID + widget.formType:
//                                              emiratesController.text
//                                                  .toString()
//                                                  .trim(),
//                                              ROLE_ID: roleId,
//                                              ROLE_PLAN_ID: rolePlanId,
//
//                                              EMEREGENCY_NUMBER: emergencyController
//                                                  .text
//                                                  .toString()
//                                                  .trim(),
//                                              DESIGNATION: designationController.text
//                                                  .toString()
//                                                  .trim(),
//                                              ADDRESS: addressController.text
//                                                  .toString()
//                                                  .trim(),
//                                              DEVICE_TYPE: deviceType,
//                                              DEVICE_TOKEN: "Devicedsbfs",
//                                            };
//                                            print(
//                                                parms.toString() + "------Parameters");
//
//                                            if (widget.isSingle) {
//                                              isConnectedToInternet().then((internet) {
//                                                showProgress(
//                                                    context, "Please wait.....");
//                                                if (internet != null && internet) {
//                                                  signUpToServer(parms)
//                                                      .then((response) {
//                                                    dismissDialog(context);
//                                                    if (response.status) {
//                                                      Navigator.pushAndRemoveUntil(
//                                                        context,
//                                                        ScaleRoute(
//                                                            page: SuccessScreen()),
//                                                            (r) => false,
//                                                      );
//                                                    } else {
//                                                      print(response.toString());
//                                                      var errorMessage = '';
//                                                      if(response.error!=null){
//                                                        errorMessage = response.error.toString();
//                                                      }else if(response.errors!=null){
//                                                        errorMessage = response.errors.email.toString();
//                                                      }
//                                                      showDialogBox(context, "Error!",
//                                                          errorMessage);
//                                                    }
//                                                  });
//                                                } else {
//                                                  showDialogBox(
//                                                      context,
//                                                      'Internet Error',
//                                                      pleaseCheckInternet);
//                                                  dismissDialog(context);
//                                                }
//                                                dismissDialog(context);
//                                              });
//                                            } else {
//                                              Navigator.pop(context, parms);
//                                            }
//                                          }
//                                        }
                                },
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(button_radius)),
                                child: Text(
                                  _isEnable ? 'Edit Profile' : updateProfile,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
