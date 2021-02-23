import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Firebase/FirebaseNotification.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Screens/ChooseYourWay.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'SplashScreenWithLady.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {

  @override
  void initState() {
    FirebaseIn.initNoti(context);
    getString(fireDeviceToken).then((value) {
      deviceTok = value;
      print("device tok"+deviceTok);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChooseYourWay(isGuest: true,))));
         //   context, MaterialPageRoute(builder: (context) => ChooseYourWay())));
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/splash_boy.png',
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/gredient.png',
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: SizeConfig.blockSizeVertical * 25,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/logo_white.png',
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
                    progressColor: Colors.black,
                    backgroundColor: Colors.white,
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
