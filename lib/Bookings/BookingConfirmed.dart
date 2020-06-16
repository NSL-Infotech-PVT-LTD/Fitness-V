import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class BookingConfirmed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookingConfirmedState();
}

class BookingConfirmedState extends State<BookingConfirmed> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: SizeConfig.screenHeight,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            go_to_dashboard,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )),
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                padding20, padding10, padding20, 25),
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_back_ios)),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    booking_confirmed,
                                    style: TextStyle(fontSize: textSize20),
                                  ),
                                ),
                                Icon(Icons.check_circle)
                              ],
                            ),
                          ),
                          Divider(
                            height: .5,
                            color: CColor.PRIMARYCOLOR,
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 37,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'user_card.svg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  left: 55,
                                  child: Text(
                                    'Training Session',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: open_light),
                                  ),
                                ),
                                Positioned(
                                    top: 45,
                                    right: 40,
                                    child: Image.asset(
                                      baseImageAssetsUrl + 'dummy2.png',
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    )),
                                Positioned(
                                  top: 55,
                                  left: 55,
                                  child: Text(
                                    'John Willsmith',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                                Positioned(
                                  top: 85,
                                  left: 55,
                                  child: Text(
                                    'Service Hours',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: open_light),
                                  ),
                                ),
                                Positioned(
                                  top: 95,
                                  left: 55,
                                  child: Text(
                                    '2 Hrs/Day',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                                Positioned(
                                  top: 125,
                                  left: 55,
                                  child: Text(
                                    'Training Period',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: open_light),
                                  ),
                                ),
                                Positioned(
                                  top: 135,
                                  left: 55,
                                  child: Text(
                                    '25 March,2020 - 25 April,2020',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                                Positioned(
                                    top: 165,
                                    left: 55,

                                      child: Text(
                                        '--------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------      --------',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 5,
                                            fontFamily: fontRegular),
                                      ),
                                    ),
                                Positioned(
                                  top: 200,
                                  left: 55,
                                  child: Text(
                                    'Booking ID',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: open_light),
                                  ),
                                ),
                                Positioned(
                                  top: 210,
                                  left: 55,
                                  child: Text(
                                    '123879823649164',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                                Positioned(
                                  top: 230,
                                  left: 55,
                                  child: Text(
                                    'Farley Wilth',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: open_light),
                                  ),
                                ),
                                Positioned(
                                  top: 240,
                                  left: 55,
                                  child: Text(
                                    '241/FF, Silicon Valley, UAE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          SvgPicture.asset(
                            baseImageAssetsUrl + 'booking_confirmed.svg',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 30),
                          Text(
                            booking_confirmed,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xff2e2e2e)),
                          ),
                          Text(
                            'You may check your booking in BOOKINGs.',
                            style: TextStyle(
                                fontSize: 10, color: Color(0xff707070)),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
