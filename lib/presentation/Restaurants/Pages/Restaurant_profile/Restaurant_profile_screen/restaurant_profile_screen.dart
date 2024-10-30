import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_profile/Controller/restaurant_profile_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantProfileScreen extends StatelessWidget {
  const RestaurantProfileScreen({super.key});

  static final RestaurantProfileController restaurantProfileController =
      Get.put(RestaurantProfileController());
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
            profileOptions(),
          ],
        ),
      ),
    );
  }

  Container profileDetails(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: imagePicker(context, restaurantProfileController),
          ),
          // CircleAvatar(
          //   radius: 30.r,
          //   backgroundImage: const AssetImage(
          //       'assets/images/profile-image.png'), // Replace with user's image
          // ),
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

  Column profileOptions() {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset("assets/svg/profile-dark.svg"),
          title: Text(
            'Edit Profile',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to edit profile
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/cart-dark.svg"),
          title: Text(
            'Orders',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to orders
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/location-pin-dark.svg"),
          title: Text(
            'Delivery Address',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Get.toNamed(AppRoutes.deliveryAddressScreen);
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/payment-card-dark.svg"),
          title: Text(
            'Payment Method',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to payment method
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/wallet-dark.svg"),
          title: Text(
            'My Wallet',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to wallet
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/coupon-dark.svg"),
          title: Text(
            'Promotion Code',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Get.toNamed(AppRoutes.promoCode);
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/profile-dark.svg"),
          title: Text(
            'Invite Friends',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to invite friends
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/settings-dark.svg"),
          title: Text(
            'Settings',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to settings
          },
        ),
        ListTile(
          leading: SvgPicture.asset("assets/svg/help-dark.svg"),
          title: Text(
            'Help',
            style: AppFontStyle.text_16_500(AppColors.darkText),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to help
          },
        ),
        // Logout Option
        ListTile(
          leading: SvgPicture.asset("assets/svg/logout.svg"),
          title: Text(
            'Logout',
            style: AppFontStyle.text_16_500(AppColors.primary),
          ),
          onTap: () {
            // Handle logout
          },
        ),
        hBox(100)
      ],
    );
  }

  Widget imagePicker(BuildContext context,
      RestaurantProfileController restaurantProfileController) {
    return GestureDetector(
      onTap: () {
        bottomSheet(context);
      },
      child: GetBuilder(
          init: restaurantProfileController,
          builder: (context) {
            return SizedBox(
              height: 80.h,
              child: Stack(
                children: [
                  Container(
                      width: 80.h,
                      height: 80.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          // shape: BoxShape.circle,
                          border: Border.all(
                              color: restaurantProfileController.image == null
                                  ? Colors.transparent
                                  : Colors.transparent)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: restaurantProfileController.image == null
                            ? CircleAvatar(
                                backgroundColor:
                                    AppColors.greyBackground.withOpacity(0.5),
                                child: Icon(
                                  Icons.person,
                                  size: 60.h,
                                  color: AppColors.lightText.withOpacity(0.5),
                                ))
                            : Image.file(
                                restaurantProfileController.image!,
                                fit: BoxFit.cover,
                              ),
                      )),
                  Positioned(
                    bottom: 5.h,
                    right: 2.w,
                    child: Container(
                      width: 22.h,
                      height: 22.h,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(color: AppColors.primary)),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 12.h,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future bottomSheet(BuildContext context) {
    final RestaurantProfileController controller =
        Get.find<RestaurantProfileController>();
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          gapPadding: 0,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        ),
        showDragHandle: true,
        constraints: BoxConstraints(maxHeight: 218.h),
        elevation: 12.w,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r)),
              color: Colors.white,
              // gradient: LinearGradient(
              //     colors: [Colors.white, AppColors.primary.withOpacity(0.05)],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: REdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text("Pick an Image",
                      style: GoogleFonts.poppins(
                        textStyle:
                            AppFontStyle.text_18_400(AppColors.mediumText),
                      )),
                  hBox(18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.pickImageFromCamera();
                          // _pickImageFromCamera();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: REdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.r)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                color: AppColors.lightText,
                                size: 24.h,
                              ),
                              Text(
                                "Camera",
                                style: AppFontStyle.text_16_400(
                                    AppColors.lightText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pickImageFromGallery();

                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: REdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.r)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_library_outlined,
                                color: AppColors.lightText,
                                size: 24.h,
                              ),
                              Text(
                                "Gallery",
                                style: AppFontStyle.text_16_400(
                                    AppColors.lightText),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
