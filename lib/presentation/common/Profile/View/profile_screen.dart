import 'package:flutter/cupertino.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Controller/profile_controller.dart';

import '../../../../Data/userPrefrenceController.dart';
import '../../Social_login/social_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // UserModel userModel = UserModel();

  static final ProfileController restaurantProfileController =
      Get.put(ProfileController());

  final SocialLoginController socialLoginController =
      Get.put(SocialLoginController());

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isActions: true,
        isLeading: false,
        title: Text(
          "My Profile",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            profileDetails(context),
            hBox(30),
            //
            editProfile(),
            //
            orders(),
            //
            deliveryAddress(),
            //
            paymentMethod(),
            //
            myWallet(),
            //
            promotionalCodes(),
            //
            inviteFriends(),
            //
            settings(),
            //
            help(),
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
            child: Container(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jone Deo',
                style: AppFontStyle.text_18_600(AppColors.darkText),
              ),
              hBox(10),
              Text(
                'yourname@gmail.com',
                style: AppFontStyle.text_14_400(AppColors.darkText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget editProfile() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/profile-dark.svg"),
      title: Text(
        'Edit Profile',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(
          AppRoutes.signUpFom,
          arguments: {
            'typefrom': "back",
          },
        );
        // Get.toNamed(AppRoutes.editProfile);
      },
    );
  }

  Widget orders() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/cart-dark.svg"),
      title: Text(
        'Orders',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.orders);
      },
    );
  }

  Widget deliveryAddress() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/location-pin-dark.svg"),
      title: Text(
        'Delivery Address',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.deliveryAddressScreen);
      },
    );
  }

  Widget paymentMethod() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/payment-card-dark.svg"),
      title: Text(
        'Payment Method',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Navigate to payment method
        Get.toNamed(AppRoutes.paymentMethod);
      },
    );
  }

  Widget myWallet() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/wallet-dark.svg"),
      title: Text(
        'My Wallet',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.myWallet);
      },
    );
  }

  Widget promotionalCodes() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/coupon-dark.svg"),
      title: Text(
        'Promotion Code',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.promoCode);
      },
    );
  }

  Widget inviteFriends() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/profile-dark.svg"),
      title: Text(
        'Invite Friends',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.inviteFriends);
      },
    );
  }

  Widget settings() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/settings-dark.svg"),
      title: Text(
        'Settings',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.settings);
      },
    );
  }

  Widget help() {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/help-dark.svg"),
      title: Text(
        'Help',
        style: AppFontStyle.text_16_500(AppColors.darkText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Get.toNamed(AppRoutes.help);
      },
    );
  }

  Widget logout(context) {
    return ListTile(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      leading: SvgPicture.asset("assets/svg/logout.svg"),
      title: Text(
        'Logout',
        style: AppFontStyle.text_16_500(AppColors.primary),
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
                    'Logout',
                    style: AppFontStyle.text_18_600(AppColors.darkText),
                  ),
                  // hBox(15),
                  Text(
                    'Are you sure you want to log out?',
                    style: AppFontStyle.text_14_400(AppColors.lightText),
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
                              AppFontStyle.text_14_400(AppColors.darkText),
                        ),
                      ),
                      wBox(15),
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          onPressed: () {
                            socialLoginController.signout();
                            userPreference.removeUser();
                            Get.offAllNamed(AppRoutes.welcomeScreen);
                          },
                          text: "Yes,Logout",
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
