import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/Bookings/select_session.dart';
import 'package:volt/GroupClasses/group_class_detail.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Screens/view_personal_trainer.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

int classId;

String imgClass = "";
String nameClass = "";

class GroupClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupClassState();
}

class GroupClassState extends State<GroupClass> {
  int page = 1;
  int totalPage = 1;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  String deleteId = "";

  int currentIndex = 0;
  var sendDateFormat = new DateFormat("yyyy-MM-dd");

  void _getList(String auth, int index, {var date}) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });

          Map<String, String> parms = {
            SEARCH: '',
            LIMIT: '10',
            if (date != null) Date: "$date",
            PAGE: index.toString()
          };
          getGroupClassListApi(auth, parms).then((response) {
            dismissDialog(context);

            //  buildProgressIndicatorCenter(isLoading);

            if (response.status) {
              if (response.data != null && response.data.data.length > 0) {
                totalPage = response.data.last_page;
                deleteId = response.data.is_booked_by_me_booking_id.toString();
                List tList = new List();
                for (int i = 0; i < response.data.data.length; i++) {
                  tList.add(response.data.data[i]);
                }

                setState(() {
                  isLoading = false;
                  firstLoading = false;
                  users.addAll(tList);
                  page++;
                });
              } else {
                setState(() {
                  isLoading = false;
                  firstLoading = false;
                  users.clear();
                });
              }
            } else {
              dismissDialog(context);
              if (response.error != null && response.error != "")
                showDialogBox(context, "Error!", response.error.toString());
            }
          });
        }
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  String auth = '';

  bool firstLoading = true;

  @override
  void initState() {
    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {_getList(auth, page)});

    super.initState();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        if (page <= totalPage) _getList(auth, page);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    page = 1;
    super.dispose();
  }

  void doYoWantToCntinue(bool _isBookedByMe, String id) {
    showCupertinoDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title:
                Text(_isBookedByMe ? "Booking cancel" : "Booking confirmation"),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Do you want to continue?",
                  style: TextStyle(wordSpacing: 1)),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "Yes",
                  style: TextStyle(color: CColor.CancelBTN),
                ),
                onPressed: () {
                  if (!_isBookedByMe) {
                    var isConfirmed = false;
                    bookingFunction(auth, context, eventKey, id, '')
                        .then((value) => isConfirmed = value)
                        .whenComplete(() => {
                              if (isConfirmed) {_isBookedByMe = true}
                            });
                    if (isConfirmed) {
                      setState(() {});
                    }
                  } else {
                    _deleteBooking(deleteId);
                  }
                },
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                child: Text(
                  "No",
                  style: TextStyle(color: CColor.CancelBTN),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  void _deleteBooking(String id) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Cancelling....");

        Map<String, String> parms = {
          'id': id,
        };
        bookingDeleteApi(auth, parms).then((response) {
          if (response.status) {
            if (response.data != null) {
              print(response.data.message);
              //
              users[currentIndex]['is_booked_by_me'] = false;
              setState(() {});
              Navigator.pop(context);
            }
          } else {
            if (response.error != null && response.error != "")
              showDialogBox(context, "Error!", response.error.toString());
          }
        }).whenComplete(() => dismissDialog(context));
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
      }
    });
  }

  DateTime _selectedValue;
  @override
  DatePickerController _datePickerController = DatePickerController();

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: NestedScrollView(
        controller: _sc,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: false,
              pinned: false,
              iconTheme: IconThemeData(color: Colors.transparent),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Card(
                  elevation: 2,
                  shadowColor: Colors.black26.withOpacity(.2),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Row(
                        children: <Widget>[
                          backWithArrow(context),
                          Spacer(),
                          SvgPicture.asset(
                              baseImageAssetsUrl + 'volt_service.svg'),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * .17,
                        child: Stack(
                          children: <Widget>[
                            // Positioned(
                            //     left: 0,
                            //     right: 0,
                            //     top: padding50,
                            //     child: Image.asset(
                            //       baseImageUrl + 'exc_sign.png',
                            //       height: 111,
                            //     )),
                            Positioned(
                              // left: 50,
                              // bottom: padding50 + padding30,
                              child: Image.asset(
                                'assets/images/voltLogoBanner.png',
                                width: SizeConfig.screenWidth,
                                height: 500,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black26,
                              ),
                            ),

                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 200,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     Image.asset(
                      //       baseImageAssetsUrl + 'voltLogoBanner.png',
                      //       fit: BoxFit.cover,
                      //       width: SizeConfig.screenWidth,
                      //       height: SizeConfig.screenHeight * .17,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 25),
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
                            groupClasses,
                            style: TextStyle(fontSize: 18),
                          ),

//            ListView.builder(itemBuilder: null)
                        ],
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     SizedBox(
                      //       width: SizeConfig.blockSizeHorizontal * 12,
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //         "We have a fantastic range of special Group classes designed to help you get fit and healthy while enjoying new daily challenges. why not make it fun?",
                      //         style: TextStyle(
                      //             color: CColor.LightGrey, fontSize: 10),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: SizeConfig.blockSizeHorizontal * 8,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => SelectSession(
                                        isGroupClass: false,
                                        isSession: true,
                                      )));
                        },
                        child: Container(
                            height: SizeConfig.screenHeight * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xff2C2C2C),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                )),
                            child: Center(
                              child: Text(
                                'Purchase Session',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              expandedHeight: SizeConfig.screenHeight * .42,
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    // SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Container(
                      height: SizeConfig.screenHeight * 0.14,
                      child: DatePicker(
                        DateTime.now(),
                        initialSelectedDate: _selectedValue != null
                            ? _selectedValue
                            : DateTime.now(),
                        selectionColor: Colors.black,
                        selectedTextColor: Colors.white,
                        width: SizeConfig.screenWidth * 0.13,
                        height: SizeConfig.screenHeight * 0.11,
                        controller: _datePickerController,
                        daysCount: 30,
                        onDateChange: (date) {
                          print(date);
                          // New date selected
                          setState(() {
                            if (_datePickerController != null) {
                              firstLoading = true;
                              users.clear();
                              _selectedValue = date;
                              page = 1;
                              totalPage = 1;
                              _datePickerController
                                  .animateToDate(date.add(Duration(days: 0)));
                              _getList(auth, page,
                                  date: sendDateFormat.format(date));
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    firstLoading
                        ? Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.10),
                                child: CircularProgressIndicator()),
                          )
                        : users.length > 0
                            ? Expanded(
                                flex: 5,
                                child: ListView.builder(
                                    itemCount: users.length + 1,
                                    // Add one more item for progress indicator
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == users.length) {
                                        if (isLoading)
                                          return buildProgressIndicatorCenter(
                                              isLoading);
                                        else {
                                          return buildProgressIndicatorCenter(
                                              isLoading);
                                          // return  Material(
                                          //   child: Center(
                                          //     child: Text("No Data Found",style: TextStyle(color:Colors.black),),
                                          //   ),
                                          // );
                                        }
                                      } else {
                                        if (users.length > 0) {

                                          imgClass = users[index]
                                              ['class_detail']['image'];
                                          nameClass = users[index]
                                              ['class_detail']['name'];
                                          return CustomGroupState(
                                            items: CustomGroupClass(
                                                duration: users[index]['trainer']
                                                        ['date_duration']
                                                    ['duration'],
                                                startTime: users[index]
                                                    ['start_time'],
                                                className: users[index]
                                                    ['class_detail']['name'],
                                                img: users[index]
                                                    ['class_detail']['image'],
                                                classOwner:
                                                    users[index]['trainer'] != null
                                                        ? users[index]['trainer']
                                                            ['first_name']
                                                        : '',
                                                endDate: users[index]
                                                    ['end_date'],
                                                startDate: users[index]
                                                    ['start_date'],
                                                classTime: users[index]['class_type'],
                                                is_booked_by_me: users[index]['is_booked_by_me'],
                                                id: users[index]['id'],
                                                leftSeats: users[index]['available_capacity'].toString()),
                                            deleteCallBack: () {
                                              currentIndex = index;

                                              deleteId = users[index][
                                                      'is_booked_by_me_booking_id']
                                                  .toString();
                                              if (users[index][
                                                              'available_capacity']
                                                          .toString() !=
                                                      '0' &&
                                                  !users[index]
                                                      ['is_booked_by_me']) {
                                                Navigator.push(
                                                    context,
                                                    ScaleRoute(
                                                        page: GroupClassDetail(
                                                      id: users[index]['id'],
                                                    )));
                                              } else {
                                                doYoWantToCntinue(
                                                    users[index]
                                                        ['is_booked_by_me'],
                                                    users[index]['id']
                                                        .toString());
                                              }
                                            },
                                          );
                                        } else {
                                          return Material(
                                            child: Center(
                                              child: Text(
                                                "No Data Found",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
//            controller: _sc,
                                    ),
                              )
                            : Center(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeConfig.screenHeight * 0.10),
                                    child: Text("No Classes Found")),
                              ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class CustomGroupClass {
  final String img;
  final int id;
  final String className;
  final String classOwner;
  final String classTime;
  final String leftSeats;
  final bool is_booked_by_me;
  final String startDate;
  final String endDate;
  final String duration;
  final String startTime;

  const CustomGroupClass(
      {this.img,
      this.duration,
      this.is_booked_by_me,
      this.className,
      this.id,
      this.classOwner,
      this.classTime,
      this.leftSeats,
      this.startDate,
      this.endDate,
      this.startTime});
}

class CustomGroupState extends StatefulWidget {
  final CustomGroupClass items;
  final VoidCallback deleteCallBack;

  const CustomGroupState({Key key, @required this.items, this.deleteCallBack})
      : super(key: key);

  @override
  _CustomGroupStateState createState() => _CustomGroupStateState();
}

class _CustomGroupStateState extends State<CustomGroupState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          widget.items.img == null
              ? Image.asset(
                  baseImageAssetsUrl + 'logo.png',
                  height: SizeConfig.blockSizeVertical * 25,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  fit: BoxFit.cover,
                )
              : blackPlaceHolder(
                  imageClassUrl,
                  widget.items.img,
                  SizeConfig.blockSizeVertical * 25,
                  SizeConfig.blockSizeHorizontal * 90),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.items.className,
            style: TextStyle(color: Colors.black.withOpacity(.9), fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Instructor",
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Text("${widget.items.classOwner}",
                      style: TextStyle(fontSize: 11)),
                  // FlatButton(
                  //     onPressed: () {},
                  //
                  //     child: FittedBox(
                  //       fit: BoxFit.cover,
                  //       child: Text(
                  //         "${widget.items.classOwner}",
                  //         style: TextStyle(fontSize: 12),
                  //       ),
                  //     )),
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text("Date",style: TextStyle(fontSize: 11,),),
                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.02,
                  // ),
                  // Text("${widget.items.startDate}",style: TextStyle(fontSize: 12,)),
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time", style: TextStyle(fontSize: 11)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Text("${(widget.items.startTime)} ",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Duration",
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Text("${widget.items.duration.toString()} MIN",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.06

                ,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Available Slots",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Text("${widget.items.leftSeats}",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width:widget.items.leftSeats != '0' && !widget.items.is_booked_by_me?SizeConfig.screenWidth * 0.40:SizeConfig.screenWidth * 0.80,
                  child: RaisedButton(
                      onPressed: widget.deleteCallBack,
                      color: widget.items.leftSeats != '0' &&
                              !widget.items.is_booked_by_me
                          ? Colors.black
                          : CColor.CancelBTN,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(button_radius)),
                      child: Center(
                        child: Text(
                          widget.items.leftSeats != '0'
                              ? !widget.items.is_booked_by_me
                                  ? 'View Detail'
                                  : 'Already booked! Do you want to cancel?'
                              : 'House Full',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  !widget.items.is_booked_by_me ? 14 : 10),
                        ),
                      )),
                ),
                Visibility(
                  visible: widget.items.leftSeats != '0' && !widget.items.is_booked_by_me,
                  child: Container(
                    width: SizeConfig.screenWidth * 0.40,
                    child: RaisedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YourBooking(
                                      isSession: false,
                                      id: widget.items.id,
                                      image:  widget.items.img,
                                      wantToShowPrice: false,
                                      isGroupClass: true,
                                      name:  widget.items.className,
                                      payment: "0",
                                      serviceHours: widget.items.duration,
                                    ))), //widget.deleteCallBack,
                        color: widget.items.leftSeats != '0' &&
                                !widget.items.is_booked_by_me
                            ? Colors.black
                            : CColor.CancelBTN,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(button_radius)),
                        child: Center(
                          child: Text(
                            widget.items.leftSeats != '0' ? !widget.items.is_booked_by_me
                                    ? 'Book'
                                    : 'UnBook'
                                : 'House Full',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    !widget.items.is_booked_by_me ? 14 : 10),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MySeparator(
            height: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
