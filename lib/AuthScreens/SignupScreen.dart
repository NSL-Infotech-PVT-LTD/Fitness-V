import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/AuthScreens/SuccessScreen.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class SignupScreen extends StatefulWidget {
  List response;
  String type = "";
  int plan_index = 0;

  SignupScreen({this.response, this.plan_index, this.type});

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

  bool _isIos;
  String deviceType = '';
  String role_id = "";

  String role_plan_id = "";
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

  @override
  void initState() {
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    role_id = widget.response[0]['id'].toString();

    if (widget.type != 'guest') {
      List plans = widget.response;
      print(plans.toString());
      if (plans.length > 0) {
        role_plan_id = plans[widget.plan_index]['id'].toString();

        print(role_plan_id.toString());
        print(role_id.toString());
      }
    }
    SizeConfig().init(context);
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: CColor.WHITE,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                backgroundColor: Colors.black,
                pinned: true,
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
                          child: Image.asset(baseImageUrl + 'user_sign.png'),
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
                                  color: CColor.WHITE, fontSize: textSize12),
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
                        style:
                            TextStyle(color: Color(0xFF707070), fontSize: 15),
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
                            border:
                                Border.all(color: Colors.black26, width: 1)),
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
                                  image:
                                      AssetImage(baseImageUrl + 'calendar.png'),
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
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
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
                      checkbox(iaccept, termsofService, acceptTerms),
                      Container(
                        margin: EdgeInsets.only(top: padding15),
                        height: button_height,
                        width: SizeConfig.screenWidth,
                        child: RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
//                              if (radioItem.isEmpty) {
//                                showDialogBox(context, 'Child',
//                                    'Please select you child(s)');
//                              } else

                              if (fromDate == null) {
                                showDialogBox(context, 'Date of Birth',
                                    'Please fill your date of birth');
                              } else if (!acceptTerms) {
                                showDialogBox(context, termsofService,
                                    'Please read & accept our terms of services');
                              } else {
//                                if (radioItem == '1') {
//                                  radioItem = '1_child';
//                                } else if (radioItem == '2') {
//                                  radioItem = '2_child';
//                                } else {
//                                  radioItem = 'none';
//                                }
                                Map<String, String> parms = {
                                  FIRSTNAME: firstNameController.text
                                      .toString()
                                      .trim(),
                                  MIDDLENAME: middletNameController.text
                                      .toString()
                                      .trim(),
                                  LASTNAME:
                                      lastNameController.text.toString().trim(),
                                  CHILD: radioItem.toString(),
                                  MOBILE:
                                      mobileController.text.toString().trim(),
                                  EMEREGENCY_NUMBER: emergencyController.text
                                      .toString()
                                      .trim(),
                                  EMAIL: emailController.text.toString().trim(),
                                  PASSWORD:
                                      emailController.text.toString().trim(),
                                  BIRTH_DATE: fromDate,
                                  DESIGNATION: designationController.text
                                      .toString()
                                      .trim(),
                                  EMIRATES_ID:
                                      emiratesController.text.toString().trim(),
                                  ADDRESS:
                                      addressController.text.toString().trim(),
                                  ROLE_ID: role_id,
                                  ROLE_PLAN_ID: role_plan_id,
                                  DEVICE_TYPE: deviceType,
                                  DEVICE_TOKEN: "Devicedsbfs",
                                };

                                print(parms.toString() + "------Parameters");
                                isConnectedToInternet().then((internet) {
                                  if (internet != null && internet) {
                                    showProgress(context, "Please wait.....");
                                    signUpToServer(parms).then((response) {
                                      print("CheckBeforSuccess->" +
                                          response.toJson().toString());
                                      dismissDialog(context);
                                      if (response.status) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          ScaleRoute(page: SuccessScreen()),
                                          (r) => false,
                                        );
                                      } else {
                                        print(response.toString());
                                        showDialogBox(
                                            context, "Error!", response.error);
                                      }
                                    });
                                  } else {
                                    showDialogBox(context, 'Internet Error',
                                        pleaseCheckInternet);
                                    dismissDialog(context);
                                  }
                                  dismissDialog(context);
                                });
                              }
                            }
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(button_radius)),
                          child: Text(
                            signup,
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
    );
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
                  termsBottom('Terms of Services');
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
              termsBottom('Terms of Services');
            },
          ),
        ],
      ),
    );
  }

  void termsBottom(String title) {
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
                        child: Text(loremIpsum,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center),
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
