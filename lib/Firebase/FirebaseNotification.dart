import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:volt/Bookings/all_bookings.dart';
import 'package:volt/Firebase/Local_Notification.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:flutter/material.dart';
class FirebaseIn {

 FirebaseIn();
 static FirebaseMessaging   _firebaseMessaging;
static  initNoti(BuildContext context)  {

  _firebaseMessaging =FirebaseMessaging();
  _firebaseMessaging.getToken().then((value)  {
    print(value);
    setString(fireDeviceToken,value);
  });

  //local notification instance
  LocalNotification.initLocal(context);

   _firebaseMessaging.configure(

        // ignore: missing_return
    onLaunch: (message)  {
      print("onLaunch : $message");
      print(message["notification"]["title"]);
      print(message["data"]["click_action"]);
      if(message["notification"]["title"] != null){
        LocalNotification.showNotificationMediaStyle(message["notification"]["title"],message["notification"]["body"]);
      }
      if(message["data"]["click_action"] ){
         print('click call');
      }

 

     },
    // ignore: missing_return
    onMessage: (message) async {
      print("onMessage : $message");
      if(message["notification"]["title"] != null){
         LocalNotification.showNotificationMediaStyle(message["notification"]["title"],message["notification"]["body"]);
      }
      },
    // ignore: missing_return
    onResume:  (message) async {
      if(message != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (values) => AllBookings()));
        print('click call');
      }
      print("onResume vikas : $message");
      print("vikas"+message["notification"]["title"]);
      print("vikas"+message["data"]["click_action"]);
      if("vikas"+message["notification"]["title"] != null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (values) => AllBookings()));
        LocalNotification.showNotificationMediaStyle("vikas"+message["notification"]["title"],message["notification"]["body"]);

      }
      if(message["data"]["click_action"]){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (values) => AllBookings()));
        print('click call');
      }

      },
  );

  _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true,alert: true)
    );


}
//
// static fireMesDispose() {
//   LocalNotification.localDispose();
// }

  // Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  //   if (message.containsKey('data')) {
  //     // Handle data message
  //     final dynamic data = message['data'];
  //   }
  //
  //   if (message.containsKey('notification')) {
  //     // Handle notification message
  //     final dynamic notification = message['notification'];
  //   }
  //
  //   // Or do other work.
  // }


}

