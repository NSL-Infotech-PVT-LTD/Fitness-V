import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:volt/util/number_format.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Methods.dart';
import '../Methods/api_interface.dart';
import '../Value/Strings.dart';
import 'SuccessScreen.dart';

class SignupScreen extends StatefulWidget {
  final List response;
  final String type;
  final int planIndex;
  final String formType;
  final bool isSingle;
  final bool isEmailError;

  final Map<String, String> editData;

  SignupScreen(
      {this.response,
      this.planIndex,
      this.type,
      this.formType,
      this.editData,
      this.isEmailError,
      this.isSingle});

  @override
  State<StatefulWidget> createState() => SignupState();
}

class SignupState extends State<SignupScreen> {
  String baseImageUrl = 'assets/images/';
  String radioItem = '';
  String radioItemMarital = '';
  bool acceptTerms = false;
  final formKey = GlobalKey<FormState>();

  /// @AuthScreens Controllers
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middletNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emergencyController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var dobController = TextEditingController();
  var designationController = TextEditingController();
  var emiratesController = TextEditingController();
  var addressController = TextEditingController();
  List<String> _cities = [
    'Dubai',
    'Sharjah',
    'Abu Dhabi',
    'Ajman',
    'Ras al-khaimah',
//    'Musaffah City',
//    'AI Fujairah City',
//    'Khalifah A City',
//    'Reef AI Fujairah City',
//    'Bani Yas City',
//    'Zayed City',
    'Umm al-Quwain',
  ];
  String selectedCity;

  bool _isIos;
  String deviceType = '';
  String roleId = "";
  String deviceToken = "";

  String rolePlanId = "";
  var fromDate;
  var myDate, sendDate;
  var formatter = new DateFormat("dd/MM/yyyy");
  var sendDateFormat = new DateFormat("yyyy-MM-dd");

  Map<String, String> parms;

  void fromDatePicker() {
    getData();
  }

  Future<DateTime> getData() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(actions: <Widget>[
            CupertinoActionSheetAction(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.black87),
                    ),
                  )),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (myDate != null) {
                    fromDate = formatter.format(myDate);
                    sendDate = sendDateFormat.format(myDate);
                  }
                });
              },
            ),
            Container(
              height: 300.0,
              color: Colors.white,
              child: CupertinoDatePicker(
                use24hFormat: true,
                maximumDate: new DateTime(2019, 12, 30),
                minimumYear: 1970,
                maximumYear: 2019,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2018),
                backgroundColor: Colors.white,
                onDateTimeChanged: (dateTime) {
                  myDate = dateTime;
//                setState(() {
//                  if (dateTime != null) fromDate = formatter.format(dateTime);
//                });
                },
              ),
            ),
          ]);
        });

//    return showDatePicker(
//        context: context,
//        initialDate: DateTime(2019),
//        firstDate: DateTime(1980),
//        lastDate: DateTime(2020),
//        builder: (BuildContext context, Widget child) {
//          return Theme(
//            data: ThemeData.fallback(),
//            child: child,
//          );
//        });
  }

  @override
  void initState() {
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';

    if (widget.editData != null) {
      if (widget.editData.containsKey(FIRSTNAME + "_1")) {
        _setData("_1");
      } else if (widget.editData.containsKey(FIRSTNAME + "_2")) {
        _setData("_2");
      } else if (widget.editData.containsKey(FIRSTNAME + "_3")) {
        _setData("_3");
      } else {
        _setData("");
      }
    }
    super.initState();
  }

//  @override
//  void dispose(){
//    firstNameController.dispose();
//    middletNameController.dispose();
//    lastNameController.dispose();
//    mobileController.dispose();
//    emergencyController.dispose();
//    emailController.dispose();
//    passwordController.dispose();
//    designationController.dispose();
//    emiratesController.dispose();
//    addressController.dispose();
//    super.dispose();
//  }
//

  _setData(String type) {
    firstNameController.text = widget.editData[FIRSTNAME + type];
    middletNameController.text = widget.editData[MIDDLENAME + type];
    lastNameController.text = widget.editData[LASTNAME + type];
    mobileController.text = widget.editData[MOBILE + type];
    emergencyController.text = widget.editData[EMEREGENCY_NUMBER + type];
    emailController.text = widget.editData[EMAIL + type];
    passwordController.text = widget.editData[PASSWORD + type];
    fromDate = widget.editData[BIRTH_DATE + type];
    designationController.text = widget.editData[DESIGNATION + type];
    emiratesController.text = widget.editData[EMIRATES_ID + type];
    addressController.text = widget.editData[ADDRESS + type];
    selectedCity = widget.editData[CITY + type];
  }

  @override
  Widget build(BuildContext context) {
    //[{id: 1, fee: 250, fee_type: Monthly, role_id: 1, role_plan: Monthly: AED 250},
    // {id: 2, fee: 1700, fee_type: Quarterly, role_id: 1, role_plan: Quarterly: AED 1700},
    // {id: 3, fee: 3200, fee_type: Half yearly, role_id: 1, role_plan: Half yearly: AED 3200},
    // {id: 4, fee: 6000, fee_type: Yearly, role_id: 1, role_plan: Yearly: AED 6000}]

    // [{id: 25, fee: 400, fee_type: Monthly, role_id: 7, role_plan: Monthly: AED 400},
    // {id: 26, fee: 700, fee_type: Quarterly, role_id: 7, role_plan: Quarterly: AED 700},
    // {id: 27, fee: 1300, fee_type: Half yearly, role_id: 7, role_plan: Half yearly: AED 1300},
    // {id: 28, fee: 1900, fee_type: Yearly, role_id: 7, role_plan: Yearly: AED 1900}]

    if (widget.type != null) {
      roleId = widget.response[0]['id'].toString();

      if (widget.type != 'guest') {
        List plans = widget.response;
        if (plans.length > 0) {
          rolePlanId = plans[widget.planIndex]['id'].toString();
          roleId = widget.response[widget.planIndex]['role_id'].toString();
        }
      }
    }
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, widget.editData);
          return new Future(() => false);
        },
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: CColor.WHITE,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 300.0,
                    floating: false,
                    backgroundColor: Colors.black,
                    pinned: true,
                    iconTheme: IconThemeData(color: Colors.white),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Container(
                        margin: EdgeInsets.fromLTRB(0, topMargin, 0, 0),
                        height: 300,
                        width: SizeConfig.screenWidth,
                        color: Colors.black,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 0,
                                right: 0,
                                top: padding50,
                                child: Image.asset(
                                  baseImageUrl + 'exc_sign.png',
                                  height: 111,
                                )),
                            Positioned(
                              left: 50,
                              bottom: padding50 + padding30,
                              child:
                                  Image.asset(baseImageUrl + 'user_sign.png'),
                            ),
                            Positioned(
                              left: 90,
                              bottom: padding50 + padding30,
                              child: Text(
                                signup,
                                style: TextStyle(
                                    color: CColor.WHITE, fontSize: textSize24),
                              ),
                            ),
                            Positioned(
                              left: 90,
                              right: 60,
                              bottom: padding45,
                              child: Padding(
                                child: Text(
                                  'Please give us your details to enjoy our premium experience',
                                  style: TextStyle(
                                      color: CColor.WHITE,
                                      fontSize: textSize12),
                                ),
                                padding: EdgeInsets.fromLTRB(5, 10, 20, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          padding50, padding30, padding50, padding30),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Enter your personal details below: ',
                            style: TextStyle(
                                color: Color(0xFF707070), fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
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

                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              radiobutton('Male'),
                              radiobutton('Female'),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                CardNumberInputFormatter()
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
                          Visibility(
                              visible: widget.formType.isEmpty ? true : false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    CardNumberInputFormatter()
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
                                      hintStyle:
                                          TextStyle(fontSize: textSize12)),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
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
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fieldIsRequired;
                                } else if (value.length < 5) {
                                  return 'Password must be more than 6 words';
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: password + '*',
                                  hintStyle: TextStyle(fontSize: textSize12)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: margin20, bottom: 10),
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
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          radioMerital(single),
//                          radioMerital(married),
//                        ],
//                      ),
                          Visibility(
                            visible: widget.formType.isEmpty ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: designationController,
                                decoration: InputDecoration(
                                    hintText: designation,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
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
                          Visibility(
                            visible: widget.formType.isEmpty ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
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
                          ),
                          Visibility(
                            visible: widget.formType.isEmpty ? true : false,
                            child: Padding(
                                padding: EdgeInsets.only(top: 18),
                                child: DropdownButton(
                                  hint: selectedCity == null
                                      ? Text('Select Emirates')
                                      : Text(
                                          selectedCity,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(fontSize: 12),
                                  items: _cities.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(
                                          val,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        selectedCity = val;
                                      },
                                    );
                                  },
                                )),
                          ),
                          Visibility(
                              visible: widget.isSingle,
                              child: checkbox(
                                  iaccept, termsofService, acceptTerms)),
                          Container(
                            margin: EdgeInsets.only(top: padding25),
                            height: button_height,
                            width: SizeConfig.screenWidth,
                            child: RaisedButton(
                              onPressed: () {
//                                _buildMagnifierScreen();


                                if (formKey.currentState.validate()) {
                                  if (fromDate == null) {
                                    showDialogBox(context, 'Date of Birth',
                                        'Please fill your date of birth');
                                  } else if (radioItem.isEmpty) {
                                    showDialogBox(context, 'Gender',
                                        'Please select gender');
                                  } else if (selectedCity == null) {
                                    showDialogBox(context, 'City',
                                        'Please select your city');
                                  } else if (widget.isSingle && !acceptTerms) {
                                    showDialogBox(context, termsofService,
                                        'Please read & accept our terms of services');
                                  } else {
                                    parms = {
                                      FIRSTNAME + widget.formType:
                                          firstNameController.text
                                              .toString()
                                              .trim(),
                                      MIDDLENAME + widget.formType:
                                          middletNameController.text
                                              .toString()
                                              .trim(),
                                      LASTNAME + widget.formType:
                                          lastNameController.text
                                              .toString()
                                              .trim(),
//                                  CHILD: radioItem.toString(),
                                      MOBILE + widget.formType: mobileController
                                          .text
                                          .toString()
                                          .trim(),

                                      EMAIL + widget.formType: emailController
                                          .text
                                          .toString()
                                          .trim(),
                                      PASSWORD + widget.formType:
                                          passwordController.text
                                              .toString()
                                              .trim(),
                                      BIRTH_DATE + widget.formType: sendDate,

                                      EMIRATES_ID + widget.formType:
                                          emiratesController.text
                                              .toString()
                                              .trim(),
                                      ROLE_ID: roleId,
                                      ROLE_PLAN_ID: rolePlanId,

                                      EMEREGENCY_NUMBER: emergencyController
                                          .text
                                          .toString()
                                          .trim(),
                                      DESIGNATION: designationController.text
                                          .toString()
                                          .trim(),
                                      ADDRESS: addressController.text
                                          .toString()
                                          .trim(),
                                      CITY: selectedCity,
                                      DEVICE_TYPE: deviceType,
                                      GENDER + widget.formType:
                                          radioItem.toLowerCase(),
                                      DEVICE_TOKEN: deviceTokenValue,
                                    };
                                    print("$parms");

                                    if (widget.isSingle) {
                                      isConnectedToInternet().then((internet) {
                                        showProgress(
                                            context, "Please wait.....");
                                        if (internet != null && internet) {
                                          signUpToServer(parms)
                                              .then((response) {
                                            dismissDialog(context);
                                            if (response.status) {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                ScaleRoute(
                                                    page: SuccessScreen()),
                                                (r) => false,
                                              );
                                            } else {
                                              var errorMessage = '';
                                              if (response.error != null) {
                                                errorMessage =
                                                    response.error.toString();
                                              } else if (response.errors !=
                                                  null) {
                                                errorMessage = response
                                                    .errors.email
                                                    .toString();
                                              }
                                              showDialogBox(context, "Error!",
                                                  errorMessage);
                                            }
                                          });
                                        } else {
                                          showDialogBox(context, internetError,
                                              pleaseCheckInternet);
                                          dismissDialog(context);
                                        }
                                        dismissDialog(context);
                                      });
                                    } else {
                                      Navigator.pop(context, parms);
                                    }
                                  }
                                }
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(button_radius)),
                              child: Text(
                                widget.isSingle ? signup : 'Done',
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
              ),
            ),
          ),
        ));
  }

  Widget myText(String hint, bool isNumber) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            hintText: hint, hintStyle: TextStyle(fontSize: textSize10)),
      ),
    );
  }

  Widget radiobutton(String title) {
    return Expanded(
      child: RadioListTile(
        groupValue: radioItem,
        activeColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        value: title,
        onChanged: (val) {
          setState(() {
            radioItem = val;
          });
        },
      ),
    );
  }

  Widget radioMerital(String title) {
    return Expanded(
      child: RadioListTile(
        groupValue: radioItemMarital,
        activeColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        value: title,
        onChanged: (val) {
          setState(() {
            radioItemMarital = val;
          });
        },
      ),
    );
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
                  // getTerms();
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
