import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/AuthScreens/forgot_password.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  TextEditingController _emailAddressFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  bool _validate1 = false;
  bool _validate2 = false;
  final _formKey = GlobalKey<FormState>();

  void login() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        Map<String, String> parms = {
          EMAIL: _emailAddressFieldController.text,
          PASSWORD: _passwordFieldController.text,
          DEVICE_TOKEN: deviceTokenValue,
          DEVICE_TYPE: deviceType
        };
        getLogin(parms).then((response) {
          dismissDialog(context);
          if (response.status) {
            setString(USER_AUTH, "Bearer " + response.data.token);
            setString(roleType, response.data.user.role.name);
            if (response.data != null && response.data.user != null)
              setString(userImage, response.data.user.image);

            setString(
                USER_NAME,
                response.data.user.full_name);
            Navigator.pushAndRemoveUntil(
                context, ScaleRoute(page: Dashboard()), (r) => false);
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

  bool passwordVisible = true;
  bool _isIos;
  String deviceType = '';

  @override
  void initState() {
    passwordVisible = true;
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: CColor.WHITE,
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/splash_boy.png',
                      fit: BoxFit.cover,
                      width: SizeConfig.screenWidth,
                    ),
                    Image.asset(
                      'assets/images/gredient.png',
                      width: SizeConfig.screenWidth,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: SizeConfig.screenHeight,
                      width: SizeConfig.screenWidth,
                      color: Colors.black54,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 20),
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                              child: Image.asset(
                                'assets/images/logo_white.png',
                                height: SizeConfig.blockSizeVertical * 20,
                                width: SizeConfig.blockSizeHorizontal * 60,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              localGuest,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize16,
                                  fontFamily: open_light),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              existingAcc,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize16,
                                  fontFamily: open_light),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(bottom: 3),
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white10,
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        key: new Key('email'),
                                        controller:
                                            _emailAddressFieldController,
                                        decoration: new InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                Icons.error,
                                                color: _validate1
                                                    ? Colors.red
                                                    : Colors.transparent,
                                              ),
                                              onPressed: () {},
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            hintText: userName),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.only(bottom: 15),
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white10,
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    baseImageAssetsUrl + 'lock.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: passwordVisible,
                                        key: new Key('password'),
                                        controller: _passwordFieldController,
                                        decoration: new InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: _validate2
                                                    ? Icon(Icons.error,
                                                        color: Colors.red)
                                                    : Icon(
                                                        // Based on passwordVisible state choose the icon
                                                        passwordVisible
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color:
                                                            CColor.DividerCOlor,
                                                      )),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                passwordVisible =
                                                    !passwordVisible;
                                              });
                                            },
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, bottom: 13, top: 12),
                                          hintText: password,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: Text(
                                    forgetPassword,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            Container(
                              child: RaisedButton(
                                onPressed: () {
                                  if (_emailAddressFieldController
                                      .text.isEmpty) {
                                    setState(() {
                                      _validate1 = true;
                                    });
                                  } else if (_passwordFieldController
                                      .text.isEmpty) {
                                    setState(() {
                                      _validate1 = false;
                                      _validate2 = true;
                                    });
                                  } else {
                                    _validate1 = false;
                                    _validate2 = false;
                                    login();
                                  }
                                },
                                color: Color(0xff484848),
                                padding: EdgeInsets.all(0.0),
                                textColor: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.only(top: 15),
                                  height: 50.0,
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xff484848),
                                        Color(0xffCCCCCC)
                                      ],
                                    ),
                                    color: Color(0xff484848),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textSize16,
                                        fontFamily: open_semi_bold),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.group,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    'Guest Menu',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              onPressed: () {
//
//                                  ilder: (context) => Dashboard()));
                              },
                            )
                          ],
                        )),
                  ],
                ),
              ])),
        ));
  }
}
