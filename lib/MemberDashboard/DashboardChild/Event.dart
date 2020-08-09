import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Methods/ents.dart';
import 'package:volt/Value/CColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/util/constants.dart';
import 'package:volt/util/networkutil.dart';

class Event extends StatefulWidget {
  Event({Key key, @required this.image, @required this.name}) : super(key: key);

  final String image;
  final String name;

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  Evet evnts;

  NetworkUtil _netUtil = new NetworkUtil();
  String _serverResponse = "";
  bool _isLoading = false;
  Map<String, dynamic> data;
  List<dynamic> myData = new List<dynamic>();
  List<dynamic> myDatapast = new List<dynamic>();

  //myDatapast

  // SharedPreferences variables
  SharedPreferences prefs;

  var apiResponse;

  @override
  void initState() {
    super.initState();
    String auth = '';
    getString(USER_AUTH).then((value) {
      auth = value;
      print('jugraj' + auth);
    }).whenComplete(
        () => {_createveentsupcomingList(auth), _createveentspastList(auth)});
  }

  void _createveentsupcomingList(String auth) async {
    _netUtil.post(context, Constants.event, auth, body: {
      "order_by": "upcoming",
    }).then((response) async {
      print("Sanjeev-->" + response.body);

      var extracted = json.decode(response.body);
      if ((extracted["code"] == 200)) {
        setState(() {
          print(
              '---------------------STARTING TO PARSE THE RESPONSE--------------------');
          _isLoading = false;
          apiResponse = extracted['data'];
          //    print(apiResponse);
          myData = apiResponse['data'] as List;

          var eventsInJsonFormat = apiResponse['data'];
          evnts = Evet.fromJson(eventsInJsonFormat);
          _isLoading = false;
        });
      } else {
        _serverResponse = extracted['error'];

        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      print(error.toString());
    });
  }

  ///past
  void _createveentspastList(String auth) async {
    //prefs = await SharedPreferences.getInstance();

    // TODO: Ater the SharedPreferences object is created at login, delete

    _netUtil.post(context, Constants.event, auth, body: {
      "order_by": "past",
    }).then((response) async {
      print("Sanjeev-->" + response.body);

      var extracted = json.decode(response.body);

      if ((extracted["code"] == 200)) {
        setState(() {
          print(
              '---------------------STARTING TO PARSE THE RESPONSE--------------------');
          _isLoading = false;
          apiResponse = extracted['data'];
          //   print(apiResponse);
          myDatapast = apiResponse['data'] as List;
          _isLoading = false;
        });
        // TODO: Add code for the No Blocked Users scenario.
      } else {
        _serverResponse = extracted['error'];

        setState(() {
          _isLoading = false;
        });
      }

      //    print(widget.name,);
      //  print('------------Ended _getEvetsList()-------------');
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _isLoading
        ? Center(child: new CircularProgressIndicator())
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    baseImageAssetsUrl + 'fitness.png',
                  )),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 10,
                  ),
                  SvgPicture.asset(baseImageAssetsUrl + 'cardio.svg',
                      height: 20, width: 20),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  Text(
                    events,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 16,
                  ),
                  Expanded(
                    child: Text(
                      fantastic,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        color: CColor.WHITE,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.only(left: padding15),
                          width: SizeConfig.screenWidth,
                          child: TabBar(
                            tabs: [
                              Tab(
                                  icon: Text(
                                upcoming,
                                style: TextStyle(fontSize: textSize16),
                              )),
                              Tab(
                                  icon: Text(recent1,
                                      style: TextStyle(fontSize: textSize16))),
                            ],
                            isScrollable: true,
                            indicatorColor: Colors.black,
                            labelColor: Color(0xFF474747),
                            unselectedLabelColor: Color(0xFFC1C1C1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            baseImageAssetsUrl + 'filling_fast.svg',
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      // SizedBox(height: SizeConfig.blockSizeVertical * 0.),
                      Container(
                        //   color: Colors.black,
                        padding: EdgeInsets.all(5),
                        height: SizeConfig.screenHeight * 0.5,
                        child: TabBarView(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                ListView.builder(
                                  padding: EdgeInsets.all(8),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: myData.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Column(
                                        //    crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                //   color: Colors.red,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.22,
                                                width: SizeConfig.screenWidth,
                                                child: GestureDetector(
                                                    onTap: () {},
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          baseImageAssetsUrl +
                                                              'logo_white.png',
                                                      image: BASE_URL +
                                                          Constants.uploads +
                                                          Constants.event +
                                                          "/" +
                                                          myData[index]
                                                              ['image'],
                                                      fit: BoxFit.cover,
                                                      //  height: SizeConfig.screenHeight * .25,
                                                    )),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 20, bottom: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  //    mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        //      color:Colors.red,
                                                        //   padding: EdgeInsets.only(left:10),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          myData[index]['name'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22.0),
                                                        )),
                                                    SizedBox(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.2,
                                                        child: Divider(
                                                          thickness: 2,
                                                          color: Colors.white,
                                                          height: 9,
                                                        )),
//                                                  SizedBox(
//                                                    height: SizeConfig.blockSizeVertical * 3,
//                                                  ),
                                                    Container(
                                                        // padding: EdgeInsets.all(20),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          myData[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.0),
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ], ////gro
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            //Todo 2nd tab
                            Column(
                              children: <Widget>[
                                ListView.builder(
                                  padding: EdgeInsets.all(8),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: myDatapast.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Column(
                                        //    crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                //   color: Colors.red,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.22,
                                                width: SizeConfig.screenWidth,
                                                child: GestureDetector(
                                                    onTap: () {},
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          baseImageAssetsUrl +
                                                              'logo_white.png',
                                                      image: BASE_URL +
                                                          Constants.uploads +
                                                          Constants.event +
                                                          "/" +
                                                          myDatapast[index]
                                                              ['image'],
                                                      fit: BoxFit.cover,
                                                      //  height: SizeConfig.screenHeight * .25,
                                                    )),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 20, bottom: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  //    mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        //      color:Colors.red,
                                                        //   padding: EdgeInsets.only(left:10),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          myDatapast[index]
                                                              ['name'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22.0),
                                                        )),
                                                    SizedBox(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.2,
                                                        child: Divider(
                                                          thickness: 2,
                                                          color: Colors.white,
                                                          height: 9,
                                                        )),
//                                                  SizedBox(
//                                                    height: SizeConfig.blockSizeVertical * 3,
//                                                  ),
                                                    Container(
                                                        // padding: EdgeInsets.all(20),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          myDatapast[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.0),
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ], ////gro
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
//                            Container(
//                              //    height: 80,
//                              //   color:Colors.red,
//                              child: ListView.builder(
//                                padding: EdgeInsets.all(10),
//                                scrollDirection: Axis.vertical,
//                                shrinkWrap: true,
//                                physics: NeverScrollableScrollPhysics(),
//                                itemCount: myDatapast.length,
//                                itemBuilder: (context, index) {
//                                  return GestureDetector(
//                                    child: Column(
//                                      //    crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Stack(
//                                          alignment: Alignment.bottomRight,
//                                          children: <Widget>[
//                                            Container(
//                                              // height: SizeConfig.screenHeight * 0.3,
//                                              // width: SizeConfig.screenWidth,
//                                              child: GestureDetector(
//                                                  onTap: () {},
//                                                  child: Image.network(
//                                                    BASE_URL +
//                                                        Constants.uploads +
//                                                        Constants.event +
//                                                        "/" +
//                                                        myDatapast[index]
//                                                            ['image'],
//                                                  )),
//                                            ),
//                                            Container(
//                                              //   color: Colors.blue,
//                                              height:
//                                                  SizeConfig.screenHeight * 0.2,
//                                              child: Column(
//                                                crossAxisAlignment:
//                                                    CrossAxisAlignment.start,
//                                                children: <Widget>[
//                                                  Container(
////                                                          padding:
////                                                              EdgeInsets.all(30),
//                                                      alignment:
//                                                          Alignment.bottomLeft,
//                                                      child: Text(
//                                                        myDatapast[index]
//                                                            ['name'],
//                                                        style: TextStyle(
//                                                            color: Colors.white,
//                                                            fontSize: 22.0),
//                                                      )),
//                                                  Divider(
//                                                    color: Colors.red,
//                                                  ),
//                                                  Container(
//                                                      padding:
//                                                          EdgeInsets.all(20),
//                                                      alignment:
//                                                          Alignment.topLeft,
//                                                      child: Text(
//                                                        myDatapast[index]
//                                                            ['description'],
//                                                        style: TextStyle(
//                                                            color: Colors.white,
//                                                            fontSize: 15.0),
//                                                      )),
//
////                                                  Padding(
////                                                    padding: const EdgeInsets.only(left:27.0,bottom: 20),
////                                                    child: SizedBox(
//////                                                      width:
//////                                                          SizeConfig.screenWidth *
//////                                                              0.30,
////                                                      //   height: SizeConfig.screenHeight * 0.9,
////                                                      child: Divider(
////                                                        thickness: 2.0,
////                                                        color: Colors.red,
////                                                      ),
////                                                    ),
////                                                  ),
//                                                ],
//                                              ),
//                                            ),
//                                          ], ////gro
//                                        ),
////                                          Divider(
////                                            height: 9,
////                                          ),
////                                          Divider(
////                                            height: 2,
////                                          ),
//                                      ],
//                                    ),
//                                  );
//                                },
//                              ),
//                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          );
  }
}

void showMyDialog(context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
//                Navigator.pushReplacement(
//                    context, SizeRoute(page: ChooseYourWay()));
              },
            ),
          ],
        );
      });
}

Widget _CommonView(String image, String title, String des) => GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      image,
                      width: 76,
                      fit: BoxFit.cover,
                      height: 76,
                    )),
                new Container(
                  width: SizeConfig.blockSizeHorizontal * 50,
                  padding: const EdgeInsets.only(left: padding25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          des,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                //   Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
        padding: EdgeInsets.all(padding30),
      ),
    );
