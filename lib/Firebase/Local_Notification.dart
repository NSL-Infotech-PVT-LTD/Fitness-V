import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:volt/Bookings/all_bookings.dart';


class LocalNotification {
  LocalNotification();
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;


  static initLocal(BuildContext context) {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initSettingAndroid = AndroidInitializationSettings('logo');
    var initSettingIos = IOSInitializationSettings();
    var initS = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIos);
    _flutterLocalNotificationsPlugin.initialize(initS, onSelectNotification:onSelectNoti);
  
  }

  static Future<void> showNotificationMediaStyle(String title,String body) async {
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

    await _flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics,payload: 'fcm');

  }

  // ignore: missing_return
  static Future<dynamic> onSelectNoti(String payload) {
    if(payload != null) {
      print('noti click');
      print('noti content $payload');
    }
  }

  // static localDispose() {
  //   _flutterLocalNotificationsPlugin.cancelAll();
  // }

}
