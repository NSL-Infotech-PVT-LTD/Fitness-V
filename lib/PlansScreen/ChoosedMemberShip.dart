import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Methods.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class ChooseMemberShip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChooseMemberShipState();
}

class ChooseMemberShipState extends State<ChooseMemberShip> {
  bool isSwitchedAnual = true;
  bool isSwitchedMonthly = false;
  bool isSwitched3Months = false;
  bool isSwitched6Months = false;

  void changeState() {
    isSwitchedAnual = false;
    isSwitchedMonthly = false;
    isSwitched3Months = false;
    isSwitched6Months = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: topMargin40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.fromLTRB(padding20, padding10, padding20, 0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Choose Plan Type',
                        style: TextStyle(fontSize: textSize20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: padding50),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 60,
                  height: 1,
                  child: Divider(
                    height: 2,
                    color: Color(0xFF171515),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 60, right: 60),
                child: Text(
                    'Selection of one plan Atleast is importantto proceed in Gym Membership.',
                    style: TextStyle(fontSize: textSize10, color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      baseImageAssetsUrl + 'gym.png',
                      height: 225,
                      width: SizeConfig.screenWidth,
                      fit: BoxFit.fill,
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              anual,
                              style: TextStyle(
                                  fontFamily: open_light, fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text('3600 AED',
                                style: TextStyle(
                                    fontFamily: openBold,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Switch(
                          value: isSwitchedAnual,
                          onChanged: (value) {
                            setState(() {
                              changeState();
                              isSwitchedAnual = value;
                            });
                          },
                          activeTrackColor: Colors.black26,
                          activeColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              months6,
                              style: TextStyle(
                                  fontFamily: open_light, fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text('2400 AED',
                                style: TextStyle(
                                    fontFamily: openBold,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Switch(
                          value: isSwitched6Months,
                          onChanged: (value) {
                            setState(() {
                              changeState();
                              isSwitched6Months = value;
                            });
                          },
                          activeTrackColor: Colors.black26,
                          activeColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              months3,
                              style: TextStyle(
                                  fontFamily: open_light, fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text('1500 AED',
                                style: TextStyle(
                                    fontFamily: openBold,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Switch(
                          value: isSwitched3Months,
                          onChanged: (value) {
                            setState(() {
                              changeState();
                              isSwitched3Months = value;
                            });
                          },
                          activeTrackColor: Colors.black26,
                          activeColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 15, 40, 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              monthly,
                              style: TextStyle(
                                  fontFamily: open_light, fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text('700 AED',
                                style: TextStyle(
                                    fontFamily: openBold,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Switch(
                          value: isSwitchedMonthly,
                          onChanged: (value) {
                            setState(() {
                              isSwitchedMonthly = value;
                            });
                          },
                          activeTrackColor: Colors.black26,
                          activeColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: fullWidthButton(context, 'Proceed',
                      SizeConfig.screenWidth, FontWeight.bold, SignupScreen())),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
