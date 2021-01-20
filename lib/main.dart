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

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  int _bottomNavBarSelectedText = 0;
  bool _newNotification = false;

  void _navigateToItemDetail() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (values) => AllBookings()));
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text("This is a notification"),
          actions: <Widget>[
            TextButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (values) => AllBookings(),
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showMyDialog();

        print("NOTIFICATION ARRIVED");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail();
      },
    );
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      navigatorKey: navigatorKey,
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
