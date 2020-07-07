import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class BookingAndCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookingAndCartState();
}

class BookingAndCartState extends State<BookingAndCart> {
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
                child: Row(
                  children: <Widget>[
                    Text(
                      cart,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: textSize24,
                          fontFamily: open_light),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      baseImageAssetsUrl + 'cart.svg',
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
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
                              booking,
                              style: TextStyle(fontSize: textSize16),
                            )),
                            Tab(
                                icon: Text(cart,
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
                      height: MediaQuery.of(context).size.height * .8,
                      child: TabBarView(
                        children: <Widget>[
                          Container(child: Text('Booking')),
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  right: SizeConfig.screenWidth * .25,
                                  top: SizeConfig.screenWidth * .38,
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'empty_cart.svg',
                                    height: SizeConfig.blockSizeVertical * 25,
                                  ),
                                ),
                                Positioned(
                                  left: 25,
                                  right: 25,
                                  bottom: 20,
                                  child: fullWidthButton(
                                    context,
                                    go_to_dashboard,
                                    SizeConfig.screenWidth,
                                    FontWeight.bold,
                                    Dashboard(),
                                  ),
                                )
                              ],
                            ),
                          )
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
