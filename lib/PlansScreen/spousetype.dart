import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/AuthScreens/SuccessScreen.dart';
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
import '../Value/Strings.dart';

class SpouseType extends StatefulWidget {
  List response;
  String type = "";
  int plan_index = 0;
  String roleId = "";
  List<String> childValue;

  SpouseType({this.response, this.plan_index, this.type, this.roleId});


  @override
  _SpouseTypeState createState() => _SpouseTypeState();
}

class _SpouseTypeState extends State<SpouseType> {
  bool acceptTerms = false;
  double setWidth;
  bool _isIos;
  String deviceType = '';
  String roleId = "";
  String deviceToken = "";
  var errorMessage = '';
  var errorMessage1 = '';

  var chooseChilds= false;
  int valueNew=-1;
  List<String> childValue=['1','2','3','4','5','6','7','8','9','10'];
  List<String> memberName=['Spouse#1','Spouse#2'];
  int itemCountOfChild = 2;

  String rolePlanId = "";
  var result, result1;

  var _scaffoldState=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';
    super.initState();
  }

  _navigateAndDisplaySelection(BuildContext context, String formType) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
                formType: formType,
                editData: result,
                isSingle: false,
                isCityTrue: true,
                isEmailError:
                    errorMessage1.contains("email has") ? true : false,
              )),
    );

    setState(() {});
  }

  _navigateAndDisplaySelection1(BuildContext context, String formType) async {
    result1 = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
                formType: formType,
                editData: result1,
                isSingle: false,
                isCityTrue: false,
                isEmailError: errorMessage1.contains("email 1") ? true : false,
              )),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    rolePlanId = widget.response[widget.plan_index]['id'].toString();

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          if (result != null || result1 != null) {
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
                                fontSize: textSize18,
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
                                couple +
                                    widget.response[widget.plan_index]
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
                              child: Text(
                                aed +
                                    widget.response[widget.plan_index]['fee']
                                        .toString(),
                                style: TextStyle(
                                  color: CColor.WHITE,
                                  fontSize: textSize18,
                                ),
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
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 20.0,
                    ),
                      padding: EdgeInsets.all(8.0),
                      itemCount: memberName.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      return  Container(
                        padding: EdgeInsets.all(10),
                        height: SizeConfig.screenHeight * 0.20,
                        width: SizeConfig.screenWidth * 0.40,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                              width: errorMessage1.contains("email has")
                                  ? 2
                                  : 1.5,
                              color: errorMessage1.contains("email has")
                                  ? Colors.red
                                  : Color(0xFFBDBDBD),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: result != null
                                ? Colors.black
                                : Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
//                                Padding(
//                                  padding: EdgeInsets.all(10),
//                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                Text(
                                  result != null
                                      ? result[FIRSTNAME]
                                      :  memberName[index],
                                  style: TextStyle(
                                    color: result != null
                                        ? CColor.WHITE
                                        : Colors.black,
                                    fontSize: textSize12,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    color: result != null
                                        ? Colors.white
                                        : Colors.black,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: padding15),
                                height: 40,
                                width: SizeConfig.screenWidth * 0.33,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: result != null
                                          ? Colors.white
                                          : Colors.black45,
                                    )),
                                child: RaisedButton(
                                  onPressed: () {
                                    _navigateAndDisplaySelection(
                                        context, "");
                                  },
                                  color: result != null
                                      ? Colors.black
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5.0)),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Fill Details',
                                        style: TextStyle(
                                            color: result != null
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 10),
                                      ),
                                      Visibility(
                                          visible: errorMessage1
                                              .contains("email has")
                                              ? true
                                              : false,
                                          child: Padding(
                                            child: Align(
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 16,
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                            padding:
                                            EdgeInsets.only(left: 10),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                      },),
                  ),


                  ///spouse code


                  memberName.length > 2 ? Container():   Visibility(
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    visible: memberName.length > 2 ? false :true,
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
                            var count = 0;
                            // Navigator.popUntil(context, (route) {
                            //   return count++ == 2;
                            // });
                            customBottomSheet(
                              context: context,
                              getValue: () {
                                setState(() {
                                  // itemCountOfChild +=valueNew;
                                  // memberName.add
                                  if(memberName.length > 2) {
                                    memberName.removeRange(2, memberName.length);
                                    // for(int i=2; i<memberName.length -1;i++ ){
                                    //   memberName.removeAt(i);
                                    // }
                                  }
                                  for(int i=1; i<=valueNew + 1;i++ ){
                                    memberName.add('Child#${i}');
                                  }
                                  // print('after');
                                  // print(memberName);
                                  chooseChilds =false;
                                  valueNew = -1;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            'Have Child?',
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
                    margin:
                        EdgeInsets.only(top: padding5, left: 20, right: 20),
                    height: button_height,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        color: Colors.white),
                    child: RaisedButton(
                      onPressed: () {
                        if (result != null && result1 != null && acceptTerms) {
                          Map<String, String> parms = {
                            /**
                             * single form detail
                             */

                            FIRSTNAME: result[FIRSTNAME],
                            MIDDLENAME: result[MIDDLENAME],
                            LASTNAME: result[LASTNAME],
                            MOBILE: result[MOBILE],
                            EMAIL: result[EMAIL],
                            PASSWORD: result[PASSWORD],
                            BIRTH_DATE: result[BIRTH_DATE],
                            EMIRATES_ID: result[EMIRATES_ID],
                            ROLE_ID: widget.roleId,
                            ROLE_PLAN_ID: rolePlanId,
                            EMEREGENCY_NUMBER: result[EMEREGENCY_NUMBER],
                            DESIGNATION: result[DESIGNATION],
                            ADDRESS: result[ADDRESS],
                            GENDER: result[GENDER],
                            CITY: result[CITY],
                            /**
                             * form 1 details
                             */
                            FIRSTNAME + "_1": result1[FIRSTNAME + "_1"],
                            MIDDLENAME + "_1": result1[MIDDLENAME + "_1"],
                            LASTNAME + "_1": result1[LASTNAME + "_1"],
                            MOBILE + "_1": result1[MOBILE + "_1"],
                            EMAIL + "_1": result1[EMAIL + "_1"],
                            PASSWORD + "_1": result1[PASSWORD + "_1"],
                            BIRTH_DATE + "_1": result1[BIRTH_DATE + "_1"],
                            EMIRATES_ID + "_1": result1[EMIRATES_ID + "_1"],
                            GENDER + "_1": result1[GENDER + "_1"],
                            DEVICE_TYPE: deviceType,
                            DEVICE_TOKEN: deviceTokenValue,
                          };
                          print("bjbfjj$parms");
                         isConnectedToInternet().then((internet) {
                           if (internet != null && internet) {
                             showProgress(context, "Please wait.....");

                             signUpToServer(parms).then((response) {
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
                             showDialogBox(context, internetError,
                                 pleaseCheckInternet);
                             dismissDialog(context);
                           }
                           dismissDialog(context);
                         });
                       } else if (!acceptTerms) {
                         showDialogBox(context, termsofService,
                             'Please read & accept our terms of services');
                       } else {
                         showDialogBox(context, error, 'Please fill details');
                        }
                      },
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


 Widget selectChild(String qunVal, int myValue,int currentIndex){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '1200 AED For $qunVal Child',
                    style: TextStyle(fontFamily: open_light, fontSize: 14),
                  ),

                ],
              ),
              Spacer(),

              Container(
                height: 20.0,
                width: 20.0,
                decoration: new BoxDecoration(
//                  color: widget.myValue ? Colors.black : Colors.transparent,
                  image: DecorationImage(
                      image: myValue==currentIndex
                          ? AssetImage(
                        baseImageAssetsUrl + 'tick.png',
                      )
                          : AssetImage(baseImageAssetsUrl + '')),

                  border: new Border.all(
                      width: 1.0,
                      color: myValue==currentIndex ? Colors.transparent : Colors.grey),
                  borderRadius:
                  const BorderRadius.all(const Radius.circular(2.0)),
                ),
              ),
            ],
          )
        ],
      ),
    );

 }


 Widget childCard(){
   return Container(
     padding: EdgeInsets.all(10),
     height: SizeConfig.screenHeight * 0.20,
     width: SizeConfig.screenWidth * 0.40,
     decoration: BoxDecoration(
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.3),
             spreadRadius: 5,
             blurRadius: 7,
             offset: Offset(
                 0, 3), // changes position of shadow
           ),
         ],
         border: Border.all(
           width: errorMessage1.contains("email has")
               ? 2
               : 1.5,
           color: errorMessage1.contains("email has")
               ? Colors.red
               : Color(0xFFBDBDBD),
         ),
         borderRadius: BorderRadius.circular(5.0),
         color: result != null
             ? Colors.black
             : Colors.white),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Row(
           //   crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
//                                Padding(
//                                  padding: EdgeInsets.all(10),
//                                ),
             SizedBox(
               width: SizeConfig.blockSizeHorizontal * 2,
             ),
             Text(
               result != null
                   ? result[FIRSTNAME]
                   : 'Spouse#1',
               style: TextStyle(
                 color: result != null
                     ? CColor.WHITE
                     : Colors.black,
                 fontSize: textSize12,
               ),
             ),
             Spacer(),
             Container(
               padding: EdgeInsets.all(10),
               child: SvgPicture.asset(
                 baseImageAssetsUrl + 'user.svg',
                 color: result != null
                     ? Colors.white
                     : Colors.black,
                 height: 25,
                 width: 25,
               ),
             ),
           ],
         ),
         Align(
           alignment: Alignment.bottomCenter,
           child: Container(
             margin: EdgeInsets.only(top: padding15),
             height: 40,
             width: SizeConfig.screenWidth * 0.33,
             decoration: BoxDecoration(
                 borderRadius:
                 BorderRadius.circular(5.0),
                 border: Border.all(
                   color: result != null
                       ? Colors.white
                       : Colors.black45,
                 )),
             child: RaisedButton(
               onPressed: () {
                 _navigateAndDisplaySelection(
                     context, "");
               },
               color: result != null
                   ? Colors.black
                   : Colors.white,
               shape: RoundedRectangleBorder(
                   borderRadius:
                   BorderRadius.circular(5.0)),
               child: Row(
                 crossAxisAlignment:
                 CrossAxisAlignment.center,
                 mainAxisAlignment:
                 MainAxisAlignment.center,
                 children: <Widget>[
                   Text(
                     'Fill Details',
                     style: TextStyle(
                         color: result != null
                             ? Colors.white
                             : Colors.black,
                         fontSize: 10),
                   ),
                   Visibility(
                       visible: errorMessage1
                           .contains("email has")
                           ? true
                           : false,
                       child: Padding(
                         child: Align(
                           child: Icon(
                             Icons.error,
                             color: Colors.red,
                             size: 16,
                           ),
                           alignment: Alignment.center,
                         ),
                         padding:
                         EdgeInsets.only(left: 10),
                       )),
                 ],
               ),
             ),
           ),
         )
       ],
     ),
   );
 }

  void customBottomSheet({context,VoidCallback getValue}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context) {
      return  Container(
        height: SizeConfig.screenHeight * 0.6,
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
                  top: SizeConfig.screenHeight * 0.08,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  bottom: SizeConfig.screenHeight * 0.05),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: chooseChilds,
                            child: GestureDetector(
                              onTap: getValue,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text('Add', style: TextStyle(
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/icons/close_icon.svg'))
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Have Child?', style: TextStyle(
                              fontFamily: 'regular',
                              fontSize: SizeConfig.screenHeight * 0.027,
                              fontWeight: FontWeight.bold
                          ),),
                          Text('Choose No. of child(s) you have.', style: TextStyle(
                              fontSize: SizeConfig.screenHeight * 0.018,
                              fontWeight: FontWeight.normal
                          ),),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          itemCount: childValue.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                splashColor: Colors.black,
                                onTap: () {
                                  setState(() {
                                    valueNew=index;

                                  });
                                  if(valueNew == index){
                                    setState(() {
                                      chooseChilds = true;
                                    });

                                  }
                                }
                                ,child: selectChild(childValue[index],valueNew,index));

                          },
                        ),
                      ),

                    ],
                  );

                },
              )
          ),
        ),
      );
    },);
  }


}




