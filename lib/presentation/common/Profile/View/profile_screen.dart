import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Controller/profile_controller.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';

import '../../../../Data/userPrefrenceController.dart';
import '../../../Pharmacy/Pharmacy_navbar/controller/pharmacy_navbar_controller.dart';
import '../../Social_login/social_controller.dart';

class ProfileScreen extends StatelessWidget {
  String? profileScreenType;
  ProfileScreen({super.key,this.profileScreenType});

  // UserModel userModel = UserModel();

  static final ProfileController restaurantProfileController =  Get.put(ProfileController());

  // final RestaurantHomeController restaurantHomeController =  Get.put(RestaurantHomeController());

  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  final SocialLoginController socialLoginController = Get.put(SocialLoginController());

  // final PharmacyNavbarController pharmacyNavbarController = PharmacyNavbarController();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    if(profileScreenType != null) {
      print("profileScreenType : $profileScreenType");
    }
    return Scaffold(
      appBar: CustomAppBar(
        isActions: true,
        isLeading: false,
        title: Text(
          "My Profile",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            profileDetails(context),
            hBox(30),
            //
            editProfile(context),
            //
            orders(context),
            //
            wishList(context),
            //
            deliveryAddress(context),
            //
            paymentMethod(context),
            //
            myWallet(context),
            //
            promotionalCodes(context),
            //
            inviteFriends(context),
            //
            settings(context),
            //
            help(context),
            //
            logout(context),
            hBox(100),
          ],
        ),
      ),
    );
  }

  Widget profileDetails(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.ultraLightPrimary,
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: getUserDataController.userData.value.user?.imageUrl
                        .toString() !=
                    null
                ? Obx(
                    () => Container(
                        width: 80.h,
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: CachedNetworkImage(
                              imageUrl:getUserDataController.userData.value.user!.imageUrl.toString(),
                              placeholder: (context, url) => const ShimmerWidget(),
                              errorWidget: (context, url, error) => Container(
                                width: 80.h,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  color: AppColors.greyBackground.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 40.h,
                                  color: AppColors.lightText.withOpacity(0.5),
                                ),
                              ),
                              fit: BoxFit.cover,
                            ))),
                  )
                : Container(
                    width: 80.h,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: CircleAvatar(
                            backgroundColor:
                                AppColors.greyBackground.withOpacity(0.5),
                            child: Icon(
                              Icons.person,
                              size: 40.h,
                              color: AppColors.lightText.withOpacity(0.5),
                            )))),
          ),
          wBox(15),
          getUserDataController.userData.value.user?.userType != "guestUser"
              ? Obx(
                  () => Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getUserDataController
                                  .userData.value.user?.firstName?.characters
                                  .toString() ??
                              "",
                          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                        ),
                        hBox(10),
                        Text(
                          getUserDataController.userData.value.user?.email ??
                              "",
                          style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                )
              : Text(
                  "guest User".toUpperCase(),
                  style: AppFontStyle.text_14_800(AppColors.darkText),
                ),
        ],
      ),
    );
  }

  Widget editProfile(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/profile-dark.svg"),
      title: Text(
        'Edit Profile',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType == "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(
            AppRoutes.signUpFom,
            arguments: {
              'typefrom': "back",
            },
          );
        }
      },
    );
  }

  Widget orders(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/cart-dark.svg"),
      title: Text(
        'Orders',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
        // style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType =="guestUser") {
          showLoginRequired(context);
        } else {
          pt("screen>>>>>>>>>>>>>>>>>>>>> $profileScreenType");
          Get.toNamed(AppRoutes.orders,
          arguments: {
            "screenType" : profileScreenType,
            }
          );
          pt("screen>>>>>>>>>>>>>>>>>>>>>12 $profileScreenType");

        }
      },
    );
  }

  Widget wishList(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/wishlist.svg", color: AppColors.black),
      title: Text(
        'Wishlist',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
        // style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        Get.toNamed(AppRoutes.restaurantWishlistScreen);
      },
    );
  }

  Widget deliveryAddress(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/location-pin-dark.svg"),
      title: Text(
        'Delivery Address',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.deliveryAddressScreen, arguments: {
            'type': "Profile",
            "fromcart": false,
          });
        }
      },
    );
  }

  Widget paymentMethod(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/payment-card-dark.svg"),
      title: Text(
        'Payment Method',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.paymentMethod);
        }
      },
    );
  }

  Widget myWallet(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/wallet-dark.svg"),
      title: Text(
        'My Wallet',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.myWallet);
        }
      },
    );
  }

  Widget promotionalCodes(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/coupon-dark.svg"),
      title: Text(
        'Promotion Code',
        style: AppFontStyle.text_17_400(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.promoCode);
        }
      },
    );
  }

  Widget inviteFriends(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/profile-dark.svg"),
      title: Text(
        'Invite Friends',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.inviteFriends);
        }
      },
    );
  }

  Widget settings(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/settings-dark.svg"),
      title: Text(
        'Settings',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.settings);
        }
      },
    );
  }

  Widget help(context) {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/svg/help-dark.svg"),
      title: Text(
        'Help',
        style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.onestMedium),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
      onTap: () {
        if (getUserDataController.userData.value.user?.userType ==
            "guestUser") {
          showLoginRequired(context);
        } else {
          Get.toNamed(AppRoutes.help);
        }
      },
    );
  }

  Widget logout(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/logout.svg"),
      title: Text(
        'Logout',
        style: AppFontStyle.text_17_400(AppColors.primary,family: AppFontFamily.onestMedium),
      ),
      onTap: () {
        logoutPopUp(context);
      },
    );
  }

  Future<dynamic> logoutPopUp(context) {
    return showCupertinoModalPopup(
        // barrierDismissible: true,/
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            backgroundColor: AppColors.white,
            content: Container(
              height: 150.h,
              width: 320.w,
              padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logout',
                    style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestMedium),
                  ),
                  // hBox(15),
                  Text(
                    'Are you sure you want to log out?',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                  ),
                  // hBox(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          color: AppColors.black,
                          onPressed: () {
                            Get.back();
                          },
                          text: "Cancel",
                          textStyle:
                              AppFontStyle.text_14_500(AppColors.white,family: AppFontFamily.onestMedium),
                        ),
                      ),
                      wBox(15),
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          textStyle:AppFontStyle.text_14_500(AppColors.white,family: AppFontFamily.onestMedium),
                          onPressed: () {
                           /* socialLoginController.signout();
                            userPreference.removeUser();
                            Get.offAllNamed(AppRoutes.welcomeScreen);*/
                            restaurantProfileController.logoutUser();
                          },
                          text: "Logout",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future showLoginRequired(context) {
    return showCupertinoModalPopup(
        // barrierDismissible: true,/
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            content: Container(
              height: 150.h,
              width: 320.w,
              padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Login Required',
                    style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestMedium),
                  ),
                  // hBox(15),
                  Text(
                    'You need to log in first',
                    style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                  ),
                  // hBox(15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          color: AppColors.black,
                          onPressed: () {
                            Get.back();
                          },
                          text: "Cancel",
                          textStyle:
                              AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                        ),
                      ),
                      wBox(15),
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          onPressed: () {
                            userPreference.removeUser();
                            Get.offAllNamed(AppRoutes.signUp);
                          },
                          text: "Login",
                          textStyle:
                          AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
