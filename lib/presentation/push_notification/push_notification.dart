import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';


class PushNotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static String? fcmToken;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static DarwinInitializationSettings initializationSettingsDarwin =const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  static firebaseNotification() async {
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.isAutoInitEnabled;
    var android = const AndroidInitializationSettings('@drawable/launch_background');
    var ios = const DarwinInitializationSettings();

    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    // firebaseMessaging.requestPermission();

    initLocalNotification();

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? appleNotification = message.notification?.apple;

        debugPrint(
            'message notification body=====${message.notification?.body}');
        debugPrint('notification body=====$notification.  $android.   $appleNotification');

        if (notification != null && android != null) {
          showNotification(message.notification);
          debugPrint('android not null notification==${message.notification}');
          FirebaseMessaging.instance.getInitialMessage().then((message) {
            if (message != null) {
              debugPrint("abc525");
            } else {
              debugPrint("123154115415abc");
            }
          });
        } else if (notification != null && appleNotification != null) {
          // await showNotification(message.notification);
          debugPrint('apple notification1');
          // Utils.snackBar1(
          //   message.notification!.title!,
          //   message.notification!.body!,
          // );
          showCustomSnackBar(notification.title.toString(), notification.body.toString(), Get.context!);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.notification != null) {
        // Get.offAll(NotificationScreen());
        showNotification(message.notification);
        // Get.to(() => NotificationScreen());
        print(message.notification);
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getToken().then((String? token) async {
      if (token == null) {
        debugPrint('FCM token is null');
      } else {
        fcmToken = token;
        debugPrint('FCM token: $token');
      }
    }).catchError((error) {
      debugPrint('Error getting FCM token: ${error.toString()}');
    });

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      debugPrint('FlutterFire Messaging Example: Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      debugPrint('FlutterFire Messaging Example: Got APNs token: $token');
    }
  }

  static Future initLocalNotification() async {
    if (Platform.isIOS) {
      var initializationSettingsAndroid = const AndroidInitializationSettings('ic_launcher');

      final InitializationSettings initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin);

      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    } else {
      var initializationSettingsAndroid =
      const AndroidInitializationSettings('@drawable/launch_background');

      const initializationSettingsIOS = DarwinInitializationSettings(
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

  static Future<void> showNotification(RemoteNotification? notification) async {
    var android = const AndroidNotificationDetails(
      'high_importance_channel',
      // 'CHANNLEID',
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
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
      sound: 'default',
    );
    var platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(DateTime.now().second,
        notification?.title, notification?.body, platform);
  }

  static Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    debugPrint("receive==$payload,== $body");
  }

  static Future _selectNotification(String? payload) async {
    debugPrint('notification payload: $payload');
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      debugPrint('notification payload: $payload');
    }
  }

  static showCustomSnackBar(String title, String message, BuildContext context) {
    final snackBar = SnackBar(

      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/launcher.webp',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1,),
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
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(bottom: Get.height - (Get.height * 0.35), top: 0,left: 10, right: 10),
      dismissDirection: DismissDirection.up,

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  // @pragma('vm:entry-point')
  // static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   log("Background Notification: ${message.notification?.body}");
  // }

// static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   log("background notification--> ${message.notification?.body}");
// }
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    log("📥 Background Notification: ${message.notification?.body}");
  }

  @pragma('vm:entry-point')
  void backgroundNotificationTap(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    debugPrint("🔙 Background Notification tapped. Payload: $payload");
  }

}

