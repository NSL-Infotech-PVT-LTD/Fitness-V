import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Methods/notificationList.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationScreen> {
  String auth = '';
  // StatusResponse obj;

  @override
  void initState() {
    getString(USER_AUTH).then((value) => {auth = value}).whenComplete(() => {
          getNotificationList(auth)
              .then((value) => print("Notification" + value.data.toString()))
              .whenComplete(() {

          })
        });
    super.initState();
  }

  final notificationList = List<CustomNoti>.generate(
      8, (i) => CustomNoti(title: 'Group Class on Thursday ,24 Jan ,11.00AM'));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            backWithArrow(context),
            Container(
              color: Colors.black,
              height: 72,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 0, 20),
                child: Text(
                  notifications,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize24,
                      fontFamily: open_light),
                ),
              ),
            ),
            DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      color: Color(0xFFE9E9E9),
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: padding15),
                        width: SizeConfig.screenWidth,
                        child: TabBar(
                          tabs: [
                            Tab(
                                icon: Text(
                              today,
                              style: TextStyle(fontSize: textSize16),
                            )),
                            Tab(
                                icon: Text(recent,
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
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                primary: false,
                                itemCount: notificationList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: CustomNotiView(
                                      customNoti: notificationList[index],
                                      color: Color(0xFF000000),
                                      titleColor: Color(0xFF000000),
                                      onTap: () {},
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 1,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                primary: false,
                                itemCount: notificationList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: CustomNotiView(
                                      customNoti: notificationList[index],
                                      color: Color(0xFFC1C1C1),
                                      titleColor: Color(0xFFC1C1C1),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class CustomNoti {
  final String title;

  const CustomNoti({this.title});
}

class CustomNotiView extends StatelessWidget {
  final VoidCallback onTap;
  final CustomNoti customNoti;
  final Color color;
  final Color titleColor;

  const CustomNotiView(
      {Key key, this.customNoti, this.onTap, this.color, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(.5),
                    ),
                    color: color),
              ),
              Expanded(
                  child: Padding(
                child: Text(
                  customNoti.title,
                  style: TextStyle(color: titleColor),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
              )),
            ],
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
        ),
        myDivider()
      ]),
    );
  }
}
