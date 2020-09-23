import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/GroupClasses/group_class_detail.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

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

  void _getList(String auth, int index) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });

          Map<String, String> parms = {
            SEARCH: '',
            LIMIT: '10',
            PAGE: index.toString()
          };
          getGroupClassListApi(auth, parms).then((response) {
            dismissDialog(context);
            if (response.status) {
              if (response.data != null && response.data.data.length > 0) {
                totalPage = response.data.last_page;
                List tList = new List();
                for (int i = 0; i < response.data.data.length; i++) {
                  tList.add(response.data.data[i]);
                }

                setState(() {
                  isLoading = false;
                  users.addAll(tList);
                  page++;
                });
              }
            } else {
              dismissDialog(context);
              if (response.error != null)
                showDialogBox(context, "Error!", response.error);
            }
          });
        }
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  @override
  void initState() {
    String auth = '';

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

  @override
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
                      Image.asset(
                        baseImageAssetsUrl + 'fitness.png',
                        fit: BoxFit.cover,
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * .17,
                      ),
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
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 12,
                          ),
                          Expanded(
                            child: Text(
                              "We have a fantastic range of special Group classes current and recent activities. designed to help you enjoy your Volt membership to the max!'",
                              style: TextStyle(
                                  color: CColor.LightGrey, fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              expandedHeight: SizeConfig.screenHeight * .42,
            )
          ];
        },
        body: Material(
          color: Colors.white,
          child: ListView.builder(
            itemCount: users.length + 1,
            // Add one more item for progress indicator
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              if (index > 0 && index == users.length) {
                return buildProgressIndicatorCenter(isLoading);
              } else {
                return users.length > 0
                    ? CustomGroupState(
                        items: CustomGroupClass(
                            className: users[index]['class_detail']['name'],
                            img: users[index]['class_detail']['image'],
                            classOwner: users[index]['trainer'] != null
                                ? users[index]['trainer']['first_name']
                                : '',
                            classTime: users[index]['class_type'],
                            is_booked_by_me: users[index]['is_booked_by_me'],
                            id: users[index]['id'],
                            leftSeats:
                                users[index]['available_capacity'].toString()))
                    : Material(
                        color: Colors.white,
                        child: Center(
                          child: Text("No Data Found"),
                        ),
                      );
              }
            },
//            controller: _sc,
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

  const CustomGroupClass(
      {this.img,
      this.is_booked_by_me,
      this.className,
      this.id,
      this.classOwner,
      this.classTime,
      this.leftSeats});
}

class CustomGroupState extends StatelessWidget {
  final CustomGroupClass items;

  const CustomGroupState({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          items.img == null
              ? Image.asset(
                  baseImageAssetsUrl + 'logo_black.png',
                  height: SizeConfig.blockSizeVertical * 25,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  fit: BoxFit.cover,
                )
              : blackPlaceHolder(
                  imageClassUrl,
                  items.img,
                  SizeConfig.blockSizeVertical * 25,
                  SizeConfig.blockSizeHorizontal * 90),
          SizedBox(
            height: 20,
          ),
          Text(
            items.className,
            style: TextStyle(color: Colors.black.withOpacity(.9), fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.supervised_user_circle,
                    size: 15,
                  ),
                  label: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      items.classOwner.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_today,
                    size: 15,
                  ),
                  label: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      items.classTime.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.format_align_left,
                    size: 15,
                  ),
                  label: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      "${items.leftSeats} Seats Left",
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            child: RaisedButton(
                onPressed: () {
                  if (items.leftSeats != '0' && !items.is_booked_by_me)
                    Navigator.push(
                        context,
                        ScaleRoute(
                            page: GroupClassDetail(
                          id: items.id,
                        )));
                },
                color: items.leftSeats != '0' && !items.is_booked_by_me
                    ? Colors.black
                    : Colors.black45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(button_radius)),
                child: Center(
                  child: Text(
                    items.leftSeats != '0'
                        ? !items.is_booked_by_me ? 'View Detail' : alreadyBooked
                        : 'House Full',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
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