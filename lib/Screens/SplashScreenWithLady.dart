import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:volt/Screens/SplashScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/SizeConfig.dart';

class SplashScreenWithLady extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenWithLadyState();
}

class SplashScreenWithLadyState extends State<SplashScreenWithLady> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen())));
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
