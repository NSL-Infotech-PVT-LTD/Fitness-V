import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class YourBooking extends StatefulWidget {
  final int id;
  final String image;
  final String serviceHours;
  final String name;
  final String payment;
  final bool isGroupClass;
  final bool wantToShowPrice;

  const YourBooking(
      {this.id,
      this.image,
      this.serviceHours,
      this.isGroupClass,
      this.name,
      this.wantToShowPrice,
      this.payment});

  @override
  State<StatefulWidget> createState() => YourBookingState();
}

class YourBookingState extends State<YourBooking> {
  String auth = '';
  bool isBookingConfirmed = false;

  @override
  void initState() {
    getString(USER_AUTH).then((value) => {auth = value});
    super.initState();
  }
  void doYoWantToCntinue() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Booking confirmation"),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Do you want to continue ?",
                  style: TextStyle(wordSpacing: 1)),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Yes"),
                onPressed: () {
//                  Navigator.pop(context);
                  bookingFunction(
                      auth,
                      context,
                      "${widget.isGroupClass ? classSchedules : trainerUsers}",
                      widget.id.toString(),
                      widget.serviceHours);
                },
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: false,
              ),
            ],
          );
        });

//  showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text(title),
//          content: Text(message),
//          actions: <Widget>[
//            FlatButton(
//              child: const Text('OK'),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ],
//        );
//      });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM, yyyy kk:mm:ss').format(now);

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
                      left: 25,
                      right: 20,
                      child: Container(
                        margin: EdgeInsets.only(top: padding15),
                        height: button_height,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: RaisedButton(
                            onPressed: () {

                             doYoWantToCntinue();
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(button_radius)),
                            child: new RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: widget.wantToShowPrice?"Proceed to Pay":"Proceed to Book",
                                    style: TextStyle(
                                        fontSize: textSize12,
                                        color: Colors.white),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.wantToShowPrice?" ${widget.payment} AED":"",
                                          style: TextStyle(
                                              fontSize: textSize12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))
                                    ]))),
                      ),
                    ),
                    Positioned(
                      bottom: 26.5,
                      right: 26.5,
                      child: Container(
                        margin: EdgeInsets.only(top: padding15),
                        height: 40,
                        width: 40,
                        child: RaisedButton(
                            onPressed: () {
                              doYoWantToCntinue();
//                                Navigator.push(context,
//                                    SizeRoute(page: BookingConfirmed()));
                            },
                            color: Color(0xff707070),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(button_radius)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
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
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    your_booking,
                                    style: TextStyle(fontSize: textSize20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: .5,
                            color: CColor.PRIMARYCOLOR,
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 34,
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
                                widget.image == null
                                    ? Positioned(
                                        top: 45,
                                        right: 40,
                                        child: Image.asset(
                                          baseImageAssetsUrl + 'dummy2.png',
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ))
                                    : Positioned(
                                        top: 45,
                                        right: 40,
                                        child: FadeInImage.assetNetwork(
                                          placeholder: baseImageAssetsUrl +
                                              'logo.png',
                                          image: BASE_URL +
                                              "${widget.isGroupClass ? imageClassUrl : trainerUser}" +
                                              widget.image,
                                          fit: BoxFit.cover,
                                          height: 70,
                                          width: 70,
                                        )),
                                Positioned(
                                  top: 55,
                                  left: 55,
                                  child: Text(
                                    widget.name,
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
                                    'Programme Hours',
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
                                    // ignore: unrelated_type_equality_checks
                                    '${widget.serviceHours == 0 ? 1 : widget.serviceHours} Hours',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                                Positioned(
                                  top: 175,
                                  left: 55,
                                  child: Text(
                                    'Booked On',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: open_light),
                                  ),
                                ),
                                Positioned(
                                  top: 185,
                                  left: 55,
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                                Positioned(
                                  top: SizeConfig.screenHeight * .17,
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
                                  top: 210,
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
                                  top: 220,
                                  left: 55,
                                  child: Text(
                                    '${"----"}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: fontRegular),
                                  ),
                                ),
//                                Positioned(
//                                  top: 230,
//                                  left: 55,
//                                  child: Text(
//                                    'Farley Wilth',
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 8,
//                                        fontFamily: open_light),
//                                  ),
//                                ),
//                                Positioned(
//                                  top: 240,
//                                  left: 55,
//                                  child: Text(
//                                    '241/FF, Silicon Valley, UAE',
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 8,
//                                        fontFamily: fontRegular),
//                                  ),
//                                ),
                              ],
                            ),
                          ),
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
