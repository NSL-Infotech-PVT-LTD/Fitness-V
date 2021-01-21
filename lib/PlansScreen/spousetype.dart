import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/AuthScreens/SuccessScreen.dart';
import 'package:volt/Screens/view_personal_trainer.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../AuthScreens/SignupScreen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:volt/Methods.dart';
import '../Methods/Method.dart';
import '../Methods/api_interface.dart';
import '../Value/Strings.dart';
import 'package:volt/Methods/gymModal.dart';
import 'package:http/http.dart' as http;

class SpouseType extends StatefulWidget {
  final roleIds;
  final rolePlanIds;
  List response;
  String type = "";
  int memberCount = 0;
  final gym_members;
  int plan_index = 0;
  var roleId;

  List<String> childValue;

  SpouseType(
      {this.response,
      this.plan_index,
      this.type,
      this.roleId,
      this.gym_members,
      this.memberCount,
      this.roleIds,
      this.rolePlanIds});

  @override
  _SpouseTypeState createState() => _SpouseTypeState();
}

class _SpouseTypeState extends State<SpouseType> {
  bool acceptTerms = false;
  double setWidth;
  bool _isIos;
  String deviceType = '';
  var roleId;
  bool isApiHit = false;

  String deviceToken = "";
  var errorMessage = '';
  var errorMessage1 = '';
  List<dynamic> data = [];
  var chooseChilds = false;
  int valueNew = -1;
  int selectChildIndex = -1;
  int childValueCount = 0;
  var price = 0;
  var newprice;
  var Totalprice = 0;
  List<String> childValue = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List<String> memberName = ['Spouse#1', 'Spouse#2'];

  var rolePlanId;

  var rolePlanFee = null;
  var roleIdrole;

  List<Map<String, dynamic>> result = [];
  List myResult;
  int index = 0;
  var totalMoney;

  var _scaffoldState = GlobalKey<ScaffoldState>();

  List<dynamic> stoData = ['', '', '', '', '', '', '', '', '', '', '', ''];

  @override
  void initState() {
    print("ch" + widget.rolePlanIds.toString());
    print("chP " + widget.roleId.toString());
    childValueCount = widget.memberCount - 2;
    for (int i = 0; i < widget.memberCount; i++) {
      result.add({});
    }
    valueNew = childValueCount;
    var myLength = valueNew + 2;
    print("$childValueCount   $myLength");
    if (result.length < myLength) {
      for (int i = result.length; i < myLength; i++) {
        result.add({});
      }
    } else {
      for (int i = result.length; i > myLength; i--) {
        result.removeAt(i - 1);
      }
    }
    print("vikas $result");

    if (memberName.length > 2) {
      memberName.removeRange(2, memberName.length);
    }
    // print('part $valueNew');
    // print('part $stoData');
    //
    for (int i = (valueNew + 3); i < stoData.length; i++) {
      stoData[i] = '';
    }
    // print('part1 $stoData');
    for (int i = 1; i <= valueNew; i++) {
      memberName.add('Child#$i');
    }

    print(result);
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';
    super.initState();
    print(widget.gym_members);
  }

  childPopUp() {
    customBottomSheet(
      data: data,
      context: context,
      getValue: () {
        setState(() {
          valueNew = childValueCount;
          var myLength = valueNew + 2;
          print("$childValueCount   $myLength");
          if (result.length < myLength) {
            for (int i = result.length; i < myLength; i++) {
              result.add({});
            }
          } else {
            for (int i = result.length; i > myLength; i--) {
              result.removeAt(i - 1);

            }
          }
          print("vikas $result");

          if (memberName.length > 2) {
            memberName.removeRange(2, memberName.length);
          }
          // print('part $valueNew');
          // print('part $stoData');
          //
          for (int i = (valueNew + 3); i < stoData.length; i++) {
            stoData[i] = '';
          }
          // print('part1 $stoData');
          for (int i = 1; i <= valueNew; i++) {
            memberName.add('Child#$i');
          }
          // // print('after');
          // // print(memberName);
          chooseChilds = false;
          valueNew = -1;
        });
        Navigator.pop(context);
      },
    );
  }

  getMemberShipData() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");
        Map<String, String> param = {
          "type": widget.gym_members.toString(),
          "user_with_child_only": "true",
        };
        gRoles(param).then((response) {
          if (response.status) {
            if (response.data != null) {
              print("newData" + response.data.toString());
              dismissDialog(context);
              setState(() {
                isApiHit = true;
                data = response.data;
              });
            }
            setState(() {});
          } else {
            dismissDialog(context);
          }
        }).whenComplete(() {
          childPopUp();
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  _navigateAndDisplaySelection(
      {int ind,
      BuildContext context,
      String formType,
      Map<String, String> chFilledData,
      roleSId,
      rolePanId}) async {
    print("current Index $ind");
    this.index = ind;

    myResult = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
              rolePlanId: widget.rolePlanIds,
              roleId: widget.roleId,
              memberIndex: index,
              formType: formType,
              // type: widget.type,
              editData: chFilledData,
              isSingle: false,
              isCityTrue: true,
              isEmailError: errorMessage1.contains("email has") ? true : false,
              profileImage: myResult != null && myResult.length > 1 ? myResult[1]
                  : null)),
    );

    setState(() {
      if (myResult != null) {
        // price = myResult['trainerPrice'];

        result[index] = myResult[0];

        print("fsdfsdf${myResult.length}");
        Totalprice = 0;
        result.forEach((element) {
          Totalprice = Totalprice +
              int.parse(
                  "${element['trainerPrice'] != null && element['trainerPrice'] != "null" ? (element['trainerPrice']) : 0}");
        });
      }
      // if (result.length>0) {
      //   stoData[int.parse(result[index]['memberIndex'])] = result;
      // }

      print('part $stoData');
    });
  }

  // _navigateAndDisplaySelection1(BuildContext context, String formType) async {
  //   result1 = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => SignupScreen(
  //               formType: formType,
  //               editData: result1,
  //               isSingle: false,
  //               isCityTrue: false,
  //               isEmailError: errorMessage1.contains("email 1") ? true : false,
  //             )),
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    //  rolePlanId = widget.response[widget.plan_index]['id'].toString();

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          if (result != null) {
            exitDialog(context);
            return new Future(() => false);
          } else {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          key: _scaffoldState,
          backgroundColor: CColor.WHITE,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: topMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.fromLTRB(padding20, padding10, padding30, 0),
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
                            'Back',
                            style: TextStyle(fontSize: textSize20),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),

                  Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/two_lady.jpg',
                        width: SizeConfig.screenWidth,
                        height: 234,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Container(
                    height: 72,
                    width: SizeConfig.screenWidth,
                    color: Colors.black,
                    padding: EdgeInsets.only(left: padding25),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            child: Text(
                              fill,
                              style: TextStyle(
                                color: CColor.WHITE,
                                fontSize: textSize14,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              padding: EdgeInsets.only(
                                  right: padding25, top: padding20),
                              child: Text(
                                //couple +
                                // widget.response[widget.plan_index]['fee_type'],
                                widget.response[widget.plan_index]
                                            ['fee_type'] ==
                                        "quarterly"
                                    ? "3 Months"
                                    : widget.response[widget.plan_index]
                                                ['fee_type'] ==
                                            "half_yearly"
                                        ? "6 Months"
                                        : widget.response[widget.plan_index]
                                                    ['fee_type'] ==
                                                "yearly"
                                            ? "Annual"
                                            : widget.response[widget.plan_index]
                                                ['fee_type'],
                                style: TextStyle(
                                  color: CColor.WHITE,
                                  fontSize: textSize10,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black,
                              padding: EdgeInsets.only(right: padding25),
                              child: Row(
                                children: [
                                  Text(
                                    aed +
                                        "${rolePlanFee != null ? rolePlanFee.toString() : widget.response[widget.plan_index]['fee']}",
                                    // aed + "${rolePlanFee != null ? rolePlanFee.toString() : widget.response[widget.plan_index]['fee']} ${Totalprice != null ?  Totalprice.toString() : ""}",
                                    style: TextStyle(
                                      color: CColor.WHITE,
                                      fontSize: textSize18,
                                    ),
                                  ),
                                  Visibility(
                                    visible: Totalprice != 0,
                                    child: Text(
                                      " + ${Totalprice.toString()}",
                                      style: TextStyle(
                                        color: CColor.WHITE,
                                        fontSize: textSize18,
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
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      padding: EdgeInsets.all(8.0),
                      itemCount: memberName.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          height: SizeConfig.screenHeight * 0.20,
                          width: SizeConfig.screenWidth * 0.40,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                                width: result[index] != null &&
                                        result[index].isNotEmpty
                                    ? result[index]['memberIndex'] ==
                                            index.toString()
                                        ? 2.0
                                        : 1.5
                                    : 1.5,
                                color: result[index] != null &&
                                        result[index].isNotEmpty
                                    ? result[index]['memberIndex'] ==
                                            index.toString()
                                        ? Colors.white
                                        : Color(0xFFBDBDBD)
                                    : Color(0xFFBDBDBD)),
                            borderRadius: BorderRadius.circular(5.0),
                            color: result[index] != null &&
                                    result[index].isNotEmpty
                                ? result[index]['memberIndex'] ==
                                        index.toString()
                                    ? Colors.black
                                    : Colors.white
                                : Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
//
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 2,
                                  ),
                                  Text(
                                    result[index] != null &&
                                            result[index].isNotEmpty
                                        ? result[index]['memberIndex'] ==
                                                index.toString()
                                            ? result[index]['memberIndex'] ==
                                                    '0'
                                                ? result[index][FIRSTNAME]
                                                    .toString()
                                                    .toUpperCase()
                                                : result[index][FIRSTNAME +
                                                        '_' +
                                                        index.toString()]
                                                    .toString()
                                                    .toUpperCase()
                                            : memberName[index]
                                        : memberName[index],
                                    style: TextStyle(
                                      color: result[index] != null &&
                                              result[index].isNotEmpty
                                          ? result[index]['memberIndex'] ==
                                                  index.toString()
                                              ? Colors.white
                                              : Colors.black
                                          : Colors.black,
                                      fontSize: textSize12,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      baseImageAssetsUrl + 'user.svg',
                                      color: result[index] != null &&
                                              result[index].isNotEmpty
                                          ? result[index]['memberIndex'] ==
                                                  index.toString()
                                              ? Colors.white
                                              : Colors.black
                                          : Colors.black,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    //   print("ffsjbjfb ${result[index]}");
                                    // if (stoData[index] != '') {
                                    //   if (stoData[index]['memberIndex'] ==
                                    //       index.toString()) {
                                    //     _navigateAndDisplaySelection(
                                    //         index: index,
                                    //         context: context,
                                    //
                                    //         formType: '',
                                    //         chFilledData: result[index]);
                                    //   }
                                    // } else {
                                    _navigateAndDisplaySelection(
                                        ind: index,
                                        context: context,
                                        chFilledData: result[index] != null && result[index].isNotEmpty ? result[index] : null,
                                        formType: '',
                                        // rolePanId: rolePlanId.toString(),
                                        // roleSId: roleId.toString());
                                        rolePanId: widget.rolePlanIds.toString(),
                                        roleSId: widget.roleIds.toString());
                                    // }
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: padding15),
                                      height: 40,
                                      width: SizeConfig.screenWidth * 0.33,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                            color: Colors.black45,
                                          ),
                                          color: Colors.white),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              stoData[index] != '' ? stoData[index]
                                                              ['memberIndex'] == index.toString()
                                                      ? 'View Details'
                                                      : 'Complete details'
                                                  : 'Complete details',
                                              style: TextStyle(
                                                  color: stoData[index] != ''
                                                      ? stoData[index][
                                                                  'memberIndex'] ==
                                                              index.toString()
                                                          ? Colors.black
                                                          : Colors.black
                                                      : Colors.black,
                                                  fontSize: 10),
                                            )
                                          ])),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  ///spouse code

                  Visibility(
                    visible: widget.memberCount > 2,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: padding10),
                        height: 45,
                        width: setWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.white),
                        child: RaisedButton(
                          onPressed: () {
                            if (!isApiHit)
                              getMemberShipData();
                            else {
                              childPopUp();
                            }
                            //    var count = 0;
                            // Navigator.popUntil(context, (route) {
                            //   return count++ == 2;
                            // });
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            'Extra child?',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    child: checkbox(iaccept, termsofService, acceptTerms),
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: padding5, left: 20, right: 20),
                    height: button_height,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        color: Colors.white),
                    child: RaisedButton(
                      onPressed: () {
                        bool formCheck = false;
                        // for(int i=0; i<result.length;i++)
                        //   {
                        //     if(result[i]['memberIndex']==i.toString())
                        //       {
                        //         print(i);
                        //         print("Empty______________");
                        //         break;
                        //       }
                        //   }
                        /**
                         * single form detail
                         */
                        result.forEach((element) {
                          if (element.isEmpty) {
                            formCheck = false;
                            return;
                          } else {
                            formCheck = true;
                          }
                        });

                        if (result != null && formCheck && acceptTerms) {
                          Map<String, String> parms = {};
                          for (int index = 0; index < result.length; index++) {
                            parms[FIRSTNAME +
                                "${index == 0 ? "" : "_$index"}"] = result[
                                    index]
                                [FIRSTNAME + "${index == 0 ? "" : "_$index"}"];
                            parms[MIDDLENAME +
                                "${index == 0 ? "" : "_$index"}"] = result[
                                    index]
                                [MIDDLENAME + "${index == 0 ? "" : "_$index"}"];
                            parms[LASTNAME + "${index == 0 ? "" : "_$index"}"] =
                                result[index][LASTNAME +
                                    "${index == 0 ? "" : "_$index"}"];
                            parms[MOBILE + "${index == 0 ? "" : "_$index"}"] =
                                result[index]
                                    [MOBILE + "${index == 0 ? "" : "_$index"}"];
                            parms[EMAIL + "${index == 0 ? "" : "_$index"}"] =
                                result[index]
                                    [EMAIL + "${index == 0 ? "" : "_$index"}"];
                            parms[PASSWORD + "${index == 0 ? "" : "_$index"}"] =
                                result[index][PASSWORD +
                                    "${index == 0 ? "" : "_$index"}"];
                            parms[BIRTH_DATE +
                                "${index == 0 ? "" : "_$index"}"] = result[
                                    index]
                                [BIRTH_DATE + "${index == 0 ? "" : "_$index"}"];
                            parms[EMIRATES_ID +
                                    "${index == 0 ? "" : "_$index"}"] =
                                result[index][EMIRATES_ID +
                                    "${index == 0 ? "" : "_$index"}"];
                            parms[GENDER + "${index == 0 ? "" : "_$index"}"] =
                                result[index]
                                    [GENDER + "${index == 0 ? "" : "_$index"}"];
                            parms[trainer_id +
                                "${index == 0 ? "" : "_$index"}"] = result[
                                    index]
                                [trainer_id + "${index == 0 ? "" : "_$index"}"];
                            parms[trainer_slot +
                                    "${index == 0 ? "" : "_$index"}"] =
                                result[index][trainer_slot +
                                    "${index == 0 ? "" : "_$index"}"];
                            if (index == 0)
                              parms[EMEREGENCY_NUMBER] =
                                  result[index][EMEREGENCY_NUMBER];
                            if (index == 0)
                              parms[DESIGNATION] = result[index][DESIGNATION];
                            if (index == 0)
                              parms[ADDRESS] = result[index][ADDRESS];
                            if (index == 0) parms[CITY] = result[index][CITY];
                            if (index == 0)
                              parms[nationality] = result[index][nationality];
                            if (index == 0)
                              parms[workplace] = result[index][workplace];
                            if (index == 0)
                              parms[marital_status] =
                                  result[index][marital_status];
                            if (index == 0)
                              parms[about_us] = result[index][about_us];
                            parms[DEVICE_TYPE] = deviceType;
                            parms[DEVICE_TOKEN] = deviceTokenValue;

                            parms[ROLE_ID] = roleIdrole != null
                                ? roleIdrole.toString()
                                : widget.roleId.toString();
                            parms[ROLE_PLAN_ID] = rolePlanId != null
                                ? rolePlanId.toString()
                                : widget.rolePlanIds.toString();
                          }
                          print("vikasssss===${parms}");
                          // FIRSTNAME: result[index][FIRSTNAME],
                          // MIDDLENAME: result[index][MIDDLENAME],
                          // LASTNAME: result[index][LASTNAME],
                          // MOBILE: result[index][MOBILE],
                          // EMAIL: result[index][EMAIL],
                          // PASSWORD: result[index][PASSWORD],
                          // BIRTH_DATE: result[index][BIRTH_DATE],
                          // EMIRATES_ID: result[index][EMIRATES_ID],
                          /**
                           * form 1 details
                           */
                          isConnectedToInternet().then((internet) {
                            print("AllParam" + parms.toString());
                            if (internet != null && internet) {
                              showProgress(context, "Please wait.....");

                              signUpToServer(parms: parms, file: myResult[1])
                                  .then((response) {
                                dismissDialog(context);
                                if (response.status) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    ScaleRoute(page: SuccessScreen()),
                                    (r) => false,
                                  );
                                } else {
                                  dismissDialog(context);

                                  if (response.error != null)
                                    showDialogBox(
                                        context, "Error!", response.error);
                                  else {
                                    errorMessage1 = '';
                                    if (response.errors != null) {
                                      var value = response.errors.toJson();

                                      if (value['email'] != null) {
                                        errorMessage = response.errors.email;
                                        setState(() {
                                          errorMessage1 = response.errors.email;
                                        });
                                      } else if (response.errors.email_1 !=
                                          null) {
                                        errorMessage = response.errors.email_1;
                                        setState(() {
                                          errorMessage1 =
                                              response.errors.email_1;
                                        });
                                      } else if (response.errors.email_2 !=
                                          null) {
                                        errorMessage = response.errors.email_2;
                                        setState(() {
                                          errorMessage1 =
                                              response.errors.email_2;
                                        });
                                      } else if (response.errors.email_3 !=
                                          null) {
                                        errorMessage = response.errors.email_3;
                                        setState(() {
                                          errorMessage1 =
                                              response.errors.email_3;
                                        });
                                      }

                                      showDialogBox(
                                          context, error, errorMessage);
                                    }
                                  }
                                }
                              });
                            } else {
                              showDialogBox(
                                  context, internetError, pleaseCheckInternet);
                              dismissDialog(context);
                            }
                            dismissDialog(context);
                          });
                        } else if (!acceptTerms) {
                          showDialogBox(context, termsofService,
                              'Please read & accept our terms of services');
                        } else {
                          showDialogBox(
                              context, error, 'please fill all details');
                        }
                      },
                      /** from end Api**/
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Text(
                        signup,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
//
                ],
              ),
            ),
          ),
        ));
  }

  Widget checkbox(String title, String richTExt, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.black,
          value: boolValue,
          onChanged: (bool value) {
            setState(() {
              acceptTerms = value;
              if (value) {
                //  termsBottom('Terms of Services');
              }
            });
          },
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new RichText(
              text: new TextSpan(
                text: title,
                style: TextStyle(fontSize: textSize10, color: Colors.black),
                children: <TextSpan>[
                  new TextSpan(
                      text: richTExt,
                      style: TextStyle(
                          fontSize: textSize10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ],
              ),
            ),
          ),
          onTap: () {
            getTerms();
          },
        ),
      ],
    );
  }

  void getTerms() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        getTermsApi().then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              if (response.data.config != null &&
                  response.data.config.isNotEmpty)
                termsBottom('Terms & Conditions', response.data.config);
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

  void termsBottom(String title, String msg) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Container(
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(50.0),
                          topRight: const Radius.circular(50.0))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child: Padding(
                          child: Align(
                            child: Icon(Icons.close),
                            alignment: Alignment.topRight,
                          ),
                          padding: EdgeInsets.all(15),
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
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Html(data: msg),
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

  void customBottomSheet({context, VoidCallback getValue, List<Data> data}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: SizeConfig.screenHeight * 0.7,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ),
            ),
            child: Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.04,
                    left: SizeConfig.screenWidth * 0.05,
                    right: SizeConfig.screenWidth * 0.05,
                    bottom: SizeConfig.screenHeight * 0.025),
                child: StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return TranslationAnimatedWidget(
                      enabled: chooseChilds,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      values: [
                        Offset(0, 40), // disabled value value
                        Offset(0, 20), //intermediate value
                        Offset(0, 0)
                      ],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Extra Child?',
                                    style: TextStyle(
                                        fontFamily: 'regular',
                                        fontSize:
                                            SizeConfig.screenHeight * 0.027,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Choose No. of child(s) you have.',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.018,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                      'assets/icons/close_icon.svg'))
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.all(0.0),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    splashColor: Colors.black,
                                    onTap: () {
                                      print(
                                          "print ander  ${widget.response[widget.plan_index]['fee_type']}");
                                      // if (data[index].plans[""] != null && widget.response[widget.plan_index]['fee_type'] == data[index].plans.monthly.feeType) {
                                      //   if (data[index].plans.monthly.feeType != null) {
                                      //     setState(() {
                                      //       rolePlanId = data[index].plans.monthly.id.toString();
                                      //       rolePlanFee = data[index].plans.monthly.fee
                                      //           .toString();
                                      //       print("rolePlanId " + rolePlanId);
                                      //       print("rolePlanFee " + rolePlanFee);
                                      //     });
                                      //   }
                                      // } else
                                      if (data[index].plans.quarterly != null &&
                                          widget.response[widget.plan_index]
                                                  ['fee_type'] ==
                                              data[index]
                                                  .plans
                                                  .quarterly
                                                  .feeType) {
                                        if (data[index]
                                                .plans
                                                .quarterly
                                                .feeType !=
                                            null) {
                                          //
                                          setState(() {
                                            rolePlanId = data[index]
                                                .plans
                                                .quarterly
                                                .id
                                                .toString();
                                            rolePlanFee = data[index]
                                                .plans
                                                .quarterly
                                                .fee
                                                .toString();
                                            roleIdrole = data[index]
                                                .plans
                                                .quarterly
                                                .roleId
                                                .toString();

                                            print("rolePlanId " + rolePlanId);
                                            print("rolePlanFee " + rolePlanFee);
                                          });
                                        }
                                      } else if (data[index].plans.halfYearly !=
                                              null &&
                                          widget.response[widget.plan_index]
                                                  ['fee_type'] ==
                                              data[index]
                                                  .plans
                                                  .halfYearly
                                                  .feeType) {
                                        if (data[index]
                                                .plans
                                                .halfYearly
                                                .feeType !=
                                            null) {
                                          setState(() {
                                            rolePlanId = data[index]
                                                .plans
                                                .halfYearly
                                                .id
                                                .toString();
                                            rolePlanFee = data[index]
                                                .plans
                                                .halfYearly
                                                .fee
                                                .toString();
                                            roleIdrole = data[index]
                                                .plans
                                                .quarterly
                                                .roleId
                                                .toString();

                                            print("rolePlanId " + rolePlanId);
                                            print("rolePlanFee " + rolePlanFee);
                                          });
                                        }
                                      } else if (data[index].plans.yearly !=
                                              null &&
                                          widget.response[widget.plan_index]
                                                  ['fee_type'] ==
                                              data[index]
                                                  .plans
                                                  .yearly
                                                  .feeType) {
                                        if (data[index].plans.yearly.feeType !=
                                            null) {
                                          setState(() {
                                            rolePlanId = data[index]
                                                .plans
                                                .yearly
                                                .id
                                                .toString();
                                            rolePlanFee = data[index]
                                                .plans
                                                .yearly
                                                .fee
                                                .toString();
                                            roleIdrole = data[index]
                                                .plans
                                                .quarterly
                                                .roleId
                                                .toString();

                                            print("rolePlanId " + rolePlanId);
                                            print("rolePlanFee " + rolePlanFee);
                                          });
                                        }
                                      } else {
                                        print("Null values");
                                      }

                                      setState(() {
                                        selectChildIndex = index;
                                        //  widget.response[widget.plan_index]['fee_type']
                                        childValueCount =
                                            data[index].member != null
                                                ? data[index].member - 2
                                                : 0;
                                        roleId = data[index].id.toString();
                                        // rolePlanId = widget.response[widget.plan_index]['fee_type'] == data[index].plans.monthly.feeType ? data[index].plans.monthly.id.toString() : widget.response[widget.plan_index]['fee_type'] == data[index].plans.quarterly.feeType ? data[index].plans.quarterly.id.toString() : widget.response[widget.plan_index]['fee_type'] == data[index].plans.halfYearly.feeType ? data[index].plans.halfYearly.id.toString() : widget.response[widget.plan_index]['fee_type'] == data[index].plans.yearly.feeType ? data[index].plans.yearly.id.toString() : "Something Wrong";
                                        // rolePlanFee = widget.response[widget.plan_index]['fee_type'] == data[index].plans.monthly.feeType ? data[index].plans.monthly.fee.toString(): widget.response[widget.plan_index]['fee_type'] == data[index].plans.quarterly.feeType ? data[index].plans.quarterly.fee.toString() : widget.response[widget.plan_index]['fee_type'] == data[index].plans.halfYearly.feeType ? data[index].plans.halfYearly.fee.toString() : widget.response[widget.plan_index]['fee_type'] == data[index].plans.yearly.feeType ? data[index].plans.yearly.fee.toString() : "Something Wrong";
                                        valueNew = index;
                                        print("rolePlanId " +
                                            rolePlanId.toString());
                                        print("roleId " + roleId.toString());
                                        print("fee " + rolePlanFee.toString());
                                      });
                                      if (valueNew == index) {
                                        setState(() {
                                          chooseChilds = true;
                                          //     valueNew = data[index].member-2;
                                        });
                                      }
                                    },
                                    child: selectChild(childValue[index],
                                        selectChildIndex, index));
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.015),
                            child: TranslationAnimatedWidget(
                                enabled: chooseChilds,
                                duration: Duration(milliseconds: 700),
                                curve: Curves.easeIn,
                                values: [
                                  Offset(0, 180), // disabled value value
                                  Offset(0, 100), //intermediate value
                                  Offset(0, 0)
                                ],
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: getValue,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 35.0,
                                                vertical: 10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              'Update Plan',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              child: Text(
                                                'back to plans?',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        );
      },
    );
  }

  Widget selectChild(String qunVal, int myValue, int currentIndex) {
    print("$myValue fsdkhjkh $currentIndex");

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //widget.response[widget.plan_index]['fee_type']
                  Visibility(
                      visible: widget.response[widget.plan_index]['fee_type'] ==
                          'monthly',
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.80),
                          child: Text(
                            '${data[currentIndex].priceLabelMonthly}',
                            style:
                                TextStyle(fontFamily: open_light, fontSize: 14),
                          ))),
                  Visibility(
                      visible: widget.response[widget.plan_index]['fee_type'] ==
                          'quarterly',
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.80),
                          child: Text(
                            '${data[currentIndex].priceLabelQuarterly}',
                            style:
                                TextStyle(fontFamily: open_light, fontSize: 14),
                          ))),
                  Visibility(
                      visible: widget.response[widget.plan_index]['fee_type'] ==
                          'half_yearly',
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.80),
                          child: Text(
                            '${data[currentIndex].priceLabelHalfYearly}',
                            style:
                                TextStyle(fontFamily: open_light, fontSize: 14),
                          ))),
                  Visibility(
                      visible: widget.response[widget.plan_index]['fee_type'] ==
                          'yearly',
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.80),
                          child: Text(
                            '${data[currentIndex].priceLabelYearly}',
                            style:
                                TextStyle(fontFamily: open_light, fontSize: 14),
                          ))),
                  //Text(' ${data[currentIndex].plans.halfYearly.fee}{} AED ${data[currentIndex].label}',//${data[currentIndex].planDetail[currentIndex].fee
                  //),
                ],
              ),
              // Visibility(visible:widget.response[widget.plan_index]['fee_type'] == 'monthly',child: ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),child: Text('${data[currentIndex].priceLabelMonthly}',style: TextStyle(fontFamily: open_light, fontSize: 14),))),
              // Visibility(visible:widget.response[widget.plan_index]['fee_type'] == 'quarterly',child: ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),child: Text('${data[currentIndex].priceLabelQuarterly}',style: TextStyle(fontFamily: open_light, fontSize: 14),))),
              // Visibility(visible:widget.response[widget.plan_index]['fee_type'] == 'half_yearly',child: ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),child: Text('${data[currentIndex].priceLabelHalfYearly}',style: TextStyle(fontFamily: open_light, fontSize: 14),))),
              // Visibility(visible:widget.response[widget.plan_index]['fee_type'] == 'yearly',child: ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),child: Text('${data[currentIndex].priceLabelYearly}',style: TextStyle(fontFamily: open_light, fontSize: 14),))),
              Spacer(),
              Container(
                height: 20.0,
                width: 20.0,
                child: myValue == currentIndex
                    ? ScaleAnimatedWidget(
                        duration: Duration(milliseconds: 150),
                        enabled: myValue == currentIndex,
                        child:
                            SvgPicture.asset('assets/icons/icon_selected.svg'))
                    : SvgPicture.asset('assets/icons/icon_unselected.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
