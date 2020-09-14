import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:volt/util/constants.dart';

import '../Methods.dart';

class AllBookings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AllBookingsState();
}

class AllBookingsState extends State<AllBookings> {
  int _page = 1;
  int _total = 1;
  ScrollController _sc = new ScrollController();
  bool _isLoading = false;

  var _all = true;
  var _trainers = false;
  var _groupClass = false;
  var _events = false;
  List _bookingList = List();

  void setBoolState(String type) {
    _all = false;
    _trainers = false;
    _groupClass = false;
    _events = false;

    _bookingList.clear();
    _page = 1;
    _total = 1;
    _isLoading = false;
    _modelType = type;
  }

  String _auth;
  String _modelType = 'all';

  @override
  void initState() {
    getString(USER_AUTH)
        .then((value) => _auth = value)
        .whenComplete(() => _getBookings(_auth));
    super.initState();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        if (_page <= _total) _getBookings(_auth);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    _page = 1;
    super.dispose();
  }

  void _getBookings(String auth) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, loading);
        if (!_isLoading) {
          setState(() {
            _isLoading = true;
          });

          Map<String, String> parms = {
            LIMIT: '20',
            PAGE: _page.toString(),
            'model_type': _modelType,
          };
          allBookingsApi(auth, parms).then((response) {
            if (response.status) {
              if (response.data != null) {
                _total = response.data.last_page;
                List tList = new List();

                for (int i = 0; i < response.data.data.length; i++) {
                  tList.add(response.data.data[i]);
                }

                setState(() {
                  _isLoading = false;

                  for (int index = 0; index < tList.length; index++) {
                    var name = 'Not Found';
                    var image = '';
                    var url = '';
                    var modelType = '';

                    if (tList[index]['model_detail'] != null) {
                      if (tList[index]['model_type'] == 'events') {
                        name = tList[index]['model_detail']['name'];
                        image = tList[index]['model_detail']['image'];
                        modelType = 'Event';
                        url = Constants.uploads + Constants.event + "/";
                      } else if (tList[index]['model_type'] ==
                          'class_schedules') {
                        print(tList[index]['model_detail'].toString());
                        if (tList[index]['model_detail']['class_detail'] !=
                            null) {
                          name = tList[index]['model_detail']['class_detail']
                              ['name'];
                          image = tList[index]['model_detail']['class_detail']
                              ['image'];
                          modelType = 'Class';
                          url = imageClassUrl;
                        }
                      } else {
                        name = tList[index]['model_detail']['full_name'];
                        image = tList[index]['model_detail']['image'];
                        modelType = 'Trainer';
                        url = trainerUser;
                      }
                    }

                    print('jugraj===>$name');
                    _bookingList.add(CustomBooking(
                        bookingId: tList[index]['id'].toString(),
                        bookingType: modelType,
                        name: name,
                        imgLink: image,
                        url: url,
                        bookingDate: tList[index]['created_at'],
                        serviceHours: tList[index]['hours'].toString()));
                  }

                  _page++;
                });
              }
            } else {
              if (response.error != null)
                showDialogBox(context, "Error!", response.error);
            }
          }).whenComplete(() => dismissDialog(context));
        }
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
      }
    });
  }

  void filterBottom(String title) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Padding(
                      child: Align(
                        child: Icon(Icons.close),
                        alignment: Alignment.topRight,
                      ),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            setBoolState('all');
                            _all = true;
                            _getBookings(_auth);
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          _all ? Colors.white : Colors.black),
                                ),
                              ),
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _all ? Colors.black : Colors.black26,
                                  shape: BoxShape.circle))),
                      GestureDetector(
                          onTap: () {
                            setBoolState('trainer_users');
                            _trainers = true;
                            _getBookings(_auth);
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Text(
                                  'Trainers',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: _trainers
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color:
                                      _trainers ? Colors.black : Colors.black26,
                                  shape: BoxShape.circle))),
                      GestureDetector(
                          onTap: () {
                            setBoolState("class_schedules");
                            _groupClass = true;
                            _getBookings(_auth);
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                              child: Center(
                                child: Text(
                                  'Group Classes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: _groupClass
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              height: 70,
                              width: 70,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _groupClass
                                      ? Colors.black
                                      : Colors.black26,
                                  shape: BoxShape.circle))),
                      GestureDetector(
                          onTap: () {
                            setBoolState('events');
                            _events = true;
                            _getBookings(_auth);
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Text(
                                  'Events',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: _events
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color:
                                      _events ? Colors.black : Colors.black26,
                                  shape: BoxShape.circle))),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25, bottom: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            baseImageAssetsUrl + 'logo_black.png',
                            height: 90,
                            color: Color(0xff8B8B8B),
                            width: 120,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 25, bottom: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            baseImageAssetsUrl + 'vector_lady.svg',
                            height: 90,
                            width: 120,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          volt_rights,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff8B8B8B),
                              fontSize: 8,
                              fontStyle: FontStyle.italic,
                              fontFamily: open_italic),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              )),
            ));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_bookingList != null) filterBottom('Choose Filter');
        },
        child: Image.asset(
          baseImageAssetsUrl + 'filter.png',
          height: 29,
          width: 29,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                backWithArrow(context),
                Spacer(),
//                GestureDetector(
//                    onTap: () => filterBottom('Choose Filter'),
//                    child: Icon(Icons.sort)),
//                SizedBox(
//                  width: 30,
//                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 72,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 0, 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      booking,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize22,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(baseImageAssetsUrl + 'bookings.svg'),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
            _bookingList != null && _bookingList.length > 0
                ? Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _sc,
                      itemCount: _bookingList == null ? 0 : _bookingList.length,
                      itemBuilder: (context, index) {
                        if (index == _bookingList.length) {
                          return buildProgressIndicator(_isLoading);
                        } else {
                          return Container(
                              margin: EdgeInsets.all(10),
                              child: BookingView(
                                customBooking: _bookingList[index],
                              ));
                        }
                      },
//              ),],
                    ),
                  )
                : Container(
                    height: SizeConfig.screenHeight * .7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          baseImageAssetsUrl + 'bookings.svg',
                          height: 100,
                          width: 100,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Bookings Not Found.',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class CustomBooking {
  final String imgLink;
  final String bookingId;
  final String name;
  final String serviceHours;
  final String bookingDate;
  final String bookingType;
  final String url;

  const CustomBooking({
    this.bookingId,
    this.bookingType,
    this.name,
    this.serviceHours,
    this.bookingDate,
    this.url,
    this.imgLink,
  });
}

class BookingView extends StatelessWidget {
  final VoidCallback callback;
  final CustomBooking customBooking;

  const BookingView({Key key, @required this.customBooking, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customBooking != null
        ? GestureDetector(
            onTap: callback,
            child: DottedBorder(
              borderType: BorderType.RRect,
              strokeWidth: 1,
              color: Colors.black38,
              radius: Radius.circular(8),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: SizeConfig.screenWidth * .6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Booking ID',
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 10),
                                ),
                                Text(
                                  customBooking.bookingId,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${customBooking.bookingType} Name',
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 10),
                                ),
                                Text(
                                  customBooking.name == null
                                      ? 'Name not found'
                                      : customBooking.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Service Hours',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 10),
                                        ),
                                        Text(
                                          customBooking.serviceHours == 'null'
                                              ? '--'
                                              : '${customBooking.serviceHours == null ? '' : customBooking.serviceHours} Hours',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Booking Date',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 10),
                                        ),
                                        Text(
                                          customBooking.bookingDate,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          customBooking.imgLink == null
                              ? Image.asset(
                                  baseImageAssetsUrl + 'logo_black.png',
                                  width: SizeConfig.screenWidth * .25,
                                  height: 110,
                                  fit: BoxFit.fill,
                                )
                              : FadeInImage.assetNetwork(
                                  placeholder:
                                      baseImageAssetsUrl + 'logo_black.png',
                                  image: BASE_URL +
                                      customBooking.url +
                                      customBooking.imgLink,
                                  height: SizeConfig.screenHeight * .13,
                                  fit: BoxFit.cover,
                                  width: SizeConfig.screenWidth * .28,
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
        : Center(
            child: Text(
              'No Data Found',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          );
  }
}
