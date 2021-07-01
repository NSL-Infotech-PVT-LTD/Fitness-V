import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/AuthScreens/forgot_password.dart';
import 'package:volt/Firebase/FirebaseNotification.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/ResponseModel/StatusResponse.dart';
import 'package:volt/Screens/ChooseYourWay.dart';
import 'package:volt/Screens/SplashScreenWithLady.dart';
import 'package:volt/Screens/view_personal_trainer.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:io';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}
List gym_list;
List pool_and_beach_list;
List guest_list;
List fairMont_list;


Future<StatusResponse> getRoleApi(context,userType) {
  isConnectedToInternet().then((internet) {
    if (internet != null && internet) {
    //  showProgress(context, "Loading....");
      getRoles().then((response) {
        dismissDialog(context);
        if (response.status) {
          gym_list = response.data.gym_members;
          pool_and_beach_list = response.data.pool_and_beach_members;
          guest_list = response.data.local_guest;
          fairMont_list = response.data.fairmont_hotel_guest;
          saveUser(userData,userType == "gym_members"?gym_list:userType == "pool_and_beach_members"?pool_and_beach_list:gym_list);
        } else {
          showDialogBox(context, "Error!", response.error.toString());
        }
      }).whenComplete(() => dismissDialog(context));
    } else {
      showDialogBox(context, internetError, pleaseCheckInternet);
      dismissDialog(context);
    }

    dismissDialog(context);
  });
}

class LoginState extends State<LoginScreen> {

  @override

  void initState() {
    getToken();
  //  FirebaseIn.initNoti(context);
    passwordVisible = true;
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';
    super.initState();
  }

  TextEditingController _emailAddressFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  bool _validate1 = false;
  bool _validate2 = false;
  final _formKey = GlobalKey<FormState>();

  Future<String> getToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken().whenComplete((){
      setString(fireDeviceToken,fcmToken);
      getString(fireDeviceToken).then((value) {
        deviceTok = value;
      });
    });

    print("token device login" + fcmToken.toString());//YY {target_model: Job, target_id: 21, status: processing}
    return fcmToken;
  }
  void login() async {

    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");
        print('Device Token $deviceTok');

        Map<String, String> parms = {
          EMAIL: _emailAddressFieldController.text,
          PASSWORD: _passwordFieldController.text,
          DEVICE_TOKEN: deviceTok!=null?deviceTok:"dfksnfkjdsnkf",
          DEVICE_TYPE: deviceType
        };
        print("device Tok  $parms");
        getLogin(parms).then((response) {

          dismissDialog(context);
          if (response.status) {

          if(response.data.user.role.id != 8 && response.data.user.role.id != 9)  setString(UserFeeType,response.data.user.role.current_plan.fee.toString());
            setString(USER_AUTH, "Bearer " + response.data.token);
            // if (response.data.user.role.current_plan.fee.toString() != null)
            //   setString(UserFeeType,response.data.user.role.current_plan.fee.toString());
            setString(userCurrentRoleID,response.data.user.role.id.toString());
            setString(roleType, response.data.user.role.name);
              getRoleApi(context,response.data.user.role.nameFilter);

            if (response.data != null && response.data.user != null)
              setString(userImage, response.data.user.image);

            if (response.data != null && response.data.user != null)
              setString(id, response.data.user.id.toString());
            print("roleIdCheck" + response.data.user.toJson().toString());

            if (response.data.user.my_sessions != null) {
              setString(mySessions, response.data.user.my_sessions.toString());
            }if (response.data.user.my_sessions != null) {
              setString(trainer_slot, response.data.user.trainer_slot.toString());
            }

            if (response.data.user.role != null) {

              print("roleID "+"${response.data.user.role.id.toString()}");
              setString(roleIdDash, response.data.user.role.id.toString());
              setString(poolOrGym, response.data.user.role.nameFilter);
              setString(userPlanImage, response.data.user.role.image);
              setString(roleName, response.data.user.role.name);
              setString(Id, response.data.user.id.toString());
              if(response.data.user.role.id != 8 && response.data.user.role.id != 9) setString(UserFeeName,response.data.user.role.current_plan.fee_type.toString());//ideal
              setString(validTill, response.data.user.role_expired_on);

              setString(roleCategory, response.data.user.role.category);
              if (response.data.user.role.current_plan != null) {
                setString(rolePlan, response.data.user.role.current_plan.role_plan);
              }
            }

            setString(USER_NAME, response.data.user.full_name);
            Navigator.pushAndRemoveUntil(
                context, ScaleRoute(page: Dashboard(role: response.data.user.role.name,)), (r) => false);
          } else {
            dismissDialog(context);
            if (response.error != null && response.error != "")
              showDialogBox(context, "Error!", response.error.toString());
          }
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }
  bool passwordVisible = true;
  bool _isIos;
  String deviceType = '';
  bool isVisible = false;
  bool isVisiblePass = false;
  String text = "";
  String textPass = "";


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CColor.WHITE,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: SizeConfig.screenHeight,
                  child: Image.asset(
                    'assets/images/splash_boy.png',
                   fit: BoxFit.fill,
                    width: SizeConfig.screenWidth,
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight,
                  child: Image.asset(
                    'assets/images/gredient.png',
                    width: SizeConfig.screenWidth,
                 fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  color: Colors.black54,
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 15),
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: SizeConfig.blockSizeVertical * 20,
                            width: SizeConfig.blockSizeHorizontal * 60,
                            fit: BoxFit.fill,color: Colors.white,
                          ),
                        ),
                        // Text(
                        //   localGuest,
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: textSize16,
                        //       fontFamily: open_light),
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        // Text(
                        //   existingAcc,
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: textSize16,
                        //       fontFamily: open_light),
                        // ),

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
                                    onChanged: (text){
                                      setState(() {
                                        text.isEmpty?isVisible =false:isVisible =true;
                                      });

                                    },
                                    cursorColor: Colors.black,
                                    keyboardType:
                                        TextInputType.emailAddress,
                                    key: new Key('email'),
                                    controller: _emailAddressFieldController,
                                    decoration: new InputDecoration(
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [

                                            Visibility(
                                              visible: _validate1,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.error,
                                                  color: _validate1 ? Colors.red
                                                      : Colors.transparent,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Visibility(
                                              visible: isVisible,
                                              child: IconButton(icon: Icon(Icons.clear,color: Colors.grey,), onPressed:(){
                                                _emailAddressFieldController.clear();
                                                setState(() {
                                                  isVisible = false;
                                                });
                                              } ),
                                            ),
                                          ],
                                        )  ,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15, bottom: 10),
                                        hintText: "Email"),
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
                                    onChanged: (textPass){
                                      setState(() {
                                        textPass.isEmpty?isVisiblePass = false:isVisiblePass = true;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.visiblePassword,
                                       obscureText: passwordVisible,
                          key: new Key('password'),
                          controller: _passwordFieldController,
                          decoration: new InputDecoration(
                    suffixIcon:Row(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Visibility(
                          visible:isVisiblePass,
                          child: IconButton(icon: Icon(Icons.clear,color: Colors.grey,), onPressed:(){
                            _passwordFieldController.clear();
                            setState(() {
                              isVisiblePass = false;
                            });
                          } ),
                        ) ,
                        IconButton(
                          icon: Padding(
                              padding:
                                  EdgeInsets.only(bottom: 10),
                              child: _validate2 ? Icon(Icons.error,
                                      color: Colors.red) : Icon(
                                      // Based on passwordVisible state choose the icon
                                      passwordVisible ? Icons.visibility_off:Icons.visibility ,
                                      color: CColor.DividerCOlor,
                                    )),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ],
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

                        Container(
                          child: RaisedButton(
                            onPressed: () {
                              // print(deviceTok);
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
                                   colors: [
                                    Color(0xff484848),
                                    Color(0xffCCCCCC)
                                  ],
                                ),
                                color: Color(0xff484848),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                               ),
                              child: Text(
                                'Log In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize16,
                                    fontFamily: open_semi_bold),
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        Text(
                          'or',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: textSize16,
                              fontFamily: open_semi_bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: OutlineButton(
                                shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
                              //  borderSide: BorderSide(color: Colors.white),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(
                                    // //  Icons.group,
                                    //   color: Colors.white,
                                    //   size: 20,
                                    // ),
                                    Text(
                                      "Sign Up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ChooseYourWay(isGuest: false,)));
//                                  ilder: (context) => Dashboard()));
                                },
                              ),
                            ),
                          ),
                        ),  Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.black,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: OutlineButton(

                                shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
                             //   borderSide: BorderSide(color: Colors.white),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(
                                    // //  Icons.group,
                                    //   color: Colors.white,
                                    //   size: 20,
                                    // ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                    Text(
                                      continueAsGuest,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute( builder: (context) => ChooseYourWay(isGuest: true,)));
//                                  ilder: (context) => Dashboard()));
                                },
                              ),
                            ),
                          ),
                        ),
//                             Padding(
//                               padding: const EdgeInsets.only(top:20.0),
//                               child: SizedBox(
//                                 height: MediaQuery.of(context).size.height * 0.07,
//                                 width: MediaQuery.of(context).size.width * 0.50,
//                                 child: OutlineButton(
//                                   shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
//                                   borderSide: BorderSide(color: Colors.white),
//                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       // Icon(
//                                       //   Icons.group,
//                                       //   color: Colors.white,
//                                       //   size: 20,
//                                       // ),
//                                       SizedBox(width: MediaQuery.of(context).size.width * 0.03),
//                                       Text(
//                                         continueAsGuest,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                   onPressed: () {
//                                     Navigator.pushReplacement(
//                                         context,
//                                         new MaterialPageRoute(
//                                             builder: (context) => ChooseYourWay(isGuest: true,)));
// //                                  ilder: (context) => Dashboard()));
//                                   },
//                                 ),
//                               ),
//                             ),
                      ],
                    )),
              ],
            ),
          ]),
        ));
  }
}
