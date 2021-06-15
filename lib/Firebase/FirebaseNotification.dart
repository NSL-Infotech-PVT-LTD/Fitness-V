// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:volt/Firebase/Local_Notification.dart';
// import 'package:volt/MemberDashboard/Dashboard.dart';
// import 'package:volt/Methods/Pref.dart';
// import 'package:volt/Methods/api_interface.dart';
// import 'package:flutter/material.dart';
// import 'package:volt/Screens/SplashScreenWithLady.dart';
//
// var messageGlob;
//
// class FirebaseIn {
//
//   FirebaseIn();
//   //static var auth = "";
//   static FirebaseMessaging   _firebaseMessaging = FirebaseMessaging();
//   static  initNoti(BuildContext context)  {
//
//   //  getString(USER_AUTH).then((value) => auth = value );
//   //  _firebaseMessaging
//     _firebaseMessaging.getToken().then((value)  {
//       print("Firebase token $value");
//       setString(fireDeviceToken,value);
//
//     });
//     // print("Firebase token $fireDeviceToken");
//     //local notification instance
//     LocalNotification.initLocal(context);
//
//
//     _firebaseMessaging.configure(
//
//       // ignore: missing_return
//       onLaunch: (message)  {
//
//
//         if(message["notification"]["title"] != null){
//           LocalNotification.showNotificationMediaStyle(message,message["notification"]["title"],message["notification"]["body"]);
//         }
//         if(message["data"]["click_action"] ){
//           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
//           print('click call');
//         }
//         if(SplashScreenWithLadyState.auth!=null && SplashScreenWithLadyState.auth.isNotEmpty)
//         Navigator.of(LocalNotification.ctx).push(MaterialPageRoute(builder: (context) => Dashboard(),));
//
//       },
//       // ignore: missing_return
//       onMessage: (message) async {
//         print("onMessage: $message");
//
//         if(message["notification"] != null){
//           LocalNotification.showNotificationMediaStyle(message,message["notification"]["title"],message["notification"]["body"]);
//         }else if(message["data"] != null){
//           LocalNotification.showNotificationMediaStyle(message,message["data"]["title"],message["data"]["message"]);
//         }
//         if(SplashScreenWithLadyState.auth!=null && SplashScreenWithLadyState.auth.isNotEmpty)
//           Navigator.of(LocalNotification.ctx).push(MaterialPageRoute(builder: (context) => Dashboard(),));
//       },
//       // ignore: missing_return
//       onResume:  (message) async {
//         print("onResume : $message");
//         // print(message["notification"]["title"]);
//         // print(message["data"]["click_action"]);
//         // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
//         //
//         if(message["notification"] != null){
//           LocalNotification.showNotificationMediaStyle(message,message["notification"]["title"],message["notification"]["body"]);
//         }else if(message["data"] != null){
//           LocalNotification.showNotificationMediaStyle(message,message["data"]["title"],message["data"]["message"]);
//         }
//         if(SplashScreenWithLadyState.auth!=null && SplashScreenWithLadyState.auth.isNotEmpty)
//           Navigator.of(LocalNotification.ctx).push(MaterialPageRoute(builder: (context) => Dashboard(),));
//
//         // if(message["data"]["click_action"]){
//         //   print('click call');
//         // }
//
//       },
//
//     );
//
//     // _firebaseMessaging.requestNotificationPermissions(
//     //     IosNotificationSettings(sound: true, badge: true,alert: true)
//     // );
//
//
//   }
// //
// // static fireMesDispose() {
// //   LocalNotification.localDispose();
// // }
//
// // Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
// //   if (message.containsKey('data')) {
// //     // Handle data message
// //     final dynamic data = message['data'];
// //   }
// //
// //   if (message.containsKey('notification')) {
// //     // Handle notification message
// //     final dynamic notification = message['notification'];
// //   }
// //
// //   // Or do other work.
// // }
//
//
// }
//
