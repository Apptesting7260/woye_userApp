import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';

class PushNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  String? fcmToken;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  firebaseNotification() async {
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.isAutoInitEnabled;
    var android =
        const AndroidInitializationSettings('@drawable/launch_background');
    var ios = const DarwinInitializationSettings();

    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.requestPermission();
    initLocalNotification();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? appleNotification = message.notification?.apple;
        // NotificationCountin.incrementfunction();
        print('message notification body=====${message.notification?.body}');
        print(
            'notification body=====${notification}.  ${android}.   ${appleNotification}');

        if (notification != null && android != null) {
          showNotification(message.notification);
          // Utils.snackBar(
          //     message.notification!.title!, message.notification!.body!, false);
          print('android not null notification==${message.notification}');
          FirebaseMessaging.instance.getInitialMessage().then((message) {
            if (message != null) {
              print("abc525");
              // Get.offAll(NotificationScreen());
              // Get.to(() => NotificationScreen());
            } else {
              print("123154115415abc");
            }
          });
        } else if (notification != null && appleNotification != null) {
          // Utils.snackBar1(
          //   message.notification!.title!,
          //   message.notification!.body!,
          // );
          if (message.notification?.body == "Your account is now Active" ||
              message.notification?.body == "Your account is Suspended" ||
              message.notification?.body == "Your account is Inactive") {
            // if(message.notification?.body == "Your account is now Active"){
            //   Get.back();
            // }
          }
          print('apple notification');
          Get.snackbar('', notification.body.toString(),
              titleText: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/launcher.webp',
                    scale: 5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(notification.title.toString())
                ],
              ),
              backgroundColor: AppColors.white);
          // showCustomSnackbar(notification.title.toString(),notification.body.toString(),context);
          // showNotification(message.notification);
        } else {}
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Get.offAll(NotificationScreen());
        showNotification(message.notification);
        // Get.to(() => NotificationScreen());
      }
    });

    FirebaseMessaging.instance.getToken().then((String? token) async {
      if (token == null) {
        print('FCM token is null');
      } else {
        fcmToken = token;
        print('FCM token: $token');
      }
    }).catchError((error) {
      print('Error getting FCM token: ${error.toString()}');
    });
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      print('FlutterFire Messaging Example: Getting APNs token...');
      String? Token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $Token');
    }
  }

  Future initLocalNotification() async {
    if (Platform.isIOS) {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('ic_launcher');
      // var initializationSettingsIOS = DarwinInitializationSettings(
      //   requestAlertPermission: false,
      //   requestBadgePermission: false,
      //   requestSoundPermission: true,
      //   onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      // );

      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsDarwin);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    } else {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@drawable/launch_background');
      var initializationSettingsIOS = DarwinInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (details) {
          _selectNotification(details.payload);
        },
      );
    }
  }

  Future showNotification(RemoteNotification? notification) async {
    var android = const AndroidNotificationDetails(
      'CHANNLEID',
      "Woye",
      // "CHANNLENAME",
      channelDescription: "channelDescription",
      importance: Importance.max,
      fullScreenIntent: true,
      icon: '@mipmap/ic_launcher',
      priority: Priority.high,
      visibility: NotificationVisibility.public,
    );

    var iOS = const DarwinNotificationDetails(
      sound: 'default',
    );
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(DateTime.now().second,
        notification?.title, notification?.body, platform);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message==$message");
    // Utils.snackBar(
    //   message.notification!.title!,
    //   message.notification!.body!,
    // );

    // Get.offAll(NotificationScreen());
    // Get.to(() => NotificationScreen());
  }

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print("receive==$payload,== $body");
    // Get.to(NotificationScreen());
    // Get.to(() => NotificationScreen());
  }

  Future _selectNotification(String? payload) async {
    // Utils.snackBar('notification payload: ', payload!);
    print('notification payload: $payload');
    // Get.to(NotificationScreen());
    // Get.to(() => NotificationScreen());
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      print('notification payload: $payload');
      // Utils.snackBar(
      //   'notification payload: ',
      //   payload!,
      // );
      // Get.to(NotificationScreen());
      // Get.to(() => NotificationScreen());
    } else {
      // Utils.snackBar('notification payload: ', payload.toString());
      // // Get.to(NotificationScreen());
      // Get.to(() => NotificationScreen());
    }
  }

  static showCustomSnackbar(
      String title, String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/launcher.webp',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.black),
                  maxLines: 1,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(color: AppColors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.greyBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(
          bottom: Get.height - (Get.height * 0.28), left: 10, right: 10),
      dismissDirection: DismissDirection.up,
    );

    // Show the custom Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
