import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class GroupClasses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupClassesState();
}

class GroupClassesState extends State<GroupClasses> {
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
            backWithArrowAndIcon(baseImageAssetsUrl + 'noti_dot.svg'),
            DefaultTabController(
                length: 1,
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
                              groupClasses,
                              style: TextStyle(fontSize: textSize16),
                            )),
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
                        children: <Widget>[groupClass()],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget groupClass() => Container(
        child: Column(
          children: <Widget>[
            Image.asset(
              baseImageAssetsUrl + 'couple.png',
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 5),
              child: Text(
                'Body pump, Body Attack, RPM, Grit, Body Combat,The trip, CX Worx etc.',
                style:
                    TextStyle(fontFamily: open_semi_bold, fontSize: textSize12),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("sessiion"),
                        Text("1 sessiion"),
                        Text("6 sessiion/month"),
                        Text("12 sessiion/month"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("price"),
                        Text("60 AED"),
                        Text("340 AED"),
                        Text("660 AED"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Select"),
                        Text("1 "),
                        Text("6 "),
                        Text("12"),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      );
}
