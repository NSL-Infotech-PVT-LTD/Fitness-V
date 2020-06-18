import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/MemberDashboard/DashboardChild/Cardio.dart';
import 'package:volt/MemberDashboard/DashboardChild/Event.dart';
import 'package:volt/MemberDashboard/DashboardChild/Home.dart';
import 'package:volt/Screens/ProfileScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import 'GroupClassses.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final List<Widget> _children = [Home(), Cardio(), Event()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: topMargin40,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: Image.asset(
                      baseImageAssetsUrl + 'circleuser.png',
                      height: 40,
                      width: 40,
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
                  SvgPicture.asset(baseImageAssetsUrl + 'noti_dot.svg')
                ],
              ),
            ),
            Divider(
              height: .5,
              color: CColor.PRIMARYCOLOR,
            ),

            _children[_currentIndex],
          ]),
        ));
  }
}
