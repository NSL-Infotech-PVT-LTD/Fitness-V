import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Screens/view_personal_trainer.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class SelectSession extends StatefulWidget {
  final int id;
  final String image;
  final String name;
  final bool isGroupClass;
  final String roleType;

  const SelectSession(
      {Key key,
      this.isGroupClass,
      this.id,
      this.image,
      this.name,
      this.roleType});

  @override
  State<StatefulWidget> createState() => SelectSessionState();
}

class SelectSessionState extends State<SelectSession> {
  int valueHolder = 0;
  String _imageLink;
  String auth = '';
  bool _wantToShowPrice = true;

  @override
  void initState() {
    getString(USER_AUTH).then((value) => {auth = value});

    if (widget.isGroupClass) {
      if (widget.roleType == localGuest || widget.roleType == fairmontHotel) {
        _wantToShowPrice = true;
      } else {
        _wantToShowPrice = false;
      }
    }

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _imageLink = widget.image;
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(padding20, 0, 0, 0),
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
                          chooseSession,
                          style: TextStyle(fontSize: textSize20),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              myDivider(),
              SizedBox(
                height: 20,
              ),
              _imageLink == null
                  ? Image.asset(
                      baseImageAssetsUrl + 'logo_black.png',
                      height: 150,
                    )
                  : setImage(_imageLink),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25, top: 20, bottom: 10),
                child: Text(
                  'Private lesson with $personal_trainer.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25, top: 0, bottom: 10),
                child: myDivider(),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25, top: 0, bottom: 10),
                child: Row(
                  children: <Widget>[
                    new RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "Session",
                            style: TextStyle(
                                fontSize: textSize12, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "\n(In hour)",
                                  style: TextStyle(
                                      fontSize: textSize8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45))
                            ])),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          width: widget.isGroupClass
                              ? SizeConfig.screenWidth * .55
                              : SizeConfig.screenWidth * .72,
                          child: Slider(
                              value: valueHolder.toDouble() == 0
                                  ? 1
                                  : valueHolder.toDouble(),
                              min: 0,
                              max: widget.isGroupClass ? 12 : 24,
                              divisions: widget.isGroupClass ? 2 : 4,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              label:
                                  '${valueHolder.round() == 0 ? 1 : valueHolder.round()}',
                              onChanged: (double newValue) {
                                setState(() {
                                  valueHolder = newValue.round() == 18
                                      ? 24
                                      : newValue.round();
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          width: SizeConfig.screenWidth * .68,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.screenWidth * .17,
                                child: Text(
                                  '1',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * .17,
                                child: Text(
                                  '6',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * .17,
                                child: Text(
                                  '12',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Visibility(
                                visible: !widget.isGroupClass,
                                child: Container(
                                  width: SizeConfig.screenWidth * .17,
                                  child: Text(
                                    '24',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),

              //////////////////////////////////////////

              Visibility(
                visible: _wantToShowPrice,
                child: Padding(
                  padding: EdgeInsets.only(left:50),
                  child: Row(
                    children: <Widget>[
                      new RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: "Price",
                              style: TextStyle(
                                  fontSize: textSize12,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "",
                                    style: TextStyle(
                                        fontSize: textSize8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45))
                              ])),
                      // SizedBox(
                      //   width: SizeConfig.screenWidth * 0.2,
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        width: SizeConfig.screenWidth * 0.50,
                        height: button_height,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                                Radius.circular(button_radius))),
                        child: Center(
                            child: Text(
                              '${sendValue()} $aed',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 10),
                        height: 60,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '/ Hour',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /////////////////////////////////

              // Visibility(
              //   visible: _wantToShowPrice,
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //         left: 25.0, right: 25, top: 0, bottom: 10),
              //     child: Row(
              //       children: <Widget>[
              //         new RichText(
              //             textAlign: TextAlign.start,
              //             text: TextSpan(
              //                 text: "Price",
              //                 style: TextStyle(
              //                     fontSize: textSize12, color: Colors.black),
              //                 children: <TextSpan>[
              //                   TextSpan(
              //                       text: "",
              //                       style: TextStyle(
              //                           fontSize: textSize8,
              //                           fontWeight: FontWeight.bold,
              //                           color: Colors.black45))
              //                 ])),
              //         SizedBox(
              //           width: SizeConfig.screenWidth * .1,
              //         ),
              //         Container(
              //           margin: EdgeInsets.only(left: 10, top: 10),
              //           width: 150,
              //           height: 60,
              //           decoration: BoxDecoration(
              //               color: Colors.black,
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(16))),
              //           child: Center(
              //               child: Text(
              //             '${sendValue()} $aed ',
              //             style: TextStyle(color: Colors.white),
              //           )),
              //         ),
              //         Container(
              //           margin: EdgeInsets.only(left: 5, top: 10),
              //           height: 60,
              //           child: Align(
              //             alignment: Alignment.center,
              //             child: Text(
              //               '/ Hour',
              //               style: TextStyle(color: Colors.grey),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              // Center(
              //   child: Container(
              //     margin: EdgeInsets.only(top: padding15),
              //     height: button_height,
              //     width: 150,
              //     child: FlatButton(
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => YourBooking(
              //                       id: widget.id,
              //                       image: widget.image,
              //                       wantToShowPrice: _wantToShowPrice,
              //                       isGroupClass: widget.isGroupClass,
              //                       name: widget.name,
              //                       payment: sendValue().toString(),
              //                       serviceHours: valueHolder == 0 ? 1.toString() : valueHolder.toString(),
              //                     )));
              //       },
              //       child: Text(
              //         continu,
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                        Radius.circular(button_radius))),
                margin: EdgeInsets.only(top: padding25,left: 30,right:30 ),
                height: button_height,
                width: SizeConfig.screenWidth,
                // width: 100,
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YourBooking(
                              id: widget.id,
                              image: widget.image,
                              wantToShowPrice: _wantToShowPrice,
                              isGroupClass: widget.isGroupClass,
                              name: widget.name,
                              payment: sendValue().toString(),
                              serviceHours: valueHolder == 0 ? 1.toString() : valueHolder.toString(),
                            )));
                    //  print("${widget.id}  ${valueHolder}");
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(button_radius)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Text(continu,
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                //   color: Colors.black,

              ),
            ]),
      ),
    );
  }

  int sendValue() {
    int value = 0;
    if (valueHolder == 0) {
      value = 250;
    } else if (valueHolder == 6) {
      value = 1400;
    } else if (valueHolder == 12) {
      value = 2600;
    } else if (valueHolder == 24) {
      value = 5000;
    }
    return value;
  }

  Widget setImage(String imgLink) => FadeInImage.assetNetwork(
        placeholder: baseImageAssetsUrl + 'logo_black.png',
        image: BASE_URL +
            "${widget.isGroupClass ? imageClassUrl : trainerUser}" +
            imgLink,
        width: SizeConfig.screenWidth,
        height: 250,
      );
}
