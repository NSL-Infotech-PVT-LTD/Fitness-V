import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/NotificationsScreens/Notification.dart';


class LocalNotification {
  LocalNotification();
  static BuildContext ctx;
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;


  static initLocal(BuildContext context) {
    ctx = context;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initSettingAndroid = AndroidInitializationSettings('logo');
    var initSettingIos = IOSInitializationSettings();
    var initS = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIos);

    _flutterLocalNotificationsPlugin.initialize(initS, onSelectNotification:onSelectNoti);

  }

  static Future<void> showNotificationMediaStyle(Map<String,dynamic> msg,String title,String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "channel-00110", 'name', 'desc',
      priority: Priority.high,
      importance: Importance.max,
    );


    // AndroidNotificationChannel androidNotificationChannel =AndroidNotificationChannel('channel-00110', 'name', 'desc',importance: Importance.max);

    var platformChannelSpecifics=NotificationDetails(
        android: androidPlatformChannelSpecifics
    );
    // await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation()
    // await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>().createNotificationChannel(androidNotificationChannel)

    await _flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics,payload: '$msg');


  }

  // ignore: missing_return
  static Future<dynamic> onSelectNoti(String payload) {
    print("vkas payload===>$payload");
    if(payload != null && payload!="null" && payload!="{}") {
      // Navigator.of(_context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //     Dashboard()), (Route<dynamic> route) => false);
      //Navigator.of(_context).push(MaterialPageRoute(builder: (context) => NotificationScreen(),));

      print('noti click');
      print('noti content $payload');
    }

  }

// static localDispose() {
//   _flutterLocalNotificationsPlugin.cancelAll();
// }

}
