import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods.dart';
import 'package:volt/NotificationsScreens/Notification.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: topMargin,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    baseImageAssetsUrl + 'logo_black.png',
                    width: 60,
                    height: 30,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ))
                ],
              ),
            ),
            Container(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: SvgPicture.asset(
                      baseImageAssetsUrl + 'horizontal.svg',
                      width: SizeConfig.screenWidth,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 15,
                    child: Image.asset(
                      baseImageAssetsUrl + 'circleuser.png',
                      height: 105,
                      width: 105,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Firley Willth',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Color(0xff8B8B8B), fontSize: textSize20),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 30,
                    width: 95,
                    child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Edit Details',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff8B8B8B), fontSize: 12),
                        ))),
                Icon(
                  Icons.edit,
                  size: 20,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: InkWell(

                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => Dashboard()));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'home.svg'),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Dashboard',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  )),
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(baseImageAssetsUrl + 'new.svg'),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'My Profile',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff8B8B8B), fontSize: 16),
                      ))
                ],
              ),
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'speaker.svg'),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Notification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  )),
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(baseImageAssetsUrl + 'tick.svg'),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Calendar & Booking',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff8B8B8B), fontSize: 16),
                      ))
                ],
              ),
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(baseImageAssetsUrl + 'invoice.svg'),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Instructor Policies',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff8B8B8B), fontSize: 16),
                      ))
                ],
              ),
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(baseImageAssetsUrl + 'headphones.svg'),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Contact & About VOLT',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff8B8B8B), fontSize: 16),
                      ))
                ],
              ),
            ),
            myDivider(),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  baseImageAssetsUrl + 'logo_black.png',
                  height: 60,
                  color: Color(0xff8B8B8B),
                  width: 100,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, bottom: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'VOLT FIRNESS @2019 ALL RIGHT RESERVED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff8B8B8B),
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                        fontFamily: open_italic),
                  )),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
