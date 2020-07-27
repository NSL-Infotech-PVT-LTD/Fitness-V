import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volt/Screens/SplashScreenWithLady.dart';

import 'Value/CColor.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'regular',  
        primaryColor: CColor.PRIMARYCOLOR,

        accentColor:CColor.PRIMARYCOLOR,
      ),
      home: SplashScreenWithLady(),
    );
  }
}