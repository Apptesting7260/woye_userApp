import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'dart:io';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/maintenance_mode_controller.dart';
import 'package:woye_user/presentation/common/app_link/deeplinkingController.dart';
import 'package:woye_user/presentation/push_notification/push_notification.dart';
import 'firebase_options.dart';

var inSplash = true.obs;
// final PushNotificationService  _notificationService = PushNotificationService();
final deepLinkController = Get.put(DeepLinkController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: "assets/.env");
  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    print("Failed to load .env file: $e");
  }
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("object firebase error $e");
  }
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: Colors.transparent,
  //     statusBarBrightness: Brightness.light));
  PushNotificationService.firebaseNotification();
  Get.put(NetworkController());
  Get.put(MaintenanceModeController());
  await GetStorage.init();
  // try {
  //   /// FIREBADE CRASHLYTICS ///..................................................
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  // } catch (e) {
  //   print(e);
  // }

  ///deepLinks

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var topColor = (AppColors.darkText).obs;



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        deepLinkController.initDeepLinks();
      } catch (e) {
        print("deeplink error $e");
      }
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(
      Duration(milliseconds: (Platform.isIOS) ? 2500 : 5000),
      () {
        topColor.value = Colors.white;
      },
    );
    return SafeArea(
      top: false,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            enableLog: true,
            smartManagement: SmartManagement.full,
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fade,
            themeMode: ThemeMode.system,
            title: 'Woye',
            theme: ThemeData(
                pageTransitionsTheme: const PageTransitionsTheme(
                    builders: <TargetPlatform, PageTransitionsBuilder>{
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.android: CupertinoPageTransitionsBuilder()
                    }),
                dividerTheme: DividerThemeData(color: AppColors.textFieldBorder),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primary,
                  surface: Colors.white,
                ),
                useMaterial3: true,
                fontFamily: AppFontFamily.gilroyRegular),
                // fontFamily: "Gilroy"),
            getPages: AppRoutes.pages,
            initialRoute: AppRoutes.initalRoute,
            builder: (context, child) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              return Obx(
                () => AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                      statusBarColor:
                          inSplash.value ? AppColors.darkText : Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.transparent,
                      statusBarBrightness: Brightness.light,
                  ),
                  child: inSplash.value
                      ? child!
                      : ColorfulSafeArea(
                          topColor: Colors.white,
                          // bottomColor: AppColor.whiteColor,
                          minimum: const EdgeInsets.only(
                            bottom: 0,
                          ),
                          maintainBottomViewPadding: true,
                          top: true,
                          bottom: false,
                          child: Scaffold(
                            extendBodyBehindAppBar: true,
                            extendBody: true,
                            body: child,
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
