import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/Firebase/FirebaseNotification.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Screens/ChooseYourWay.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/SizeConfig.dart';

import '../AuthScreens/LoginScreen.dart';
import '../main.dart';
String deviceTok='';
class SplashScreenWithLady extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenWithLadyState();
}

class SplashScreenWithLadyState extends State<SplashScreenWithLady> {
  static String auth = '';

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _moveScreen() {
    if (auth.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  Future<String> getToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken().whenComplete((){
      setString(fireDeviceToken,fcmToken);
      getString(fireDeviceToken).then((value) {
        deviceTok = value;
      });
    });
    print("token device " + fcmToken.toString());//YY {target_model: Job, target_id: 21, status: processing}
    return fcmToken;
  }
  @override
  void initState() {

  //  FirebaseIn.initNoti(context);
    getString(fireDeviceToken).then((value) {
      deviceTok = value;
   //   print("device tok"+deviceTok);
    });
    super.initState();
    _loadAuth();
  }

  _loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      auth = (prefs.getString(USER_AUTH) ?? '');
      _timer = Timer(Duration(seconds: 3), () => _moveScreen());
    });
  }
  Timer _timer;


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/splash_lady.png',
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: SizeConfig.blockSizeVertical * 10,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 112,
                  width: 192,
                ),
              ),
              Positioned(
                bottom: 50,
                left: SizeConfig.blockSizeHorizontal * 25,
                right: SizeConfig.blockSizeHorizontal * 25,
                child: Center(
                  child: new LinearPercentIndicator(
                    animation: true,
                    width: SizeConfig.blockSizeHorizontal * 50,
                    lineHeight: 5.0,
                    animationDuration: 2000,
                    percent: 1.0,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
