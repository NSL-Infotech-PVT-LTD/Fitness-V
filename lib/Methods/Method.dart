import 'package:device_info/device_info.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:volt/AuthScreens/LoginScreen.dart';

import 'package:volt/Methods.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

ProgressDialog progress(context) {
  return ProgressDialog(
    context,
    type: ProgressDialogType.Normal,
    isDismissible: true,
  );
}

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
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
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
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert!"),
          content: Text(
              "Are you sure to exit?\nIf you exit, data will be vanished."),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
                child: const Text('Ok'),
                onPressed: () => {
                      Navigator.pop(context),
                      Navigator.pop(context),
                    }),
          ],
        );
      });
}

void logoutDialog(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout!"),
          content: Text("Are you sure, you want to logout."),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
                child: const Text('Ok'),
                onPressed: () => {
                      clearedShared(),
                      Navigator.pushAndRemoveUntil(context,
                          ScaleRoute(page: LoginScreen()), (r) => false),
                    }),
          ],
        );
      });
}

Widget whitePlaceHolder(String roleUrl,String imageLink,double height,double width) => FadeInImage.assetNetwork(
      placeholder: baseImageAssetsUrl + 'logo_white.png',
      image: BASE_URL+roleUrl  + imageLink,
      fit: BoxFit.cover,
      height:height,
    );

Widget blackPlaceHolder(String roleUrl,String imageLink,double height,double width) => FadeInImage.assetNetwork(
      placeholder: baseImageAssetsUrl + 'logo_black.png',
      image: BASE_URL + roleUrl + imageLink,
      fit: BoxFit.cover,
      width: width,
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
