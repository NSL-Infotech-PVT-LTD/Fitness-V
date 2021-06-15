import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:volt/Bookings/all_bookings.dart';
import 'package:volt/Screens/SplashScreenWithLady.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Methods/Pref.dart';
import 'Methods/api_interface.dart';
import 'Value/CColor.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('IN THE ON Background ===============>>>>>>>>>>> ${message.data}');
}

//check kri
//ok
String fcmToken = " ";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  fcmToken = await FirebaseMessaging.instance.getToken().whenComplete(() {
    setString(fireDeviceToken,fcmToken);
  });
  print("====================> $fcmToken");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;
  var initializationSettings ;

  initializePlatformSpecifics() {
    // var initializationSettingsAndroid =
    //     AndroidInitializationSett  ings('app_notf_icon');
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  getMe() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          print("======LOCAL NOTIFICATION======> $payload");
          print("======TOKEN======> $token");

          Map myMap = jsonDecode(payload);

          if (myMap["data_type"] == "Job" && token != null) {
            print("$myMap");

            // Get.to(MissionRequest(id: myMap["target_id"]),
            //     transition: Transition.leftToRightWithFade,
            //     duration: Duration(milliseconds: 400));
          }
          else if (myMap["data_type"] == "Message") {
            // Get.to(
            //     ChatScreen(
            //         reciverName: "${myMap["sender_name"]}",
            //         image: "${myMap["profile_img"]}",
            //         receiverId: "${myMap["target_id"]}",
            //         channel:
            //         IOWebSocketChannel.connect("ws://23.20.179.178:8080/")),
            //     transition: Transition.leftToRightWithFade,
            //     duration: Duration(milliseconds: 400));
          }
          else
          {
            // if (token != null)
              // Get.to(MissionRequest(id: myMap["target_id"]),
              //     transition: Transition.leftToRightWithFade,
              //     duration: Duration(milliseconds: 400));
          }
        });
  }

  @override
  void initState() {
    // getString(sharedPref.userToken).then((value) {
    //   if (value != null) {
    //     token = value;
    //     print("======token==============> $value");
    //   } else {
    //     print("ELSE =============>$token");
    //   }
    // }).whenComplete(() {
      initializePlatformSpecifics();
      getMe();
    // });

    FirebaseMessaging.instance.requestPermission();
    print("CHECK $token");
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
        print("IN THE ON MESSAGE ===============>>>>>>>>>>>");
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // color: Colors.blue,
                  playSound: true,
                  icon:'@mipmap/ic_launcher',
                ),
              ),
              payload: json.encode(message.data));

          print(
              "======IN onMessage ========> YYYYYYYYYYYYYYYY ${message.data}");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("IN THE OPEN MESSAGE  ============>>>>>>>>>>>");

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // if (notification != null && android != null) {
      //   print(
      //       "======IN onMessageOpenedApp ========> YYYYYYYYYYYYYYYY ${message.data}");

        // if (message.data["data_type"] == "Job") {
        //   print("${message.data}");
        //   print("$token=================>");
        //   if (token != null)
        //     // Get.to(MissionRequest(id: message.data["target_id"]),
        //     //     transition: Transition.leftToRightWithFade,
        //     //     duration: Duration(milliseconds: 400));
        // } else if (message.data["data_type"] == "Message") {
          // Get.to(
          //     ChatScreen(
          //         reciverName: "${message.data["sender_name"]}",
          //         image: "${message.data["profile_img"]}",
          //         receiverId: "${message.data["target_id"]}",
          //         channel:
          //         IOWebSocketChannel.connect("ws://23.20.179.178:8080/")),
          //     transition: Transition.leftToRightWithFade,
          //     duration: Duration(milliseconds: 400));
        // }
      //   else{
      //     // if (token != null)
      //       // Get.to(MissionRequest(id: message.data["target_id"]),
      //       //     transition: Transition.leftToRightWithFade,
      //       //     duration: Duration(milliseconds: 400));
      //   }
      // }
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
    //  navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'regular',
        primaryColor: CColor.PRIMARYCOLOR,
        sliderTheme: SliderTheme.of(context).copyWith(
        //  thumbColor: Color(0xFFEB1555),
          inactiveTrackColor: Color(0xFF8D8E98),
          activeTrackColor: Colors.white,
          overlayColor: Color(0x99EB1555),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
        ),
        accentColor: CColor.PRIMARYCOLOR,
      ),
      home: SplashScreenWithLady(),
    );
  }
}



