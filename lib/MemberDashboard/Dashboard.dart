import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/MemberDashboard/DashboardChild/Cardio.dart';
import 'package:volt/MemberDashboard/DashboardChild/Home.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/NotificationsScreens/Notification.dart';
import 'package:volt/Screens/ProfileScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:volt/changes.dart';
import 'package:volt/util/custom_dashboard_appbar.dart';

import '../Methods.dart';

class  Dashboard extends StatefulWidget {
  final role;

  Dashboard({this.role});

  @override

  State<StatefulWidget> createState() => DashboardState();
  static DashboardState of(BuildContext context) => context.findAncestorStateOfType<DashboardState>();
}


class DashboardState extends State<Dashboard> {

  int _currentIndex = 0;
  var imageValue;
  var roleValue;
  var _id;
  bool load = true;
  List<Widget> _children = [];

  void onTabTapped(int index) {

      _currentIndex = index;
      print("_currentIndex $_currentIndex");
      setState(() {

      });

  }

  set onTabTappedNew(int index) {


      _currentIndex = index;
      print("_currentIndejnjjx $_currentIndex");
      setState(() {
      });


  }

  var roleId ;

  @override
  void initState() {
    getString(userImage)
        .then((value) => {imageValue = value})
        .whenComplete(() => setState(() {

    }));

    getString(Id)
        .then((value) => {_id = value})
        .whenComplete(() => setState(() {}));

    getString(roleName)
        .then((value) => {roleValue = value})
        .whenComplete(() => setState(() {}));


    getString(roleIdDash).then((value) => roleId = value.toString()).whenComplete((){
      setState(() {
        load = false;
        if (roleId == '8') {
          _children = [load?Center(child: CircularProgressIndicator(backgroundColor: Colors.black,)):Home(image: imageValue,roleId: roleId,), EventClass()];
        } else {
          _children = [load?Center(child: CircularProgressIndicator(backgroundColor: Colors.black,)):Home(image: imageValue,roleId: roleId,), Cardio(), EventClass()];
        }
      });
    });
    // getString()
    //     .then((value) => {roleId = value})
    //     .whenComplete(() => setState(() {
    //   load = false;
    //       print("check role id" + roleId.toString());
    // }));

    super.initState();
  }

  Future<bool> _willPopCallback() async {
    exitFromApp(context);
    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    imageValue = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
    getString(userImage)
        .then((value) => {imageValue = value})
        .whenComplete(() => setState(() {}));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("_currentIndex $imageValue");
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: load?Center(child: CircularProgressIndicator(),):Scaffold(
          backgroundColor: CColor.WHITE,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped ,
            items:  roleId == "8"?
            <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? new SvgPicture.asset(
                  baseImageAssetsUrl + 'home_dark.svg',
                  height: 20,
                  width: 20,
                )
                    : new SvgPicture.asset(
                  baseImageAssetsUrl + 'in_home.svg',
                  height: 20,
                  width: 20,
                ),
                // ignore: deprecated_member_use
                title: new Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _currentIndex == 0
                        ? Text('Home',
                        style: TextStyle(
                            fontSize: textSize10,
                            color: Colors.black,
                            fontWeight: FontWeight.w600))
                        : Text(
                      'Home',
                      style: TextStyle(fontSize: textSize10),
                    )),
              ),
              BottomNavigationBarItem(
                  icon: _currentIndex == 1
                      ? SvgPicture.asset(baseImageAssetsUrl + 'cardio.svg',
                      height: 20, width: 20)
                      : new SvgPicture.asset(
                    baseImageAssetsUrl + 'in_cardio.svg',
                    height: 20,
                    width: 20,
                  ),
                  // ignore: deprecated_member_use
                  title: new Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: _currentIndex == 1
                          ? Text(
                        'Events',
                        style: TextStyle(
                            fontSize: textSize10,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )
                          : Text(
                        'Events',
                        style: TextStyle(fontSize: textSize10),
                      )))
            ]:<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? new SvgPicture.asset(
                        baseImageAssetsUrl + 'home_dark.svg',
                        height: 20,
                        width: 20,
                      )
                    : new SvgPicture.asset(
                        baseImageAssetsUrl + 'in_home.svg',
                        height: 20,
                        width: 20,
                      ),
                // ignore: deprecated_member_use
                title: new Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _currentIndex == 0
                        ? Text('Home',
                            style: TextStyle(
                                fontSize: textSize10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                        : Text(
                            'Home',
                            style: TextStyle(fontSize: textSize10),
                          )),
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? new SvgPicture.asset(baseImageAssetsUrl + 'trainer.svg',
                        height: 20, width: 20)
                    : new SvgPicture.asset(
                        baseImageAssetsUrl + 'in_trainer.svg',
                        height: 20,
                        width: 20,
                      ),
                // ignore: deprecated_member_use
                title: new Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _currentIndex == 1
                        ? Text('Trainer',
                            style: TextStyle(
                                fontSize: textSize10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                        : Text(
                            'Trainer',
                            style: TextStyle(fontSize: textSize10),
                          )),
              ),
              BottomNavigationBarItem(
                  icon: roleId == "8" || roleId == "9"
                      ? new SvgPicture.asset(
                          baseImageAssetsUrl + 'in_cardio.svg',
                          height: 20,
                          width: 20,
                        )
                      : _currentIndex == 2
                          ? SvgPicture.asset(baseImageAssetsUrl + 'cardio.svg',
                              height: 20, width: 20)
                          : new SvgPicture.asset(
                              baseImageAssetsUrl + 'in_cardio.svg',
                              height: 20,
                              width: 20,
                            ),
                  // ignore: deprecated_member_use
                  title: new Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: roleId == "8" || roleId == "9"
                          ? Text(
                              'Events',
                              style: TextStyle(fontSize: textSize10),
                            )
                          : _currentIndex == 2
                              ? Text(
                                  'Events',
                                  style: TextStyle(
                                      fontSize: textSize10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  'Events',
                                  style: TextStyle(fontSize: textSize10),
                                )))
            ],
          ),
          appBar: CustomAppBar(
            height: 140,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: topMargin40,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _navigateAndDisplaySelection(context);
                        },
                        child: imageValue == null
                            ? SvgPicture.asset(
                                baseImageAssetsUrl + 'place_holder.svg',
                                height: 40,
                                width: 40,
                              )
                            :


                        CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    BASE_URL + 'uploads/image/' + imageValue),
                                backgroundColor: Colors.transparent,
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        baseImageAssetsUrl + 'logo.png',
                        width: 75,
                        height: 45,
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => NotificationScreen()));
                          },
                          child: SvgPicture.asset(baseImageAssetsUrl + 'noti_dot.svg'))
                    ],
                  ),
                ),
                Divider(
                  height: .5,
                  // color: CColor.PRIMARYCOLOR,
                ),
              ],
            ),
          ),
          body: roleId == "8" || roleId == "9" ? Container(child: _children[_currentIndex],): _currentIndex == 2 ? Container(child: _children[_currentIndex],) : SingleChildScrollView(
            child: Column(children: <Widget>[
              _children[_currentIndex],
              //footer(),
               //   Spacer(),
              // Padding(
              //   padding: EdgeInsets.only(left: 25, bottom: 0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: SvgPicture.asset(
              //       baseImageAssetsUrl + 'vector_lady.svg',
              //       height: 90,
              //       width: 120,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 20,
              // ),

              // SizedBox(
              //   height: 50,
              // )
            ]),
          )
      ),
    );
  }
}
