import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/common/Social_login/social_model.dart';
import '../../../Core/Utils/snackbar.dart';
import '../../../shared/theme/colors.dart';

class SocialLoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoading();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print('user crediental -------------$credential');
      print(
          'details------${googleUser?.displayName}---${googleUser
              ?.email}---${googleUser?.photoUrl}---${googleUser
              ?.id}----${googleUser?.serverAuthCode}  ===   ${googleAuth
              ?.accessToken}');
      final datad = await FirebaseAuth.instance.signInWithCredential(credential);

      String? displayName = googleUser?.displayName;
      String firstName = '';
      String lastName = '';


      if (displayName != null) {
        List<String> nameParts = displayName.split(' ');
        print(nameParts);
        if (nameParts.length > 1) {
          firstName = nameParts.first;
          lastName = nameParts.sublist(1).join(' ');
        } else {
          firstName = displayName;
        }
      }
      print("Login Details:");
      print("Email: ${googleUser?.email}");
      print("Name: $displayName");
      print("UID: ${googleUser?.id}");
      print("Photo: ${googleUser?.photoUrl}");
      print("Phone: ${datad.user?.phoneNumber ?? 'No phone number available'}");
      print("gender: ${datad.additionalUserInfo?.profile ?? 'No phone number available'}");
      //
      // Map body = {
      //   'socailite_type': 'google',
      //   'socailite_id': '${googleUser?.id}',
      //   'first_name': firstName,
      //   'last_name': lastName,
      //   'email': '${googleUser?.email}',
      //   'fcm_token': FirebaseApi.fcmToken
      // };
      //
      // final response = await api.post(EndPoints.socialLoginUrl, body);
      // print(response.body);
      // print(response.statusCode);
      // if(response.statusCode == 200){
      //   var data = SocialLoginModel.fromJson(response.body);
      //   if(data.status == true){
      //     LocalStorage.saveToken(data.data!.accessToken.toString());
      //     LocalStorage.saveUid(data.data!.userId.toString());
      //     Get.offAllNamed(Routes.navbarUi);
      //   }
      // }else if(response.statusCode == 401){
      //   showTostMsg('Login failed.It seems your account has been deleted.');
      // }else{
      //   showTostMsg('Login failed.');
      // }


      SocialLoginApi(
        email: googleUser!.email.toString(),
        id: googleUser.id.toString(),
        type: "google",
        name: displayName.toString(),
        mobile: datad.user!.phoneNumber.toString(),
      );

      // Get.back();
      // Get.offAllNamed(AppRoutes.signUpFom);

    } on FirebaseAuthException catch (e) {
      Get.back();
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
     Get.back();
      print('error == ${e.toString()}');
     SnackBarUtils.showToastCenter('Login failed. Please try again.');
    }
  }

  Future<void> facebookLogin(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        // permissions: ['email'],
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.i.getUserData(
          fields: "name,email",
        );
        final name = userData["name"];
        final email = userData["email"];
        final phone = userData["phone"] ?? "";

        String countryCode = "";
        String phoneNumber = phone;

        if (phone == null) {
          final parts = phone.split(' ');
          if (parts.length > 1) {
            countryCode = parts[0];
            phoneNumber = parts[1];
          }
        }

        print("User Name: $name");
        print("User Email: $email");
        print("User Phone: $phone");
        print("Country Code: $countryCode");
        print("Phone Number: $phoneNumber");

        // await SocialLoginApi(
        //   type: "facebook",
        //   email: email,
        //   id: accessToken.userId,
        //   name: name,
        //   mobile: phoneNumber,
        //   countryCode: countryCode,
        // );
      } else {
        print(result.message);
        SnackBarUtils.showToastCenter("${result.message}");
        Get.back();
      }
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
      print("An error occurred during Facebook login: $e");
      SnackBarUtils.showToastCenter(
          "An error occurred during Facebook login: $e");
      Get.back();
    }
  }

  Future<void> signout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    print("User signed out");
  }

  Future<void> appleLogin(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print("start");
      print(credential);
      print("email: ${credential.email}");
      print("name: ${credential.givenName}");
      print("name: ${credential.givenName}");
      print("suarname: ${credential.familyName}");
      print("identityToken: ${credential.identityToken}");
      print("authorizationCode: ${credential.authorizationCode}");
      print("userIdentifier:${credential.userIdentifier}");
      print("userIdentifier:${credential.email}");

      // await SocialLoginApi(
      //   type: "apple",
      //   email: credential.email.toString(),
      //   id: credential.userIdentifier.toString(),
      //   name: "${credential.givenName ?? ''} ${credential.familyName ?? ''}",
      //   mobile: "",
      //   countryCode: "",
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

final _api = Repository();

final rxRequestStatus = Status.COMPLETED.obs;
final socialLoginData = SocialModel().obs;
RxString error = ''.obs;
String token = '';

void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

void SocialDataSet(SocialModel value) => socialLoginData.value = value;

void setError(String value) => error.value = value;

UserPreference userPreference = UserPreference();

SocialLoginApi({
  required String email,
  required String type,
  required String id,
  required String name,
  required String mobile,
}) async {
  String? tokenFCM = await FirebaseMessaging.instance.getToken();

  UserModel userModel = UserModel();
  var pref = UserPreference();
  userModel = await pref.getUser();

  Map data = {
    'mailto:email': email,
    "fcm_token": tokenFCM.toString(),
    'step': userModel.token.toString() == 2 ? '2' : '1',
    'type': type.toString(),
    'name': name,
    'phone': mobile,
    'dob': "",
    "gender": "",
    'uuid': id,
  };
  print("WWWWWWWWWWWW$data");
  setRxRequestStatus(Status.LOADING);
  _api.SocialLoginApi(data, token).then((value) async {
    setRxRequestStatus(Status.COMPLETED);
    SocialDataSet(value);
    if (socialLoginData.value.status == true) {
      print("object ==========  await Analytics.loginEvent");
      // await Analytics.login_event(email, type);
      UserModel userModel = UserModel(
          token: socialLoginData.value.token.toString(),
          islogin: true,
          loginType: socialLoginData.value.type.toString(),
          step: socialLoginData.value.step
      );
      userPreference.saveUser(userModel).then((value) {
        Get.delete<SocialModel>();
        Get.back();
        Get.offAllNamed(AppRoutes.signUpFom);
      }).onError((error, stackTrace) {});
    } else {
      SnackBarUtils.showToastCenter(socialLoginData.value.message.toString());
      Get.back();
    }
  }).onError((error, stackTrace) {
    setError(error.toString());
    // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
    print('errrrrrrrrrrrr');
    print(error);
    print(stackTrace);
    // setRxRequestStatus(Status.ERROR);
    Get.back();
  });
}


  Future<void> showLoading() async {
    await Get.dialog(
      PopScope(
        canPop: false, // Prevents dialog from being dismissed
        child: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColors.primary,
            size: 30,
          ),
        ),
      ),
      barrierDismissible: false, // Prevents user from dismissing the dialog
    );
  }


}
