import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/Firebase/FirebaseNotification.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Screens/ChooseYourWay.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/SizeConfig.dart';

import '../AuthScreens/LoginScreen.dart';

class SplashScreenWithLady extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenWithLadyState();
}

class SplashScreenWithLadyState extends State<SplashScreenWithLady> {
  String _auth = '';

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _moveScreen() {
    if (_auth.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }


 @override
  void initState() {
    super.initState();
    
   FirebaseIn.initNoti(context);
    _loadAuth();  
  }

  

  _loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _auth = (prefs.getString(USER_AUTH) ?? '');
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
                  'assets/images/logo_black.png',
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
