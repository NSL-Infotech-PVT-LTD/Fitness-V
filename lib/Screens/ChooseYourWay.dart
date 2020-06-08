import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volt/PlansScreen/GymMemberPlan.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class ChooseYourWay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChooseWayState();
}

class ChooseWayState extends State<ChooseYourWay> {
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
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
//                  Positioned(
//                    top: 0,
//                    bottom: 0,
//                    left: 0,
//                    right: 0,
//                    child: Image.asset(
//                      'assets/images/logo_black.png',
//                      width: 300,
//                      height: 76,
//                    ),
//                  )
                ],
              ),
              Container(
                height: 72,
                width: SizeConfig.screenWidth,
                color: Colors.black,
                padding: EdgeInsets.only(left: padding25),
                child: Align(
                  child: Text(
                    chooseYourWay,
                    style: TextStyle(
                      color: CColor.WHITE,
                      fontSize: textSize18,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        color: CColor.WHITE,
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.only(left: padding15),
                          width: SizeConfig.screenWidth,
                          child: TabBar(
                            tabs: [
                              Tab(
                                  icon: Text(
                                memeber,
                                style: TextStyle(fontSize: textSize16),
                              )),
                              Tab(
                                  icon: Text(guest,
                                      style: TextStyle(fontSize: textSize16))),
                            ],
                            isScrollable: true,
                            indicatorColor: Colors.black,
                            labelColor: Color(0xFF474747),
                            unselectedLabelColor: Color(0xFFC1C1C1),
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        child: TabBarView(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  GymMemberPlan()));
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy.png',
                                        "Gym Member",
                                        "(Gym, Personal Training, Group Fitness and more)")),
                                Divider(
                                  height: 2,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  GymMemberPlan()));
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy.png',
                                        "Pole & Beaches",
                                        "(Only Gym Members)")),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen()));
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy.png',
                                        "Guest",
                                        "")),
                                Divider(
                                  height: 2,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen()));
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy.png',
                                        "Fairmont Hotel Guest",
                                        "")),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _CommonView(String image, String title, String des) => GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      image,
                      width: 76,
                      fit: BoxFit.cover,
                      height: 76,
                    )),
                new Container(
                  width: SizeConfig.blockSizeHorizontal * 50,
                  padding: const EdgeInsets.only(left: padding25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          des,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
        padding: EdgeInsets.all(padding30),
      ),
    );
