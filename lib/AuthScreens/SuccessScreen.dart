import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/AuthScreens/LoginScreen.dart';
import 'package:volt/Screens/ChooseYourWay.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class SuccessScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SuccessState();
}

class SuccessState extends State<SuccessScreen> {
  Future<bool> _onWillPop() async {
    return (await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ChooseYourWay()),
          (r) => false,
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: Column(
          children: <Widget>[


                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/two_lady.jpg',
                      width: SizeConfig.screenWidth,
                      height: 234,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Registration Successfully Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Kindly check your email for payment',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: finishAllScreenButton(
                            context,
                            'Back to Home'.toUpperCase(),
                            SizeConfig.screenWidth,
                            FontWeight.bold,
                            ChooseYourWay())),
                    Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                        child: fullWidthButton(
                            context,
                            'Login'.toUpperCase(),
                            SizeConfig.screenWidth,
                            FontWeight.bold,
                            LoginScreen()))

              ],
            ),
          ],
        )));
  }
}
