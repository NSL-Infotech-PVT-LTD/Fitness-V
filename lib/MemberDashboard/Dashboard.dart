import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/MemberDashboard/DashboardChild/Cardio.dart';
import 'package:volt/MemberDashboard/DashboardChild/Event/Event.dart';
import 'package:volt/MemberDashboard/DashboardChild/Home.dart';
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

import 'GroupClassses.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  var imageValue;
  final List<Widget> _children = [Home(), Cardio(), EventClass()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    getString(userImage)
        .then((value) => {imageValue = value})
        .whenComplete(() => setState(() {}));
    super.initState();
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    imageValue = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
    getString(userImage)
        .then((value) => {imageValue = value})
        .whenComplete(() => setState(() {}));

    print(imageValue.toString() + "jugraj---------");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: CColor.WHITE,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: <BottomNavigationBarItem>[
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
                icon: _currentIndex == 2
                    ? SvgPicture.asset(baseImageAssetsUrl + 'cardio.svg',
                        height: 20, width: 20)
                    : new SvgPicture.asset(
                        baseImageAssetsUrl + 'in_cardio.svg',
                        height: 20,
                        width: 20,
                      ),
                title: new Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _currentIndex == 2
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
                          ? Image.asset(
                        baseImageAssetsUrl + 'circleuser.png',
                        height: 40,
                        width: 40,
                      )
                          : CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            BASE_URL + 'uploads/image/' + imageValue),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => GroupClasses()));
                      },
                      child: Image.asset(
                        baseImageAssetsUrl + 'logo_black.png',
                        width: 60,
                        height: 30,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      NotificationScreen()));
                        },
                        child: SvgPicture.asset(
                            baseImageAssetsUrl + 'noti_dot.svg'))
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
        body: _currentIndex == 2
            ? Container(
                child: _children[_currentIndex],
              )
            : SingleChildScrollView(
                child: Column(children: <Widget>[
//                  SizedBox(
//                    height: topMargin40,
//                  ),
//                  Container(
//                    padding: EdgeInsets.all(20),
//                    child: Row(
//                      children: <Widget>[
//                        GestureDetector(
//                          onTap: () {
//                            _navigateAndDisplaySelection(context);
//                          },
//                          child: imageValue == null
//                              ? Image.asset(
//                                  baseImageAssetsUrl + 'circleuser.png',
//                                  height: 40,
//                                  width: 40,
//                                )
//                              : CircleAvatar(
//                                  radius: 25.0,
//                                  backgroundImage: NetworkImage(
//                                      BASE_URL + 'uploads/image/' + imageValue),
//                                  backgroundColor: Colors.transparent,
//                                ),
//                        ),
//                        SizedBox(
//                          width: 5,
//                        ),
//                        GestureDetector(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                new MaterialPageRoute(
//                                    builder: (context) => GroupClasses()));
//                          },
//                          child: Image.asset(
//                            baseImageAssetsUrl + 'logo_black.png',
//                            width: 60,
//                            height: 30,
//                          ),
//                        ),
//                        Spacer(),
//                        GestureDetector(
//                            onTap: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (context) =>
//                                          NotificationScreen()));
//                            },
//                            child: SvgPicture.asset(
//                                baseImageAssetsUrl + 'noti_dot.svg'))
//                      ],
//                    ),
//                  ),
//                  Divider(
//                    height: .5,
//                    // color: CColor.PRIMARYCOLOR,
//                  ),
                  _children[_currentIndex],
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
                ]),
              ));
  }
}
