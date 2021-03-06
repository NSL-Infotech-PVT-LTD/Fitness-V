import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/NotificationsScreens/Notification.dart';
import 'package:volt/Profile/userProfile.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  String _userName = '';
  var result;

  @override
  void initState() {
    _loadAuth();
    getString(userImage)
        .then((value) => {result = value})
        .whenComplete(() => setState(() {}));

    super.initState();
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
                termsBottom('Terms & Conditions', response.data.config, context);
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, 'Internet Error', pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  void getPrivacy() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        getPrivacyApi().then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              if (response.data.config != null &&
                  response.data.config.isNotEmpty)
                termsBottom('Privacy Policy', response.data.config, context);
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        }).whenComplete(() => dismissDialog(context));
      } else {
        showDialogBox(context, 'Internet Error', pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  void getAbout() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        getAboutApi().then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              if (response.data.config != null &&
                  response.data.config.isNotEmpty)
                termsBottom(contactAndAboutVolt, response.data.config, context);
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, 'Internet Error', pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfile()),
    );
    getString(userImage)
        .then((value) => {result = value})
        .whenComplete(() => setState(() {}));

    print(result.toString() + "jugraj---------");
    setState(() {});
  }

  _loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = (prefs.getString(USER_NAME) ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: topMargin,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    baseImageAssetsUrl + 'logo_black.png',
                    width: 60,
                    height: 30,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ))
                ],
              ),
            ),
            Container(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: SvgPicture.asset(
                      baseImageAssetsUrl + 'horizontal.svg',
                      width: SizeConfig.screenWidth,
                    ),
                  ),
                  Positioned(
                      left: SizeConfig.screenWidth * .37,
                      right: SizeConfig.screenWidth * .37,
                      bottom: 15,
                      child: result == null
                          ? Image.asset(
                              baseImageAssetsUrl + 'circleuser.png',
                              height: 105,
                              width: 105,
                            )
                          : CircleAvatar(
                              radius: 52.0,
                              backgroundImage: NetworkImage(
                                  BASE_URL + 'uploads/image/' + result),
                              backgroundColor: Colors.transparent,
                            )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                _userName.isEmpty ? 'Firley Willth' : _userName,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Color(0xff8B8B8B), fontSize: textSize20),
              ),
            ),
            Visibility(
              visible: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 32,
                      width: 95,
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Edit Details',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Color(0xff8B8B8B), fontSize: 12),
                          ))),
                  Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            myDivider(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'home.svg'),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Dashboard',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  )),
            ),
            myDivider(),
            GestureDetector(
              onTap: () => _navigateAndDisplaySelection(context),
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(baseImageAssetsUrl + 'new.svg'),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'My Profile',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff8B8B8B), fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
            myDivider(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'speaker.svg'),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Notification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  )),
            ),
            myDivider(),
            Container(
              padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(baseImageAssetsUrl + 'tick.svg'),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Calendar & Booking',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff8B8B8B), fontSize: 16),
                      ))
                ],
              ),
            ),
            myDivider(),
            GestureDetector(
                onTap: () {
                  getPrivacy();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'invoice.svg'),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Instructor Policies',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  ),
                )),
            myDivider(),
            GestureDetector(
                onTap: () {
                  getAbout();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(baseImageAssetsUrl + 'headphones.svg'),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            contactAndAboutVolt,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  ),
                )),
            myDivider(),
            GestureDetector(
              onTap: () {
                getTerms();
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        baseImageAssetsUrl + 'terms.svg',
                        width: 30,
                        height: 30,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Terms & Conditions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  )),
            ),
            myDivider(),
            GestureDetector(
              onTap: () {
                logoutDialog(context);
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        size: 30,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Logout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff8B8B8B), fontSize: 16),
                          ))
                    ],
                  )),
            ),
            myDivider(),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  baseImageAssetsUrl + 'logo_black.png',
                  height: 60,
                  color: Color(0xff8B8B8B),
                  width: 100,
                ),
              ),
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
        ),
      ),
    );
  }
}
