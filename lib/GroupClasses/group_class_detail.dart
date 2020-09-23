import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Bookings/select_session.dart';
import 'package:volt/GroupClasses/group_classes.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class GroupClassDetail extends StatefulWidget {
  final int id;

  const GroupClassDetail({this.id});

  @override
  State<StatefulWidget> createState() => _DetailState();
}

class _DetailState extends State<GroupClassDetail> {
  String auth = '';
  int id;
  String _roleType = '';

  String fullName = '',
      recurring = '',
      seatsLeft = '',
      duration = '',
      className = '',
      classDesc = '',
      startAndEndDate = '',
      classImage;

  @override
  void initState() {
    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {_getClassDetail(auth)});

    getString(roleType)
        .then((value) => {_roleType = value});
    super.initState();
  }

  void _getClassDetail(String auth) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");
        Map<String, String> parms = {
          ID: widget.id.toString(),
        };
        getGroupClassDetailApi(auth, parms).then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null && response.data.trainer != null) {
              fullName = response.data.trainer.full_name;
              id = response.data.id;
              className = response.data.class_detail.name;
              classImage = response.data.class_detail.image;
              classDesc = response.data.class_detail.description;
              startAndEndDate =
                  response.data.start_date + " - " + response.data.end_date;
              recurring = response.data.class_type;
              seatsLeft = response.data.available_capacity.toString();
              duration = response.data.duration;
              setState(() {});
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              children: <Widget>[
                backWithArrow(context),
                Spacer(),
                SvgPicture.asset(baseImageAssetsUrl + 'volt_service.svg'),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(height: 20),
            classImage == null
                ? Image.asset(
                    baseImageAssetsUrl + 'logo_black.png',
                    height: SizeConfig.blockSizeVertical * 25,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.cover,
                  )
                : blackPlaceHolder(imageClassUrl, classImage,
                    SizeConfig.blockSizeVertical * 25, SizeConfig.screenWidth),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.new_releases),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        className,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontFamily: open_semi_bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 6),
                    child: Text(
                      classDesc,
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF303030).withOpacity(.6)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'trainer.svg',
                          height: 20, width: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Trainer',
                          style: TextStyle(
                              color: Color(0xFF303030).withOpacity(.6),
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 280, top: 5),
                    child: MySeparator(
                      height: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 6),
                    child: Text(
                      fullName,
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: open_semi_bold,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF303030)),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Date of group class',
                          style: TextStyle(
                              color: Color(0xFF303030).withOpacity(.6),
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 180, top: 5),
                    child: MySeparator(
                      height: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 6),
                    child: Text(
                      startAndEndDate.toString().toUpperCase(),
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: open_semi_bold,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF303030)),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'cal.svg',
                          height: 20, width: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Recurring',
                          style: TextStyle(
                              color: Color(0xFF303030).withOpacity(.6),
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 250, top: 5),
                    child: MySeparator(
                      height: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 6),
                    child: Text(
                      recurring.toUpperCase(),
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: open_semi_bold,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF303030)),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'add.svg',
                          height: 20, width: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Slot in class',
                          style: TextStyle(
                              color: Color(0xFF303030).withOpacity(.6),
                              fontSize: 14),
                        ),
                      ),
                      SvgPicture.asset(
                        baseImageAssetsUrl + 'filling_fast.svg',
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 250,
                    ),
                    child: MySeparator(
                      height: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 6),
                    child: Text(
                      '${seatsLeft} SEATS left'.toUpperCase(),
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: open_semi_bold,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF303030)),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Duration in class',
                          style: TextStyle(
                              color: Color(0xFF303030).withOpacity(.6),
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 200, top: 5),
                    child: MySeparator(
                      height: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 6),
                    child: Text(
                      '${duration} min'.toUpperCase(),
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: open_semi_bold,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF303030)),
                    ),
                  ),
                ],
              ),
            ),
            MySeparator(
              height: 1,
              color: Colors.black45,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: SizeConfig.screenWidth * .7,
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        ScaleRoute(
                            page: SelectSession(
                          id: id,
                          image: classImage,
                          name: className,
                          isGroupClass: true,
                              roleType: _roleType,
                        )));
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(button_radius)),
                  child: Center(
                    child: Text(
                      'Join Class Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
