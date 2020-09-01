import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/MemberDashboard/DashboardChild/Event/eventDetail.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/util/constants.dart';
import 'package:volt/util/networkutil.dart';

class EventClass extends StatefulWidget {

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<EventClass> with SingleTickerProviderStateMixin {
  TabController controller;

  int pagePast = 1;
  int totalPagePast = 1;
  ScrollController _scPast = new ScrollController();
  bool isLoadingPast = false;

  NetworkUtil _netUtil = new NetworkUtil();
  Map<String, dynamic> data;
  List<dynamic> myData = new List<dynamic>();
  List<dynamic> myDatapast = new List<dynamic>();

  //myDatapast

  // SharedPreferences variables
  SharedPreferences prefs;

  var apiResponse;

  @override
  void initState() {
    String auth = '';
    getString(USER_AUTH).then((value) {
      auth = value;
    }).whenComplete(() => {
          _createveentsupcomingList(auth, pagePast),
          _createveentspastList(auth)
        });

    super.initState();
    controller = TabController(length: 2, vsync: this);

    _scPast.addListener(() {
      if (_scPast.position.pixels == _scPast.position.maxScrollExtent) {
        if (pagePast <= totalPagePast)
          _createveentsupcomingList(auth, pagePast);
      }
    });
  }

  @override
  void dispose() {
    _scPast.dispose();
    pagePast = 1;
    super.dispose();
  }

  void _createveentsupcomingList(String auth, int index) async {
    showProgress(context, 'Loading..');
    if (!isLoadingPast) {
      setState(() {
        isLoadingPast = true;
      });
      _netUtil
          .post(context, Constants.event, auth, body: {
            "order_by": "upcoming",
            LIMIT: '10',
            PAGE: index.toString(),
          })
          .then((response) async {
            dismissDialog(context);
            var extracted = json.decode(response.body);

            if ((extracted["code"] == 200)) {
              setState(() {
                apiResponse = extracted['data'];

//          myData = apiResponse['data'] as List;
                totalPagePast = extracted['data']['last_page'];
                List tList = new List();
                for (int i = 0; i < (apiResponse['data'] as List).length; i++) {
                  tList.add((apiResponse['data'] as List)[i]);
                }

                print(totalPagePast.toString() + "========>.>>>");

                setState(() {
                  isLoadingPast = false;
                  myData.addAll(tList);
                  pagePast++;
                });
              });
            } else {
              setState(() {});
            }
          })
          .whenComplete(() => dismissDialog(context))
          .catchError((error) {
            setState(() {});
            print(error.toString());
          })
          .whenComplete(() => dismissDialog(context));
    }
  }

  ///past
  void _createveentspastList(String auth) async {
//    showProgress(context, 'Loading..');
    _netUtil.post(context, Constants.event, auth, body: {
      "order_by": "past",
    }).then((response) async {
      print("S`anjeev-->" + myData.length.toString());

      var extracted = json.decode(response.body);

      if ((extracted["code"] == 200)) {
        setState(() {
               apiResponse = extracted['data'];
          //   print(apiResponse);
          myDatapast = apiResponse['data'] as List;
        });
        // TODO: Add code for the No Blocked Users scenario.
      } else {
        setState(() {});
      }

      //    print(widget.name,);
      //  print('------------Ended _getEvetsList()-------------');
    }).catchError((error) {
      setState(() {});
      print(error.toString());
    }).whenComplete(() => dismissDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: TextStyle(
                                      color: CColor.LightGrey, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    expandedHeight: 300.0,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(10.0),
                      // Add this code
                      child: Container(
                        color: Color(0xffE1E1E1),
                        width: SizeConfig.screenWidth,
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          unselectedLabelColor: Color(0xFFC1C1C1),
                          labelColor: Colors.black,
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
                          controller: controller,
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: DefaultTabController(
                length: 2,
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    myData.length == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Image.asset(baseImageAssetsUrl + 'no_event.png'),
                          )
                        : ListView.builder(
                            itemCount: myData.length,
                            // Add one more item for progress indicator
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            itemBuilder: (context, index) {
                              if (index == myData.length) {
                                return buildProgressIndicator(isLoadingPast);
                              } else {
                                return new GestureDetector(
                                  child: Column(
                                    //    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            //   color: Colors.red,
                                            height: SizeConfig.screenHeight * 0.22,
                                            width: SizeConfig.screenWidth,
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      ScaleRoute(
                                                          page: EventDetail(
                                                        id: myData[index]['id'],
                                                        status: upcoming,
                                                      )));
                                                },
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: baseImageAssetsUrl +
                                                      'logo_white.png',
                                                  image: BASE_URL +
                                                      Constants.uploads +
                                                      Constants.event +
                                                      "/" +
                                                      myData[index]['image'],
                                                  fit: BoxFit.cover,
                                                  //  height: SizeConfig.screenHeight * .25,
                                                )),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 20, bottom: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              //    mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    //      color:Colors.red,
                                                    //   padding: EdgeInsets.only(left:10),
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      myData[index]['name'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22.0),
                                                    )),
                                                SizedBox(
                                                    width:
                                                        SizeConfig.screenWidth * 0.2,
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
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      myData[index]['description'],
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: Colors.white,
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
                              }
                            }),
                    myDatapast.length == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Image.asset(baseImageAssetsUrl + 'no_event.png'),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(8),
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
                                          height: SizeConfig.screenHeight * 0.22,
                                          width: SizeConfig.screenWidth,
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    ScaleRoute(
                                                        page: EventDetail(
                                                      id: myDatapast[index]['id'],
                                                      status: recent,
                                                    )));
                                              },
                                              child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.grey,
                                                    BlendMode.saturation,
                                                  ),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: baseImageAssetsUrl +
                                                        'logo_black.png',
                                                    image: BASE_URL +
                                                        Constants.uploads +
                                                        Constants.event +
                                                        "/" +
                                                        myDatapast[index]['image'],
                                                    fit: BoxFit.cover,
                                                    //  height: SizeConfig.screenHeight * .25,
                                                  ))),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 20, bottom: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            //    mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  //      color:Colors.red,
                                                  //   padding: EdgeInsets.only(left:10),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    myDatapast[index]['name'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22.0),
                                                  )),
                                              SizedBox(
                                                  width: SizeConfig.screenWidth * 0.2,
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
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    myDatapast[index]['description'],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: Colors.white,
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
              ),
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
