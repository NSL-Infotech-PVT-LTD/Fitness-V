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
                        children: <Widget>[
                        Image.asset(baseImageAssetsUrl+'couple.png',alignment: Alignment.topLeft,height: 60,)
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
