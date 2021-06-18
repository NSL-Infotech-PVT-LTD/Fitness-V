import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/AuthScreens/LoginScreen.dart';
import 'package:volt/Bookings/select_session.dart';
import 'package:volt/GroupClasses/group_classes.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import 'Cardio.dart';

String mySessionss;
class Home extends StatefulWidget {

  final image;
  final roleId;

  const Home({Key key, this.image, this.roleId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  String _planImage;
  String _rolePlan = "";
  String _planName = "";
  String _roleIdDash = "";
  String _roleCategory = "";
  String textFind;
  var sendDateFormat = new DateFormat("yyyy-MM-dd");
  var userViewFormate = new DateFormat("dd-MM-yyyy");
  DateTime todayDate = DateTime.now();

  List result;

  String _id;
  String validtill;

  String _trainerSlot;
  String _sessions;
  var difference = 0;
  bool isLoading = false;

  void initState() {

    if (widget.roleId == "8" ||widget.roleId=="9") {
      setState(() {
        isLoading = true;
      });
      setState(() {
        getString(USER_AUTH)
            .then((value) => getProfileDetailApi(value).then((response) {
          setState(() {
            if(value == null && value.isEmpty) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder :(BuildContext context)=>LoginScreen()));
            }

            if (response.data.user.my_sessions != null) {
              setString(trainer_slot, response.data.user.trainer_slot.toString());
            }
            setString(validTill, response.data.user.role_expired_on);
            _sessions = response.data.user.my_sessions.toString();
            print("sessions"+_sessions);
            setState(() {
              isLoading = false;
            });
          });
        }));
        getString(Id)
            .then((value) => {_id = value})
            .whenComplete(() => setState(() {
          print("chekc id" + _id);
        }));
        getString(roleIdDash)
            .then((value) => {_roleIdDash = value})
            .whenComplete(() => setState(() {
          print("roleIdDash" + _roleIdDash);
        }));
        getString(mySessions)
            .then((value) => {mySessionss = value})
            .whenComplete(() => setState(() {
          print("mySessionss " + mySessionss);
        }));
        getString(trainer_slot)
            .then((value) => {_trainerSlot = value})
            .whenComplete(() => setState(() {
          print("trainerSlot " + _trainerSlot);
        }));

      });

    }else{
      setState(() {
        isLoading = true;
      });

      getString(USER_AUTH).then((value) => getProfileDetailApi(value).then((response) {
        setState(() {
          // setString(USER_AUTH, "Bearer " + response.data.token);
          setString(roleType, response.data.user.role.name);
          // getRoleApi(context,response.data.user.role.nameFilter);
          if (response.data != null && response.data.user != null)
            setString(userImage, response.data.user.image);
          if (response.data != null && response.data.user != null)
            setString(id, response.data.user.id.toString());

          print("roleIdCheck" + response.data.user.role.id.toString());
          setString(roleIdDash, response.data.user.role.id.toString());
          setString(poolOrGym, response.data.user.role.nameFilter);
          if (response.data.user.my_sessions != null) {
            setString(mySessions, response.data.user.my_sessions.toString());
          }if (response.data.user.my_sessions != null) {
            setString(trainer_slot, response.data.user.trainer_slot.toString());
          }
          if (response.data.user.role != null) {
            print("roleID "+"${response.data.user.role.toJson().toString()}");

            setString(userPlanImage, response.data.user.role.image);
            setString(roleName, response.data.user.role.name);
            setString(Id, response.data.user.id.toString());

            setString(validTill, response.data.user.role_expired_on);

            setString(roleCategory, response.data.user.role.category);
            if (response.data.user.role.current_plan != null) {
              setString(rolePlan, response.data.user.role.current_plan.role_plan);

            }
          }
          setString(USER_NAME, response.data.user.full_name);
        });
      })).whenComplete(() {
        setState(() {

          getString(roleName)
              .then((value) => {_planName = value})
              .whenComplete(() => setState(() {}));

          getString(Id)
              .then((value) => {_id = value})
              .whenComplete(() => setState(() {
            print("chekc id" + _id);
          }));

          getString(roleIdDash)
              .then((value) => {_roleIdDash = value})
              .whenComplete(() => setState(() {
            print("roleIdDash" + _roleIdDash);
          }));
          // getString(sessions)
          //     .then((value) => {_sessions = value.toString()})
          //     .whenComplete(() => setState(() {
          //       print("_sessions" + _sessions);
          // }));
          getString(validTill).then((value) {
            validtill = value;
            DateTime newTime = DateTime.parse(validtill);
            DateTime newTimeOne = DateTime.parse(todayDate.toString());
            difference = newTime.difference(newTimeOne).inDays;

            print("Difference $difference");

            todayDate.compareTo(newTime)  ;
          });

          getString(trainer_slot)
              .then((value) => {_trainerSlot = value})
              .whenComplete(() => setState(() {
            print("trainerSlot " + _trainerSlot);
          }));
          getString(mySessions)
              .then((value) => {mySessionss = value})
              .whenComplete(() => setState(() {
            print("mySessionss " + mySessionss);
          }));

          getString(userPlanImage)
              .then((value) => {_planImage = value})
              .whenComplete(() => setState(() {}));

          getString(rolePlan)
              .then((value) => {_rolePlan = value})
              .whenComplete(() => setState(() {

            if(_rolePlan !=null && _rolePlan.contains(":"))
              result = _rolePlan.split(":");
            //print("print "+ result[0]);

            //_rolePlan == "quarterly"?"3 months":_rolePlane == "half_yearly"?"6 months":_rolePlan == "yearly"?"Annual":_rolePlan,
          }));

          getString(roleCategory)
              .then((value) => {_roleCategory = value});
        });
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isLoading
        ? Center(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.30,),
                CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              ],
            ))
        : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  width: SizeConfig.screenWidth * 0.90,
                  height: SizeConfig.screenHeight * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      8.0,
                      0.0,
                      8.0,
                      6.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _roleIdDash != "8" &&  _roleIdDash != "9"?
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child:
                                  difference>7?
                                  SvgPicture.asset(
                                      baseImageAssetsUrl +'activePlan.svg'): SvgPicture.asset(baseImageAssetsUrl +'expiredclass.svg')):  SvgPicture.asset(
                                    baseImageAssetsUrl +'activePlan.svg'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Image.asset(
                                    baseImageAssetsUrl + "logo.png",
                                    height: 80,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            widget.image == null
                                ? Padding(
                              padding: EdgeInsets.only(top: 10.0,right: 9.0),
                              child: SvgPicture.asset(
                                baseImageAssetsUrl + 'place_holder.svg',
                                height: 80,
                                // width: 40,
                              ),
                            )
                                : Padding(
                              padding:
                              EdgeInsets.only(top: 20.0, right: 9.0),
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(
                                  BASE_URL +
                                      'uploads/image/' + widget.image,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: true,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _roleIdDash == "8"
                                            ? "Guest ID"
                                            : _roleIdDash == "9"
                                            ? "Fairmont ID"
                                            : "Member ID",
                                        style: TextStyle(
                                            color: Color(0xFF727272),
                                            fontSize: 12,
                                            fontFamily:
                                            "fonts/open_semi_bold.ttf"),
                                      ),
                                      Container(
                                        width: _roleIdDash == "8" ? SizeConfig.screenWidth * 0.21
                                            : SizeConfig.screenWidth * 0.19,
                                        child: Divider(),
                                      ),
                                      Text(//VFG
                                        "${ _roleIdDash == "8"? "GUEST": _roleIdDash == "9" ? "VFFG": "VFM"}${_id == null || _id.isEmpty ? "Not found" : _id}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Valid til",
                                      style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 12,
                                          fontFamily: "fonts/open_semi_bold.ttf"),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.20,
                                      child: Divider(),
                                    ),
                                    Text(
                                      validtill != null && validtill.isNotEmpty ? " ${validtill.toString().replaceAll("from now", "")}" : "--:--",

                                      style: TextStyle(color: Colors.black, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: true,//_roleIdDash != "8",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Plan",
                                      style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 12,
                                          fontFamily: "fonts/open_semi_bold.ttf"),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.22,
                                      child: Divider(),
                                    ),
                                    Text(
                                      "${result == null && (_rolePlan == null || _rolePlan.isEmpty) ? "--:--" : result[0].toString() == "quarterly" ? "3 Months" : result[0].toString() == "half_yearly" ? "6 Months" : result[0].toString() == "yearly" ? "Annual" : _rolePlan}", //: ${result[1].toString()}
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:  true,//_roleIdDash != "8" && _roleIdDash != "9",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PT",
                                      style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 12,
                                          fontFamily: "fonts/open_semi_bold.ttf"),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.10,
                                      child: Divider(),
                                    ),
                                    Text(
                                      _trainerSlot != null? " ${_trainerSlot.toString()}" : "--:--",
                                      style: TextStyle(color: Colors.black, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),   Visibility(
                                visible: _roleIdDash != "8" && _roleIdDash != "9",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "GX",
                                      style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 12,
                                          fontFamily: "fonts/open_semi_bold.ttf"),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.15,
                                      child: Divider(),
                                    ),
                                    Text(
                                      mySessionss != null && mySessionss.isNotEmpty ? " ${mySessionss.toString()}" : "--:--",
                                      style: TextStyle(color: Colors.black, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),

                              //For Role id == 8

                              Visibility(
                                visible: _roleIdDash == "8" || _roleIdDash == "9" ,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "GX",
                                      style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 12,
                                          fontFamily: "fonts/open_semi_bold.ttf"),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.31,
                                      child: Divider(),
                                    ),
                                    Text(
                                      _sessions != null && _sessions.isNotEmpty
                                          ? " ${_sessions.toString()}"
                                          : "--:--",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),

                              // Visibility(
                              //   visible: _roleIdDash == "8",
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text("Left Session",style: TextStyle(color:Color(0xFF727272),fontSize: 12,fontFamily: "fonts/open_semi_bold.ttf"),),
                              //       Container(
                              //         width: SizeConfig.screenWidth * 0.30,
                              //         child:Divider(),
                              //       ),
                              //       Text("${_rolePlan == null || _rolePlan.isEmpty ? "" : result[0].toString() == "quarterly"?"3 months :${result[1].toString()}":result[0].toString() == "half_yearly"?"6 months : ${result[1].toString()}":result[0].toString() == "yearly"?"Annual : ${result[1].toString()}":_rolePlan}", style: TextStyle(color: Colors.black,fontSize: 12),),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
//                Text(_rolePlan == null || _rolePlan.isEmpty ? "" : _rolePlan),,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Visibility(
                  visible: widget.roleId != "8",//|| widget.roleId=="9",
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        height: .5,
                        color: CColor.PRIMARYCOLOR,
                      ),


                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.blockSizeVertical * 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          child: Stack(children: <Widget>[
                            Positioned(
                              bottom: 6,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  baseImageAssetsUrl + 'session.png',
                                  height: SizeConfig.blockSizeVertical * 25,
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // SvgPicture.asset(
                            //   baseImageAssetsUrl + 'active.svg',
                            // ),
                            Positioned(
                              bottom: 6,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Image.asset(
                                    'assets/images/gredient.png',
                                    height: SizeConfig.blockSizeVertical * 25,
                                    width: SizeConfig.blockSizeHorizontal * 90,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Positioned(
                              bottom: 85,
                              left: 40,
                              child: Text(
                                Personal_trainer,
                                style: TextStyle(
                                    color: Colors.white, fontSize: textSize22),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 70,
                            //   left: 40,
                            //   child: Text(
                            //     'Check out our group classes and best offers',
                            //     style: TextStyle(color: Colors.white, fontSize: 10),
                            //   ),
                            // ),
                            Positioned(
                              bottom: 0,
                              left: 20,
                              width: SizeConfig.blockSizeHorizontal * 90,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {

                                Dashboard.of(context).onTabTappedNew = 1;

                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) => SelectSession(
                                  //           isGroupClass: false,
                                  //           isSession: true,
                                  //         )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff2C2C2C),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(7),
                                            bottomRight: Radius.circular(7))),
                                    child: Center(
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              ),
                            ),
                          ])),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,

                ),
                Divider(
                  height: .5,
                  color: CColor.PRIMARYCOLOR,
                ),
                // Container(
                //           width: SizeConfig.screenWidth,
                //           height: SizeConfig.blockSizeVertical * 25,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.only(
                //                   bottomLeft: Radius.circular(5),
                //                   bottomRight: Radius.circular(5))),
                //           child: Stack(children: <Widget>[
                //             Positioned(
                //               bottom: 6,
                //               child: Padding(
                //                 padding: EdgeInsets.only(left: 20, right: 20),
                //                 child: _planImage == null
                //                     ? Image.asset(
                //                   baseImageAssetsUrl + 'two_lady.jpg',
                //                   height: SizeConfig.blockSizeVertical * 25,
                //                   width: SizeConfig.blockSizeHorizontal * 90,
                //                   fit: BoxFit.cover,
                //                 )
                //                     : blackPlaceHolder(
                //                     baseImageAssetsUrl,
                //                     _planImage,
                //                     SizeConfig.blockSizeVertical * 25,
                //                     SizeConfig.blockSizeHorizontal * 90),
                //               ),
                //             ),
                //             Positioned(
                //               bottom: 6,
                //               child: Padding(
                //                   padding: EdgeInsets.only(left: 20, right: 20),
                //                   child: Image.asset(
                //                     'assets/images/gredient.png',
                //                     height: SizeConfig.blockSizeVertical * 25,
                //                     width: SizeConfig.blockSizeHorizontal * 90,
                //                     fit: BoxFit.fill,
                //                   )),
                //             ),
                //             Positioned(
                //               bottom: 65,
                //               left: 40,
                //               child: Text(
                //                 "Active Plan",
                //                 style: TextStyle(color: Colors.white, fontSize: textSize22),
                //               ),
                //             ),
                //             Positioned(
                //               bottom: 45,
                //               left: 40,
                //               child: Text(
                //                 "Plan Name : ${_planName == null || _planName.isEmpty ? "Not found" : _planName}",
                //                 style: TextStyle(color: Colors.white, fontSize: textSize14),
                //               ),
                //             ),
                //             Positioned(
                //               bottom: 31,
                //               left: 40,
                //               child: Text(
                //                 _roleCategory != null && _roleCategory.isNotEmpty?"Category : $_roleCategory":"",
                //                 style: TextStyle(
                //                     color: Colors.white.withOpacity(.9), fontSize: 10),
                //               ),
                //             ),
                //             Positioned(
                //               bottom: 15,
                //               left: 40,
                //               child: Text(
                //
                //                 "${_rolePlan == null || _rolePlan.isEmpty ? "" : result[0].toString() == "quarterly"?"3 months : ${result[1].toString()}":result[0].toString() == "half_yearly"?"6 months : ${result[1].toString()}":result[0].toString() == "yearly"?"Annual : ${result[1].toString()}":_rolePlan}",
                //                 style: TextStyle(
                //                     color: Colors.white.withOpacity(.8), fontSize: 10),
                //               ),
                //             ),
                //           ])),
                SizedBox(
                  height: 15,
                ),


                Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.blockSizeVertical * 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Stack(children: <Widget>[
                      Positioned(
                        bottom: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset(
                            baseImageAssetsUrl + 'group_class.png',
                            height: SizeConfig.blockSizeVertical * 25,
                            width: SizeConfig.blockSizeHorizontal * 90,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        baseImageAssetsUrl + 'active.svg',
                      ),
                      Positioned(
                        bottom: 6,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Image.asset(
                              'assets/images/gredient.png',
                              height: SizeConfig.blockSizeVertical * 25,
                              width: SizeConfig.blockSizeHorizontal * 90,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        bottom: 85,
                        left: 40,
                        child: Text(
                          groupClasses,
                          style: TextStyle(
                              color: Colors.white, fontSize: textSize22),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 40,
                        child: Text(
                          'Check out our group classes and best offers',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => GroupClass()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff2C2C2C),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7))),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )),
                        ),
                      ),
                    ])),

                footer(),
                SizedBox(
                  height: 20,
                ),
                // Divider(
                //   height: .5,
                //   color: CColor.PRIMARYCOLOR,
                // ),
                SizedBox(
                  height: 20,
                ),
//        Container(
//            padding: EdgeInsets.all(20),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SvgPicture.asset(
//                  baseImageAssetsUrl + 'filling_fast.svg',
//                  height: 30,
//                  fit: BoxFit.cover,
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                _planImage == null
//                    ? Image.asset(
//                        baseImageAssetsUrl + 'logo.png',
//                        height: SizeConfig.blockSizeVertical * 25,
//                        width: SizeConfig.blockSizeHorizontal * 90,
//                        fit: BoxFit.fill,
//                      )
//                    : blackPlaceHolder(
//                        IMAGE_URL,
//                        _planImage,
//                        SizeConfig.blockSizeVertical * 25,
//                        SizeConfig.blockSizeHorizontal * 90),
//                Text(_planName == null || _planName.isEmpty ? "" : _planName),
//                Text(_rolePlan == null || _rolePlan.isEmpty ? "" : _rolePlan),
//                SizedBox(
//                  height: 5,
//                ),
//              ],
//            )),
              ],
            ),
          );
  }

}

