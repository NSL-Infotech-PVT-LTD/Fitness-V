import 'package:device_info/device_info.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:volt/AuthScreens/LoginScreen.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';

import 'package:volt/Methods.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

Future<String> getDeviceID(bool isIOS) async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    return iosDeviceInfo.identifierForVendor; //ios Unique Id
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    return androidDeviceInfo.androidId;

    ///Android Unique ID
  }
}

Future<bool> isConnectedToInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

void showDialogBox(context, String title, String message) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(message, style: TextStyle(wordSpacing: 1)),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK",style: TextStyle(color: CColor.CancelBTN),),
              onPressed: () {
                Navigator.pop(context);
              },
              isDestructiveAction: true,
            ),
          ],
        );
      });

//  showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text(title),
//          content: Text(message),
//          actions: <Widget>[
//            FlatButton(
//              child: const Text('OK'),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ],
//        );
//      });
}void showDialogBoxOnlyForYourBooking(context, String title, String message) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(message, style: TextStyle(wordSpacing: 1)),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK",style: TextStyle(color: CColor.CancelBTN)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    Dashboard()), (Route<dynamic> route) => false);
              },
              isDestructiveAction: true,
            ),
          ],
        );
      });

//  showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text(title),
//          content: Text(message),
//          actions: <Widget>[
//            FlatButton(
//              child: const Text('OK'),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ],
//        );
//      });
}

void showDialogRemoveUntil(context, String title, String message) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(message),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context, ScaleRoute(page: Dashboard()), (r) => false);
              },
              isDestructiveAction: true,
            ),
          ],
        );
      });
}

void cupertinoDialog(context, String negativeText, String positiveText) {
  CupertinoDialogAction(
      child: Column(
        children: <Widget>[
          Text(
            negativeText,
            style: TextStyle(color: Color(0xFF71747E), fontSize: 18.0),
          ),
          Text(
            positiveText,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
      isDefaultAction: true,
      onPressed: () {
        Navigator.pop(context, true);
      });
}

void exitDialog(context) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Alert!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: open_semi_bold),
            ),
          ),
          message: Text(
            "Are you sure to exit?\nIf you exit, data will be vanished.",
            style: TextStyle(
                color: Colors.black.withOpacity(.4),
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text("Confirm",
                  style: TextStyle(
                      color:CColor.CancelBTN,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Cancel",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
void exitFromApp(context) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Alert!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: open_semi_bold),
            ),
          ),
          message: Text(
            "Are you sure, you want to exit?",
            style: TextStyle(
                color: Colors.black.withOpacity(.4),
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text("Confirm",
                  style: TextStyle(
                      color: CColor.CancelBTN,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
          //      Navigator.pop(context);
                SystemNavigator.pop();
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Cancel",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
void logoutDialog(context) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Logout!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: open_semi_bold),
            ),
          ),
          message: Text(
            "Are you sure, you want to logout.",
            style: TextStyle(
                color: Colors.black.withOpacity(.4),
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text("Confirm",
                  style: TextStyle(
                      color: CColor.CancelBTN,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                clearedShared();
                Navigator.pushAndRemoveUntil(
                    context, ScaleRoute(page: LoginScreen()), (r) => false);
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Cancel",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

Widget whitePlaceHolder(
        String roleUrl, String imageLink, double height, double width) =>
    FadeInImage.assetNetwork(
      placeholder: baseImageAssetsUrl + 'logo_white.png',
      image: BASE_URL + roleUrl + imageLink,
      fit: BoxFit.cover,
      height: height,
    );

Widget blackPlaceHolder(
        String roleUrl, String imageLink, double height, double width) =>
    FadeInImage.assetNetwork(
      placeholder: baseImageAssetsUrl + 'logo.png',
      image: BASE_URL + roleUrl + imageLink,
      width: width,
      fit: BoxFit.cover,
      height: height,
    );

class SlidingRight extends MaterialPageRoute {
  Widget page;

  SlidingRight({this.page}) : super(builder: (BuildContext context) => page);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

Widget buildProgressIndicator(bool isLoading) {
  return new Padding(
    padding: const EdgeInsets.all(8.0),
    child: new Align(
      alignment: Alignment.centerRight,
      child: new Opacity(
        opacity: isLoading ? 1.0 : 00,
        child: new CircularProgressIndicator(
          backgroundColor: Colors.black,
        ),
      ),
    ),
  );
}
Widget buildProgressIndicatorCenter(bool isLoading) {
  return new Padding(
    padding: const EdgeInsets.all(8.0),
    child: new Align(
      alignment: Alignment.center,
      child: new Opacity(
        opacity: isLoading ? 1.0 : 00,
        child: new CircularProgressIndicator(
          backgroundColor: Colors.black,
        ),
      ),
    ),
  );
}

ProgressDialog progress(context) {
  SpinKitFadingCircle(color: Colors.black);
  return ProgressDialog(
    context,
    type: ProgressDialogType.Normal,
    isDismissible: true,
  );
}

Widget showLoading() => Container(
    height: SizeConfig.screenHeight,
    color: Color(0xFFE0E0E0).withOpacity(.1),
    child: Center(child: SpinKitCircle(color: Colors.black87.withOpacity(.5))));

void showProgress(context, String msg) {
  progress(context).style(
      message: msg,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(
        backgroundColor: CColor.App_Color,
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: CColor.App_Color, fontSize: 10.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center);

  progress(context).show();
}

void dismissDialog(context) {
  if (progress(context) != null) progress(context).hide();
}
