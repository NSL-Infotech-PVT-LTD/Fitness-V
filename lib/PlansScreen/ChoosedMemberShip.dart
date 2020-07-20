import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class ChooseMemberShip extends StatefulWidget {
  var response;

  ChooseMemberShip({this.response});

  @override
  State<StatefulWidget> createState() => ChooseMemberShipState();
}

class ChooseMemberShipState extends State<ChooseMemberShip> {
  int currentSelectedIndex = -1;
  bool isSwitchedAnual = true;
  bool isSwitchedMonthly = false;
  bool isSwitched3Months = false;
  bool isSwitched6Months = false;
  int plan_index = 0;

  void changeState() {
    isSwitchedAnual = false;
    isSwitchedMonthly = false;
    isSwitched3Months = false;
    isSwitched6Months = false;
  }

  List<PlansDetails> plansList;
  List limit;

  @override
  Widget build(BuildContext context) {
    limit = widget.response['plan_detail'];

    plansList = new List<PlansDetails>();

    for (int i = 0; i < limit.length; i++) {
      plansList.add(PlansDetails(
          fee_type: limit[i]['fee_type'],
          fee: limit[i]['fee'].toString(),
          choosePlan: false));
    }

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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemCount: plansList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          plan_index = index;

                          setState(() {
                            currentSelectedIndex = index;
//                            plansList.forEach(
//                                (element) => element.choosePlan = false);
//                            plansList[index].choosePlan = true;
                          });
                        },
                        child: CustomPlansDetails(
                          items: plansList,
                          index: index,
                          myValue: currentSelectedIndex == index,
                        ));
                  },
                ),
              ),
//              Container(
//                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
//                child: Column(
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              anual,
//                              style: TextStyle(
//                                  fontFamily: open_light, fontSize: 14),
//                            ),
//                            SizedBox(
//                              height: 3,
//                            ),
//                            Text('3600 AED',
//                                style: TextStyle(
//                                    fontFamily: openBold,
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.bold)),
//                          ],
//                        ),
//                        Spacer(),
//                        Switch(
//                          value: isSwitchedAnual,
//                          onChanged: (value) {
//                            setState(() {
//                              changeState();
//                              isSwitchedAnual = value;
//                            });
//                          },
//                          activeTrackColor: Colors.black26,
//                          activeColor: Colors.black,
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
//                child: Column(
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              months6,
//                              style: TextStyle(
//                                  fontFamily: open_light, fontSize: 14),
//                            ),
//                            SizedBox(
//                              height: 3,
//                            ),
//                            Text('2400 AED',
//                                style: TextStyle(
//                                    fontFamily: openBold,
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.bold)),
//                          ],
//                        ),
//                        Spacer(),
//                        Switch(
//                          value: isSwitched6Months,
//                          onChanged: (value) {
//                            setState(() {
//                              changeState();
//                              isSwitched6Months = value;
//                            });
//                          },
//                          activeTrackColor: Colors.black26,
//                          activeColor: Colors.black,
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
//                child: Column(
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              months3,
//                              style: TextStyle(
//                                  fontFamily: open_light, fontSize: 14),
//                            ),
//                            SizedBox(
//                              height: 3,
//                            ),
//                            Text('1500 AED',
//                                style: TextStyle(
//                                    fontFamily: openBold,
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.bold)),
//                          ],
//                        ),
//                        Spacer(),
//                        Switch(
//                          value: isSwitched3Months,
//                          onChanged: (value) {
//                            setState(() {
//                              changeState();
//                              isSwitched3Months = value;
//                            });
//                          },
//                          activeTrackColor: Colors.black26,
//                          activeColor: Colors.black,
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.fromLTRB(40, 15, 40, 30),
//                child: Column(
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              monthly,
//                              style: TextStyle(
//                                  fontFamily: open_light, fontSize: 14),
//                            ),
//                            SizedBox(
//                              height: 3,
//                            ),
//                            Text('700 AED',
//                                style: TextStyle(
//                                    fontFamily: openBold,
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.bold)),
//                          ],
//                        ),
//                        Spacer(),
//                        Switch(
//                          value: isSwitchedMonthly,
//                          onChanged: (value) {
//                            setState(() {
//                              changeState();
//                              isSwitchedMonthly = value;
//                            });
//                          },
//                          activeTrackColor: Colors.black26,
//                          activeColor: Colors.black,
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
              Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    margin: EdgeInsets.only(top: padding15),
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: RaisedButton(
                      onPressed: () {
                        currentSelectedIndex == -1
                            ? showDialogBox(context, "Choose Plan Alert",
                                'Please choose your plan type')
                            : Navigator.push(
                                context,
                                ScaleRoute(
                                    page: SignupScreen(
                                  response: widget.response['plan_detail'],
                                  plan_index: plan_index,
                                  type: "member",
                                )));
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(button_radius)),
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  )

//                fullWidthButton(
//                context,
//                'Proceed',
//                SizeConfig.screenWidth,
//                FontWeight.bold,
//              )

                  ),
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

class PlansDetails {
  final String fee_type;
  final String fee;
  bool choosePlan;

  PlansDetails({this.fee_type, this.fee, this.choosePlan});
}

class CustomPlansDetails extends StatefulWidget {
  final List items;
  final int index;
  bool myValue;

  CustomPlansDetails({Key key, @required this.items, this.index, this.myValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PlansState();
}

class PlansState extends State<CustomPlansDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 25),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.items[widget.index].fee_type,
                    style: TextStyle(fontFamily: open_light, fontSize: 14),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(widget.items[widget.index].fee + ' AED',
                      style: TextStyle(
                          fontFamily: openBold,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Spacer(),

              Container(
                height: 20.0,
                width: 20.0,
                decoration: new BoxDecoration(
//                  color: widget.myValue ? Colors.black : Colors.transparent,
                  image: DecorationImage(
                      image: widget.myValue
                          ? AssetImage(
                              baseImageAssetsUrl + 'tick.png',
                            )
                          : AssetImage(baseImageAssetsUrl + '')),

                  border: new Border.all(
                      width: 1.0,
                      color: widget.myValue ? Colors.transparent : Colors.grey),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(2.0)),
                ),
              ),
//              Switch(
//                value: widget.myValue,
//                activeTrackColor: Colors.black26,
//                activeColor: Colors.black,
//                onChanged: (bool value) {
//                  setState(() {
//
//
////                    for (int i = 0; i < widget.items.length; i++) {
////                      if (widget.index == i) {
////                        widget.items[widget.index].choosePlan = value;
////                      } else {
////                        widget.items[i].choosePlan = false;
////                      }
////                    }
//                  });
//                },
//              ),
            ],
          )
        ],
      ),
    );
  }
}
