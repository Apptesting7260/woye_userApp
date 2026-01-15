import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/model/maintenance_mode_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../../../shared/theme/font_family.dart';
import 'model/version_check_model.dart';

class MaintenanceModeController extends GetxController{

  final api = Repository();

  String version = "";

  @override
  void onInit() async {
    // await getAppVersion();
    // await maintenanceModeApi();
    // await versionCheckApi();
    super.onInit();
  }

  final  apiData = MaintenanceModel().obs;

  void setApiData(MaintenanceModel value) => apiData.value = value;

  Future<void> maintenanceModeApi()async{
    api.maintenanceApi().then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        // Utils.showToast(apiData.value.message ?? "");
        pt("maintenance data>>>>>>>>  ${apiData.value.message ?? ""}");
        if(apiData.value.maintenance.toString() == "1"){
          Get.offAllNamed(AppRoutes.maintenance);
        }
      }else{
        pt("maintenance data else >>>>>>>>  ${apiData.value.message ?? ""}");
      }
    },).onError((error, stackTrace) {
      pt('>>>>>>>>>>>>maintenance $error');
      pt('>>>>>>>>>>>>maintenance $stackTrace');
    },);
  }

  //-------------------------------------------Version Check-------------------------------------

  final  apiDataVCheck = VersionCheckModel().obs;

  void setApiDataVCheck(VersionCheckModel value) => apiDataVCheck.value = value;

  Future<void> versionCheckApi()async{
    await getAppVersion();
    api.versionCheckApi().then((value) {
      setApiDataVCheck(value);
      // if(apiDataVCheck.value.status == true){
      //   pt("Version data>>>>>>>>  ${apiDataVCheck.value.message ?? ""}");
      //   if(Get.context != null && apiDataVCheck.value.userAppVersion.toString() !=  version.toString() && apiDataVCheck.value.userAppVersion != null){
      //     showDialog(
      //       context: Get.context!,
      //       builder: (_) => updaterPopUp(newVersion: apiDataVCheck.value.userAppVersion ?? "",oldVersion: version),
      //     );
      //   }
      // }else{
      //   pt("Version data else >>>>>>>>  ${apiDataVCheck.value.message ?? ""}");
      // }
    },).onError((error, stackTrace) {
      pt('>>>>>>>>>>>>Version data $error');
      pt('>>>>>>>>>>>>Version data $stackTrace');
    },);
  }

  PopScope<dynamic> updaterPopUp({required String newVersion,required String oldVersion}) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Center(
          child: Text("Update App",
            style: AppFontStyle.text_18_500(AppColors.black,family: AppFontFamily.onestMedium),
          ),
        ),
        content: Text("A new version of  is available! Version $newVersion is now available - you have $oldVersion.",
          style: AppFontStyle.text_16_400(AppColors.black,family: AppFontFamily.onestRegular),
          maxLines: 5,
          textAlign: TextAlign.center,
        ),
        actions: [
          CustomElevatedButton(
            onPressed: ()async{
              final url = Uri.parse("https://play.google.com/apps/test/RQ_C7Rv57aY/ahAO29uNQaXYpup58H-VcJMJCROSbXVmOdlFm6BYt8mOzKkABK3BsxaSvhKQAPF-IT6qUV6GXg60TqRfsT4DQfyE1C");
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.platformDefault);
                SystemNavigator.pop();
              } else {
                print('Could not launch the URL');
              }
            },text: "Update Now",)
        ],
      ),
    );
  }


  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("App Name: $appName");
    print("Version>>>>>>>>>>>>>>>>>: $version");
    print("Build Number: $buildNumber");
  }


  String extractVersion(String input) {
    final RegExp versionPattern = RegExp(r'\b\d+\.\d+\.\d+\b');
    final Match? match = versionPattern.firstMatch(input);
    return match?.group(0) ?? '';
  }


}