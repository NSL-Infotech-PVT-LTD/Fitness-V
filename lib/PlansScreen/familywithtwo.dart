import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:volt/AuthScreens/LoginScreen.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/PlansScreen/GymMemberPlan.dart';
import 'package:volt/ResponseModel/StatusResponse.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class FamilyWithTwo extends StatefulWidget {
  @override
  _FamilyWithTwoState createState() => _FamilyWithTwoState();
}

class _FamilyWithTwoState extends State<FamilyWithTwo> {
  bool acceptTerms = false;
  double setWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: topMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/two_lady.jpg',
                    width: SizeConfig.screenWidth,
                    height: 234,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Container(
                height: 72,
                width: SizeConfig.screenWidth,
                color: Colors.black,
                padding: EdgeInsets.only(left: padding25),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: Text(
                          fill,
                          style: TextStyle(
                            color: CColor.WHITE,
                            fontSize: textSize18,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          color: Colors.black,
                          padding:
                          EdgeInsets.only(right: padding25, top: padding20),
                          child: Text(
                            couple,
                            style: TextStyle(
                              color: CColor.WHITE,
                              fontSize: textSize10,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.only(right: padding25),
                          child: Text(
                            aed,
                            style: TextStyle(
                              color: CColor.WHITE,
                              fontSize: textSize18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.screenHeight * 0.20,
                        width: SizeConfig.screenWidth * 0.40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 2, ),
                                Text(
                                  'Member#1',
                                  style: TextStyle(
                                    // color: CColor.WHITE,
                                    fontSize: textSize16,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: padding15),
                              height: button_height,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  )),
                              child: RaisedButton(
                                onPressed: () {
                                  // Navigator.push(context, ScaleRoute(page: whereToGO));
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Text(
                                  'Fill Details',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.20,
                        width: SizeConfig.screenWidth * 0.40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 2, ),
                                Text(
                                  'Member#2',
                                  style: TextStyle(
                                    // color: CColor.WHITE,
                                    fontSize: textSize16,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: padding15),
                              height: button_height,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  )),
                              child: RaisedButton(
                                onPressed: () {
                                  // Navigator.push(context, ScaleRoute(page: whereToGO));
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Text(
                                  'Fill Details',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
//                  Container(
//                    margin: EdgeInsets.only(top: padding15),
//                    height: button_height,
//                    width: setWidth,
//                    decoration: BoxDecoration(
//                        border: Border.all(
//                          color: Colors.blueGrey,
//                        )),
//                    child: RaisedButton(
//                      onPressed: () {
//                        // Navigator.push(context, ScaleRoute(page: whereToGO));
//                      },
//                      color: Colors.white,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(0.0)),
//                      child: Text(
//                        'Have Child?',
//                        style: TextStyle(color: Colors.black, fontSize: 16),
//                      ),
//                    ),
//                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.screenHeight * 0.20,
                        width: SizeConfig.screenWidth * 0.40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 2, ),
                                Text(
                                  'Child#1',
                                  style: TextStyle(
                                    // color: CColor.WHITE,
                                    fontSize: textSize18,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: padding15),
                              height: button_height,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  )),
                              child: RaisedButton(
                                onPressed: () {
                                  // Navigator.push(context, ScaleRoute(page: whereToGO));
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Text(
                                  'Fill Details',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.20,
                        width: SizeConfig.screenWidth * 0.40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 2, ),
                                Text(
                                  'Child#2',
                                  style: TextStyle(
                                    // color: CColor.WHITE,
                                    fontSize: textSize18,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: padding15),
                              height: button_height,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  )),
                              child: RaisedButton(
                                onPressed: () {
                                  // Navigator.push(context, ScaleRoute(page: whereToGO));
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Text(
                                  'Fill Details',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: padding10),
                    height: button_height,
                    width: setWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        )),
                    child: RaisedButton(
                      onPressed: () {
                        // Navigator.push(context, ScaleRoute(page: whereToGO));
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Text(
                        'Add Child?',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              checkbox(iaccept, termsofService, acceptTerms),
              Container(
                margin: EdgeInsets.only(top: padding15, left: 20, right: 20),
                height: button_height,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                    )),
                child: RaisedButton(
                  onPressed: () {
                    // Navigator.push(context, ScaleRoute(page: whereToGO));
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: padding15, left: 20, right: 20),
                height: button_height,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                    )),
                child: RaisedButton(
                  onPressed: () {
                    // Navigator.push(context, ScaleRoute(page: whereToGO));
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Text(
                    'Choose Another Plan',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget checkbox(String title, String richTExt, bool boolValue) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                acceptTerms = value;
                if (value) {
                  termsBottom('Terms of Services');
                }
              });
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new RichText(
                text: new TextSpan(
                  text: title,
                  style: TextStyle(fontSize: textSize10, color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: richTExt,
                        style: TextStyle(
                            fontSize: textSize10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ],
                ),
              ),
            ),
            onTap: () {
              termsBottom('Terms of Services');
            },
          ),
        ],
      ),
    );
  }

  void termsBottom(String title) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Container(
                  color: Colors.transparent,
                  //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(50.0),
                              topRight: const Radius.circular(50.0))),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            child: Padding(
                              child: Align(
                                child: Icon(Icons.close),
                                alignment: Alignment.topRight,
                              ),
                              padding: EdgeInsets.all(15),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(loremIpsum,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 25, bottom: 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    baseImageAssetsUrl + 'logo_black.png',
                                    height: 90,
                                    color: Color(0xff8B8B8B),
                                    width: 120,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 25, bottom: 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'vector_lady.svg',
                                    height: 90,
                                    width: 120,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40, bottom: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  volt_rights,
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
                      )),
                ));
          });
        });
  }
}
