import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volt/Bookings/all_bookings.dart';
import 'package:volt/Screens/SplashScreenWithLady.dart';

import 'Value/CColor.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
    //  navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'regular',
        primaryColor: CColor.PRIMARYCOLOR,
        sliderTheme: SliderTheme.of(context).copyWith(
          thumbColor: Color(0xFFEB1555),
          inactiveTrackColor: Color(0xFF8D8E98),
          activeTrackColor: Colors.white,
          overlayColor: Color(0x99EB1555),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
        ),
        accentColor: CColor.PRIMARYCOLOR,
      ),
      home: SplashScreenWithLady(),
    );
  }
}
