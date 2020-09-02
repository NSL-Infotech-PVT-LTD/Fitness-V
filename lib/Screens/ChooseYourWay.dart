import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class ChooseYourWay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChooseWayState();
}

class ChooseWayState extends State<ChooseYourWay> {
  List gym_list;
  List pool_and_beach_list;
  List guest_list;
  List fairMont_list;

  @override
  void initState() {
    getRoleApi(context);
    super.initState();
  }

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
                                      gym_list != null
                                          ? Navigator.push(
                                              context,
                                              SizeRoute(
                                                  page: GymMemberPlan(
                                                      response: gym_list)))
                                          : showMyDialog(context, 'Error!',
                                              "Due to some reason couldn't load your data, sorry for inconvenience please press Ok to refresh");
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy2.png',
                                        "Gym Member",
                                        "(Gym, Personal Training, Group Fitness and more)")),
                                Divider(
                                  height: 2,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      pool_and_beach_list != null
                                          ? Navigator.push(
                                              context,
                                              SizeRoute(
                                                  page: GymMemberPlan(
                                                      response:
                                                          pool_and_beach_list)))
                                          : showMyDialog(context, 'Error!',
                                              "Due to some reason couldn't your data, sorry for inconvenience please press Ok to refresh");
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy.png',
                                        "Pool & Beaches",
                                        "(Only Gym Members)")),
                                Divider(
                                  height: 2,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      guest_list != null
                                          ? Navigator.push(
                                              context,
                                              SizeRoute(
                                                  page: SignupScreen(
                                                response: guest_list,
                                                type: 'guest',
                                                formType: "",
                                                isSingle: true,
                                              )))
                                          : showMyDialog(context, 'Error!',
                                              "Due to some reason couldn't your data, sorry for inconvenience please press Ok to refresh");
                                    },
                                    child: _CommonView(
                                        'assets/images/dummy1.png',
                                        "Guest",
                                        "")),
                                Divider(
                                  height: 2,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      fairMont_list != null
                                          ? Navigator.push(
                                              context,
                                              SizeRoute(
                                                  page: SignupScreen(
                                                response: fairMont_list,
                                                type: 'guest',
                                                formType: "",
                                                isSingle: true,
                                              )))
                                          : showMyDialog(context, 'Error!',
                                              "Due to some reason couldn't your data, sorry for inconvenience please press Ok to refresh");
                                    },
                                    child: _CommonView(
                                        'assets/images/fairmont.jpg',
                                        fairmontHotel,
                                        "")),
                                Divider(
                                  height: 2,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Center(
                  child: Text(
                'Already Registered?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              )),
              Center(
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, ScaleRoute(page: LoginScreen()));
                    },
                    child: Text(
                      login,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<StatusResponse> getRoleApi(context) {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Loading....");
        getRoles().then((response) {
          dismissDialog(context);
          if (response.status) {
            gym_list = response.data.gym_members;
            pool_and_beach_list = response.data.pool_and_beach_members;
            guest_list = response.data.local_guest;
            fairMont_list = response.data.fairmont_hotel_guest;
          } else {
            //need to change
            showDialogBox(context, "Error!", response.error);
          }
        }).whenComplete(() => dismissDialog(context));
      } else {
        showDialogBox(context, 'Internet Error', pleaseCheckInternet);
        dismissDialog(context);
      }

      dismissDialog(context);
    });
  }

  void showMyDialog(context, String title, String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text(message,style: TextStyle(wordSpacing: 1),),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context, SizeRoute(page: ChooseYourWay()));
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });
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
