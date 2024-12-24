import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/core/utils/app_export.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("object firebase error $e");
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.light));
  Get.put(NetworkController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
          title: 'Woye User',
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
              fontFamily: "Gilroy"),
          getPages: AppRoutes.pages,
          initialRoute: AppRoutes.initalRoute,
        );
      },
    );
  }
}
