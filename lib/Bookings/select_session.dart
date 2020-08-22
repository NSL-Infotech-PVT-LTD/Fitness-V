import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class SelectSession extends StatefulWidget {
  final int id;
  final String image;
  final String name;

  const SelectSession({Key key, this.id, this.image,this.name});

  @override
  State<StatefulWidget> createState() => SelectSessionState();
}

class SelectSessionState extends State<SelectSession> {
  int valueHolder = 0;
  String _imageLink;
  String auth = '';

  @override
  void initState() {
    getString(USER_AUTH).then((value) => {auth = value});
    super.initState();
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
                          width: SizeConfig.screenWidth * .72,
                          child: Slider(
                              value: valueHolder.toDouble() == 0
                                  ? 1
                                  : valueHolder.toDouble(),
                              min: 0,
                              max: 24,
                              divisions: 4,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              label:
                                  '${valueHolder.round() == 0 ? 1 : valueHolder.round()}',
                              onChanged: (double newValue) {
                                setState(() {
                                  valueHolder = newValue.round() == 18
                                      ? 24
                                      : newValue.round();
                                  print(valueHolder.toString());
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
                              Container(
                                width: SizeConfig.screenWidth * .17,
                                child: Text(
                                  '24',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.black),
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25, top: 0, bottom: 10),
                child: Row(
                  children: <Widget>[
                    new RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "Price",
                            style: TextStyle(
                                fontSize: textSize12, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "",
                                  style: TextStyle(
                                      fontSize: textSize8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45))
                            ])),
                    SizedBox(
                      width: SizeConfig.screenWidth * .1,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
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
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: padding15),
                  height: button_height,
                  width: 150,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YourBooking(
                                    id: widget.id,
                                    image: widget.image,
                                    name: widget.name,
                                    payment: sendValue().toString(),
                                    serviceHours: valueHolder==0?1.toString():valueHolder.toString(),
                                  )));
                    },
                    child: Text(
                      continu,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
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
        image: BASE_URL + trainerUser + imgLink,
        fit: BoxFit.cover,
        width: SizeConfig.screenWidth,
        height: 250,
      );
}