import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/shared/theme/colors.dart';

void main() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          
          smartManagement: SmartManagement.full,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fade,
          themeMode: ThemeMode.system,
          title: 'Woye User',
          theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  }),
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                surface: Colors.white,
              ),
              useMaterial3: true,
              fontFamily: "Gilroy"),
          initialRoute: AppRoutes.initalRoute,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
