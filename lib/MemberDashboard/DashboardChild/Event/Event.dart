import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/MemberDashboard/DashboardChild/Event/eventDetail.dart';
import 'package:volt/Methods.dart';
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
            children: <Widget>[
              GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    baseImageAssetsUrl + 'fitness.png',
                    fit: BoxFit.cover,
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * .17,
                  )),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  SvgPicture.asset(baseImageAssetsUrl + 'cardio.svg',
                      height: 15, width: 15),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  Text(
                    events,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 12,
                  ),
                  Expanded(
                    child: Text(
                      fantastic,
                      style: TextStyle(color: CColor.LightGrey, fontSize: 10),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Color(0xffE1E1E1),
                        margin: EdgeInsets.only(top: 20, bottom: 10),
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
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),

                      // SizedBox(height: SizeConfig.blockSizeVertical * 0.),
                      Container(
                        //   color: Colors.black,
                        padding: EdgeInsets.all(5),
                        height: SizeConfig.screenHeight * 0.7,
                        child: TabBarView(
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      baseImageAssetsUrl + 'filling_fast.svg',
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 350, minHeight: 300.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(8.0),
                                    physics: BouncingScrollPhysics(),
                                    primary: false,
                                    scrollDirection: Axis.vertical,
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
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            ScaleRoute(
                                                                page:
                                                                    EventDetail(
                                                              id: myData[index]
                                                                  ['id'],
                                                              status: upcoming,
                                                            )));
                                                      },
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    //    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                          //      color:Colors.red,
                                                          //   padding: EdgeInsets.only(left:10),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            myData[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                )
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
                                      onTap: () {},
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
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          ScaleRoute(
                                                              page: EventDetail(
                                                            id: myDatapast[
                                                                index]['id'],
                                                            status: recent,
                                                          )));
                                                    },
                                                    child: ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          Colors.grey,
                                                          BlendMode.saturation,
                                                        ),
                                                        child: FadeInImage
                                                            .assetNetwork(
                                                          placeholder:
                                                              baseImageAssetsUrl +
                                                                  'logo_black.png',
                                                          image: BASE_URL +
                                                              Constants
                                                                  .uploads +
                                                              Constants.event +
                                                              "/" +
                                                              myDatapast[index]
                                                                  ['image'],
                                                          fit: BoxFit.cover,
                                                          //  height: SizeConfig.screenHeight * .25,
                                                        ))),
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
