import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/Methods/Method.dart';
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
  final bool isSession;

  const SelectSession(
      {Key key,
      this.isGroupClass,
      this.id,
      this.image,
      this.name,
      this.roleType,
        this.isSession});

  @override
  State<StatefulWidget> createState() => SelectSessionState();
}


class SelectSessionState extends State<SelectSession> {

  String ts1;
  String ts6;
  String ts12;
  String ts24;

  void sessionPrice() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        Map<String, String> parms = {
          if(!widget.isSession)type:"trainer",
          if(widget.isSession)type:"session",
        };
        sessionOrTrainerPri(parms).then((response) {

          dismissDialog(context);
          if (response.status) {
if(response.data.s1 != null && response.data.s6 != null && response.data.s12 != null){
  setState(() {
    ts1 = response.data.s1;
    ts6 = response.data.s6;
    ts12 = response.data.s12;
    ts24 = response.data.s24;
  });

}
        print("Responc " + response.data.s1);
        setState(() {
          loader = false;
        });
          } else {
            setState(() {
              loader = false;
            });
            var message = '';
            dismissDialog(context);
            //need to change
            if (response.error != null) {
              setState(() {
                loader = false;
              });
              message = response.error;
            } else if (response.error != null) {
              setState(() {
                loader = false;
              });
              message = response.error;
            }
            if (message.isNotEmpty) {
              setState(() {
               loader = false;
              });
              showDialogBox(context, "Error!", message);
            }
          }
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }
  int valueHolder = 0;
  int valueHolderSlider = 0;
  int valueSessionsHolder = 0;
  String _imageLink;
  String auth = '';
  bool _wantToShowPrice = true;
  bool loader = true;

  int sendValue() {
    int value = 0;
    if (valueHolder == 0) {
      value = int.parse(ts1);
    } else if (valueHolder == 6) {
      value = int.parse(ts6);
    } else if (valueHolder == 12) {
      value = int.parse(ts12);
    }
    else if (valueHolder == 24) {
      value = int.parse(ts24);
    }
    return value;
  }
  @override
  void initState() {
    setState(() {
      loader = true;
    });
    getString(USER_AUTH).then((value) => {auth = value});
    sessionPrice();


    setState(() {});
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    _imageLink = widget.image;
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child:loader?Container(
          height: SizeConfig.screenHeight,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator(backgroundColor: Colors.black,)),
            ],
          ),
        ): Column(
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
                  ? Center(
                    child: Image.asset(
                        baseImageAssetsUrl + 'logo.png',
                        height: 150,
                      ),
                  )
                  : setImage(_imageLink),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 25.0, right: 25, top: 20, bottom: 10),
              //   child: Text(
              //     'Private lesson with $personal_trainer.',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 12),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 25.0, right: 25, top: 0, bottom: 10),
              //   child: myDivider(),
              // ),
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
                   widget.isSession?
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          width: widget.isGroupClass || widget.isSession
                              ? SizeConfig.screenWidth * .55
                              : SizeConfig.screenWidth * .72,
                          child: Slider(
                              value: valueSessionsHolder.toDouble() == 0 ? 0 : valueSessionsHolder.toDouble(),
                              min: 0,
                              max: widget.isGroupClass || widget.isSession ? 12 : 24,
                              divisions: widget.isGroupClass || widget.isSession? 2 : 4,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              label: '${valueSessionsHolder.round() == 0 ? 1 : valueSessionsHolder.round()}',
                              onChanged: (double newValue) {
                                setState(() {
                                  valueSessionsHolder = newValue.round() == 18 ? 24 : newValue.round();
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 08),
                          width: SizeConfig.screenWidth * .75,
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
                                visible: !widget.isGroupClass && !widget.isSession,
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
                    ): Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(left: 10, top: 10),
                         width: widget.isGroupClass || widget.isSession
                             ? SizeConfig.screenWidth * .55
                             : SizeConfig.screenWidth * .67,
                         child: Slider(
                             value: valueHolderSlider.toDouble(),//valueHolder.toDouble() == 0 ? 1 : valueHolder.toDouble(),
                             min: 0,
                             max: widget.isGroupClass || widget.isSession ? 12 : 24,
                             divisions: widget.isGroupClass || widget.isSession? 2 : 3,
                             activeColor: Colors.black,
                             inactiveColor: Colors.grey,
                             label: '${valueHolder.round() == 0 ? 1 : valueHolder.round()}',
                             onChanged: (double newValue) {
                               setState(() {
                                 valueHolderSlider = newValue.round();
                                 valueHolder = newValue.round() == 18 ? 24 : newValue.round();
if(valueHolder == 8){
  valueHolder = 6;
}else if(valueHolder == 16){
  valueHolder = 12;
}
                               });
                             },
                             semanticFormatterCallback: (double newValue) {
                               return '${newValue.round()}';
                             }),
                       ),
                       Container(
                         margin: EdgeInsets.only(left: 10),
                         width: SizeConfig.screenWidth * .68,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                          //   SizedBox(width: SizeConfig.screenWidth * 0.03,),
                             Container(
                             //  width: SizeConfig.screenWidth * .17,
                               child: Text(
                                 '1',
                                 style: TextStyle(color: Colors.black),
                               ),
                             ),
                             SizedBox(width: SizeConfig.screenWidth * 0.05,),
                             Container(
                               //width: SizeConfig.screenWidth * .17,
                               child: Text(
                                 '6',
                                 style: TextStyle(color: Colors.black),
                               ),
                             ),
                             SizedBox(width: SizeConfig.screenWidth * 0.06,),
                             Container(
                               //width: SizeConfig.screenWidth * .17,
                               child: Text(
                                 '12',
                                 style: TextStyle(color: Colors.black),
                               ),
                             ),
                             SizedBox(width: SizeConfig.screenWidth * 0.05,),
                             Visibility(
                               visible: !widget.isGroupClass && !widget.isSession,
                               child: Container(
                                 //width: SizeConfig.screenWidth * .17,
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
                              widget.isSession?'${sendValueT()} $aed':'${sendValue()} $aed',
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
                        widget.isSession? MaterialPageRoute(
                          builder: (context) => YourBooking(wantToShowPrice: false,name: "Session",isGroupClass: false,payment: sendValueT().toString(),serviceHours:  valueSessionsHolder == 0 ? 1.toString() : valueSessionsHolder.toString(),isSession: widget.isSession,)) :MaterialPageRoute(
                            builder: (context) => YourBooking(isSession: false,
                              id: widget.id, image: widget.image, wantToShowPrice: _wantToShowPrice,
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
    setState(() {});
  }



  int sendValueT() {
    int value = 0;
    if (valueSessionsHolder == 0) {
      value = int.parse(ts1);
    } else if (valueSessionsHolder == 6) {
      value = int.parse(ts6);
    } else if (valueSessionsHolder == 12) {
      value = int.parse(ts12);
    }
    else if (valueSessionsHolder == 24) {
      value = int.parse(ts24);
    }
    return value;
  }

  Widget setImage(String imgLink) => FadeInImage.assetNetwork(
        placeholder: baseImageAssetsUrl + 'logo.png',
        image: BASE_URL +
            "${widget.isGroupClass ? imageClassUrl : trainerUser}" +
            imgLink,
        width: SizeConfig.screenWidth,
        height: 250,
      );
}
