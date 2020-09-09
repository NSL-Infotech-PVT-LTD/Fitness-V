import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class TrainerService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TrainerServiceState();
}

class TrainerServiceState extends State<TrainerService> {
  bool isBodyBuilding = true;
  bool isFitnessStr = false;
  bool isConditioning = false;
  bool isDiet = false;
  bool isContest = false;
  bool isDateSelected1 = false;
  bool isDateSelected2 = false;
  bool isDateSelected3 = false;
  bool isDateSelected4 = false;
  ValueChanged valueChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(padding20, 0, 0, 0),
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
                        personal_trainer,
                        style: TextStyle(fontSize: textSize20),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: .5,
              color: CColor.PRIMARYCOLOR,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                height: SizeConfig.blockSizeVertical * 25,
                child: Stack(children: <Widget>[
                  Positioned(
                    bottom: 6,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset(
                        baseImageAssetsUrl + 'dummy2.png',
                        fit: BoxFit.cover,
                        height: SizeConfig.blockSizeVertical * 25,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    baseImageAssetsUrl + 'popular.svg',
                  ),
                ])),
            Container(
                width: SizeConfig.blockSizeHorizontal * 35,
                padding: EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Farley Willth',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          baseImageAssetsUrl + 'check_circle.svg',
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('7 years experienced', style: TextStyle(fontSize: 10)),
                    Text('1022 Trainees (789 Reviews)',
                        style: TextStyle(fontSize: 10)),
                    Padding(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black12,
                            size: 20,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 10),
                    ),
                  ],
                )),
            Container(
              color: Color(0xffE1E1E1),
              width: SizeConfig.screenWidth,
              height: 50,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Select Services')),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Body building',
                          style: TextStyle(
                            fontFamily: openBold,
                            fontSize: 14,
                          )),
                      Spacer(),
                      Switch(
                        value: isBodyBuilding,
                        onChanged: (value) {
                          setState(() {
                            isBodyBuilding = value;
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
              padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Fitness Strength',
                          style: TextStyle(
                            fontFamily: openBold,
                            fontSize: 14,
                          )),
                      Spacer(),
                      Switch(
                        value: isFitnessStr,
                        onChanged: (value) {
                          setState(() {
                            isFitnessStr = value;
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
              padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Conditioning',
                          style: TextStyle(
                            fontFamily: openBold,
                            fontSize: 14,
                          )),
                      Spacer(),
                      Switch(
                        value: isConditioning,
                        onChanged: (value) {
                          setState(() {
                            isConditioning = value;
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
              padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Diet and Nutrition',
                          style: TextStyle(
                            fontFamily: openBold,
                            fontSize: 14,
                          )),
                      Spacer(),
                      Switch(
                        value: isDiet,
                        onChanged: (value) {
                          setState(() {
                            isDiet = value;
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
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Contest Prep.',
                          style: TextStyle(
                            fontFamily: openBold,
                            fontSize: 14,
                          )),
                      Spacer(),
                      Switch(
                        value: isContest,
                        onChanged: (value) {
                          setState(() {
                            isContest = value;
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
                width: SizeConfig.screenWidth * 80,
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Container(
                  margin: EdgeInsets.only(top: padding15),
                  height: button_height,
                  child: RaisedButton(
                    onPressed: () {
                      _modalBottomSheetMenu();
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(button_radius)),
                    child: Text(
                      "Proceed to Selelct Date & Time",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
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
                        height: 20,
                      ),
                      backWithArrow(context),
                      Container(
                        color: Color(0xffE1E1E1),
                        width: SizeConfig.screenWidth,
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Choose Available Date & Time',
                              style: TextStyle(
                                  color: Color(0xff707070), fontSize: 14),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 15, 40, 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '20 August, 2020',
                                      style: TextStyle(
                                          fontFamily: open_light,
                                          fontSize: 14,
                                          color: Color(0xff707070)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('12.30 PM',
                                        style: TextStyle(
                                            fontFamily: openBold,
                                            fontSize: 12,
                                            color: Color(0xff707070))),
                                  ],
                                ),
                                Spacer(),
                                Checkbox(
                                  value: isDateSelected1,
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isDateSelected1 = value;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '20 August, 2020',
                                      style: TextStyle(
                                          fontFamily: open_light,
                                          fontSize: 14,
                                          color: Color(0xff707070)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('12.30 PM',
                                        style: TextStyle(
                                            fontFamily: openBold,
                                            fontSize: 12,
                                            color: Color(0xff707070))),
                                  ],
                                ),
                                Spacer(),
                                Checkbox(
                                    value: isDateSelected2,
                                    checkColor: Colors.white,
                                    activeColor: Colors.black,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isDateSelected2 = value;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '20 August, 2020',
                                      style: TextStyle(
                                          fontFamily: open_light,
                                          fontSize: 14,
                                          color: Color(0xff707070)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('12.30 PM',
                                        style: TextStyle(
                                            fontFamily: openBold,
                                            fontSize: 12,
                                            color: Color(0xff707070))),
                                  ],
                                ),
                                Spacer(),
                                Checkbox(
                                    value: isDateSelected3,
                                    checkColor: Colors.white,
                                    activeColor: Colors.black,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isDateSelected3 = value;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 50),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '20 August, 2020',
                                      style: TextStyle(
                                          fontFamily: open_light,
                                          fontSize: 14,
                                          color: Color(0xff707070)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('12.30 PM',
                                        style: TextStyle(
                                            fontFamily: openBold,
                                            fontSize: 12,
                                            color: Color(0xff707070))),
                                  ],
                                ),
                                Spacer(),
                                Checkbox(
                                    value: isDateSelected4,
                                    checkColor: Colors.white,
                                    activeColor: Colors.black,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isDateSelected4

                                        = value;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                      fullWidthButton(
                          context,
                          'Proceed',
                          SizeConfig.screenWidth * .9,
                          FontWeight.normal,
                          YourBooking()),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ));
          });
        });
  }
}
