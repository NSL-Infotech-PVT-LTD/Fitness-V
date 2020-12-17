import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:volt/Bookings/BookingAndCart.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Text(
                            "session",
                            style: TextStyle(
                              color: CColor.LightGrey,
                              fontSize: textSize10,
                              fontFamily: open_light,
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 22,
                          child: Text("price",
                              style: TextStyle(
                                color: CColor.LightGrey,
                                fontSize: textSize10,
                                fontFamily: open_light,
                              )),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 18,
                          child: Text("Select",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CColor.LightGrey,
                                fontSize: textSize10,
                                fontFamily: open_light,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Text(
                            "1 session",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: textSize16,
                              fontFamily: open_light,
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 22,
                          child: Text("60 AED",
                              style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontSize: textSize12,
                                fontWeight: FontWeight.w500,
                                fontFamily: open_semi_bold,
                              )),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 18,
                          child: Checkbox(
                            onChanged: (bool value) {},
                            value: false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Text(
                            "6 sessions/month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: textSize16,
                              fontFamily: open_light,
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 22,
                          child: Text("340 AED",
                              style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontWeight: FontWeight.w500,
                                fontSize: textSize12,
                                fontFamily: open_semi_bold,
                              )),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 18,
                          child: Checkbox(
                            onChanged: (bool value) {},
                            value: false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Text(
                            "12 sessions/month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: textSize16,
                              fontFamily: open_light,
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 22,
                          child: Text("660 AED",
                              style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontSize: textSize12,
                                fontWeight: FontWeight.w500,
                                fontFamily: open_semi_bold,
                              )),
                        ),
                        Container(
                            width: SizeConfig.blockSizeHorizontal * 18,
                            child: Checkbox(
                              onChanged: (bool value) {},
                              value: false,
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: margin20, bottom: 10),
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(button_radius)),
                          color: Color(0xffE6E6E6)),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '6 sessions/month',
                                    style: TextStyle(
                                        fontSize: textSize10,
                                        color: Colors.black45),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '340 AED',
                                    style: TextStyle(
                                        fontSize: textSize16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black45),
                                  )),
                            ],
                          ),
                          Spacer(),
                          Container(
                              height: 60,
                              padding: EdgeInsets.all(10),
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(button_radius),
                                      bottomRight:
                                          Radius.circular(button_radius)),
                                  color: Colors.black),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              BookingAndCart()));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        baseImageAssetsUrl + 'cart.svg'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Added to cart',
                                      style: TextStyle(
                                          fontSize: 5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
}
