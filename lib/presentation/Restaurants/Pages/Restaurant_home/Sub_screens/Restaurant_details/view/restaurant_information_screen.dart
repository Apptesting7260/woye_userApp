/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../../../../../Shared/theme/font_family.dart';
import '../../Reviews/controller/more_products_controller.dart';
import '../controller/RestaurantDetailsController.dart';

class RestaurantInformationScreen extends StatefulWidget {
  const RestaurantInformationScreen({super.key});

  @override
  State<RestaurantInformationScreen> createState() => _RestaurantInformationScreenState();
}

class _RestaurantInformationScreenState extends State<RestaurantInformationScreen> {
  final RestaurantDetailsController controller =  Get.put(RestaurantDetailsController());
  final SeeAllProductReviewController seeAllProductReviewController =  Get.put(SeeAllProductReviewController());

  String restaurantId = "";
  @override
  void initState() {
    var arguments = Get.arguments ?? {};
    restaurantId = arguments['restaurantId'] ?? "";
    pt("restaurantId >>>>>>>>>>>> $restaurantId");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Obx(
            ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameEmailAdd(),
                hBox(35.h),
                openHours(),
                description(),
                // if (controller.restaurant_Data.value.review!.isNotEmpty)
                //   reviews(),
                hBox(100.h),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget openHours() {
    var openingHours =
        controller.restaurant_Data.value.restaurant!.openingHours;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Open Hours",
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(14),
        for (var openingHour in openingHours!)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              // width: Get.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    openingHour.day ?? "",
                    style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    openingHour.status == null
                        ? 'Closed'
                        : "${openingHour.open} - ${openingHour.close}",
                    style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:  MainAxisAlignment.start,
      children: [
        Text(
          "Descriptions",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10),
        Text(
          controller.restaurant_Data.value.restaurant!.shopDes.toString(),
          maxLines: 100,
          style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        ),
      ],
    );
  }

  Widget reviews() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews",
            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
          hBox(15.h),
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                // itemCount: controller.restaurant_Data.value.review!.length,
                itemBuilder: (context, index) {
                  return controller.restaurant_Data.value.review![index].user !=
                      null
                      ? Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: CachedNetworkImage(
                              imageUrl: controller.restaurant_Data.value
                                  .review![index].user!.imageUrl
                                  .toString(),
                              fit: BoxFit.cover,
                              height: 50.h,
                              width: 50.h,
                              errorWidget: (context, url, error) =>
                                  Center(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.h,
                                        color: AppColors.gray.withOpacity(.2),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColors.gray,
                                        ),
                                      )),
                              placeholder: (context, url) =>
                                  Shimmer.fromColors(
                                    baseColor: AppColors.gray,
                                    highlightColor: AppColors.lightText,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.gray,
                                        borderRadius:
                                        BorderRadius.circular(20.r),
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          wBox(15),
                          Flexible(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.bgColor,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .restaurant_Data
                                              .value
                                              .review![index]
                                              .user!
                                              .firstName
                                              .toString(),
                                          style: AppFontStyle.text_16_400(
                                              AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                        ),
                                        hBox(5),
                                        RatingBar.readOnly(
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star,
                                          filledColor: AppColors.goldStar,
                                          emptyColor:
                                          AppColors.normalStar,
                                          initialRating: double.parse(
                                              controller
                                                  .restaurant_Data
                                                  .value
                                                  .review![index]
                                                  .rating!
                                                  .toString()),
                                          maxRating: 5,
                                          size: 20.h,
                                        ),
                                        hBox(10),
                                        Text(
                                          controller.restaurant_Data.value
                                              .review![index].message
                                              .toString(),
                                          style: AppFontStyle.text_16_400(
                                              AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                          maxLines: 3,
                                        ),
                                        hBox(10),
                                        Text(
                                          controller.formatDate(controller
                                              .restaurant_Data
                                              .value
                                              .review![index]
                                              .updatedAt
                                              .toString()),
                                          style: AppFontStyle.text_16_400(
                                              AppColors.lightText,family: AppFontFamily.gilroyRegular),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (controller.restaurant_Data.value
                                    .review![index].reply !=
                                    null)
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.reply,
                                          color: AppColors.primary,
                                        ),
                                        Flexible(
                                          child: Text(
                                            controller
                                                .restaurant_Data
                                                .value
                                                .review![index]
                                                .reply
                                                .toString()
                                                .trim(),
                                            style:
                                            AppFontStyle.text_16_400(
                                                AppColors.lightText,family: AppFontFamily.gilroyMedium),
                                            maxLines: 100,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: REdgeInsets.symmetric(vertical: 10),
                        child: const Divider(),
                      ),
                    ],
                  )
                      : const SizedBox();
                },
              ),
            ],
          ),
          controller.restaurant_Data.value.totalReviews!.toInt() > 0
              ? Column(
            children: [
              hBox(10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.productReviews,
                    arguments: {
                      'product_id': restaurantId.toString(),
                      'product_review':
                      controller.restaurant_Data.value.averageRating,
                      'review_count': controller
                          .restaurant_Data.value.totalReviews
                          .toString(),
                      "type": "restaurant",
                    },
                  );
                  seeAllProductReviewController.seeAllProductReviewApi(
                      vendorId: restaurantId.toString(),
                      type: "restaurant");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "See All (${controller.restaurant_Data.value.totalReviews.toString()})",
                      style: AppFontStyle.text_14_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 20.h,
                    )
                  ],
                ),
              ),
            ],
          )
              : const SizedBox(),
        ],
      ),
    );
  }


  Widget nameEmailAdd(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     */
/* Row(
        children: [
           Icon(Icons.person_outline_rounded,color: AppColors.black.withOpacity(0.8),size: 25,),
          wBox(8),
          Flexible(
            child: Text(
              "${controller.restaurant_Data.value.restaurant!.firstName ?? ""} ${controller.restaurant_Data.value.restaurant!.lastName ?? ""}",
              style: TextStyle(
                  fontSize: 17.sp,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamily.gilroyRegular
              ),
            ),
          )
        ],
      ),
      hBox(12.h),
      Row(
        children: [
           Icon(Icons.mail_outline_rounded,color: AppColors.black.withOpacity(0.8),size: 24,),
          wBox(8),
          Flexible(
            child: Text(
              controller.restaurant_Data.value.restaurant!.email.toString(),
              overflow: TextOverflow.ellipsis,
              style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
            ),
          )
        ],
      ),
      hBox(12.h),*//*

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Icon(Icons.location_on_outlined,color: AppColors.black.withOpacity(0.8),size: 25,),
          wBox(8),
          Flexible(
            child: Text(
              controller.restaurant_Data.value.restaurant!.shopAddress
                  .toString(),
              maxLines: 50,
              overflow: TextOverflow.ellipsis,
              style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
            ),
          )
        ],
      ),
        // hBox(12.h),
        // Row(children: [
        //   wBox(30.h),
        //   Text(
        //     "${controller.travelTime.toStringAsFixed(0)} Min",
        //     // "32min",
        //     style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
        //   ),
        //   wBox(4),
        //   Text(
        //     "•",
        //     style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
        //   ),
        //   wBox(4),
        //   Text(
        //     // "2km",
        //     "${controller.distance.toStringAsFixed(2)} KM",
        //     style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
        //   ),
        // ],)
    ],);
  }
}
*/


import 'package:cached_network_image/cached_network_image.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import '../../../../../../../Shared/theme/font_family.dart';
import '../../Reviews/controller/more_products_controller.dart';
import '../controller/RestaurantDetailsController.dart';

class RestaurantInformationScreen extends StatefulWidget {
  const RestaurantInformationScreen({super.key});

  @override
  State<RestaurantInformationScreen> createState() => _RestaurantInformationScreenState();
}

class _RestaurantInformationScreenState extends State<RestaurantInformationScreen> {
  final RestaurantDetailsController controller = Get.put(RestaurantDetailsController());
  final SeeAllProductReviewController seeAllProductReviewController = Get.put(SeeAllProductReviewController());

  String restaurantId = "";
  @override
  void initState() {
    var arguments = Get.arguments ?? {};
    restaurantId = arguments['restaurantId'] ?? "";
    pt("restaurantId >>>>>>>>>>>> $restaurantId");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRestaurantBanner(),
                    hBox(25.h),

                    // Restaurant Header Card
                    _buildRestaurantHeader(),
                    hBox(25.h),

                    // Restaurant Info Section
                    _buildRestaurantInfo(),
                    hBox(25.h),

                    // Social Media Section
                    _buildSocialMedia(),
                    hBox(30.h),

                    // Delivery & Service Info
                    _buildDeliveryServiceInfo(),
                    hBox(25.h),

                    // Open Hours
                    _buildOpenHours(),
                    hBox(100.h),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantBanner() {
    return Container(
      height: 180.h,
      width: double.infinity,
      margin: REdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        image: DecorationImage(
          image: AssetImage("assets/images/restaurant_banner.png"), // Add your banner image
          fit: BoxFit.cover,
        ),
      ),
      // If you're using network image instead:
      child: CachedNetworkImage(
        imageUrl: "YOUR_BANNER_IMAGE_URL", // Add your banner URL
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.gray.withOpacity(0.1),
          child: Icon(
            Icons.restaurant,
            size: 50.h,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant Name
        Text(
          controller.restaurant_Data.value.restaurant!.shopName.toString(),
          style: AppFontStyle.text_20_500(AppColors.black, family: AppFontFamily.gilroySemiBold),
        ),
        hBox(12.h),

        // Rating and Delivery Info
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              height: 15,
            ),
            wBox(4),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "${controller.restaurant_Data.value.averageRating.toString()}/5",
                style: AppFontStyle.text_14_400(AppColors.darkText,
                    family: AppFontFamily.gilroyRegular),
              ),
            ),
            wBox(3),
            Text(
              " • ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText,
                  family: AppFontFamily.gilroyRegular),
            ),
            SvgPicture.asset(
              ImageConstants.scooterImage,
              height: 14,
              colorFilter: ColorFilter.mode(
                  AppColors.darkText.withOpacity(0.8), BlendMode.srcIn),
            ),
            wBox(3.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                // "\$5 Delivery",
                '\$${controller.restaurant_Data.value.averageRating} Deliveries',
                style: AppFontStyle.text_12_400(AppColors.darkText,
                    family: AppFontFamily.gilroyRegular),
              ),
            ),
            Text(
              " • ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText,
                  family: AppFontFamily.gilroyRegular),
            ),
            SvgPicture.asset(
              ImageConstants.cartIconImage,
              height: 14,
              colorFilter:
              ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
            ),
            wBox(3.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "No min. order",
                style: AppFontStyle.text_12_400(AppColors.darkText,
                    family: AppFontFamily.gilroyRegular),
              ),
            ),
          ],
        ),
        hBox(16.h),
        // Description
        Text(
          // "Authentic Italian cuisine with fresh ingredients and traditional recipes. Family owned restaurant serving the community for over 15 years.",
          controller.restaurant_Data.value.message.toString(),
          style: AppFontStyle.text_16_400(AppColors.lightText, family: AppFontFamily.gilroyRegular),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildRestaurantInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restaurants Info",
          style: AppFontStyle.text_20_500(AppColors.darkText, family: AppFontFamily.gilroySemiBold),
        ),
        hBox(16.h),

        // Name
        Row(
          children: [
            Icon(
              Icons.person_outline,
              color: AppColors.mediumText,
              size: 30.h,
            ),
            wBox(12),
            Text(
              "${controller.restaurant_Data.value.restaurant!.firstName} ${controller.restaurant_Data.value.restaurant!.lastName}",
              style: AppFontStyle.text_16_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(12.h),

        // Phone
        Row(
          children: [
            Icon(
              Icons.phone_outlined,
              color: AppColors.mediumText,
              size: 30.h,
            ),
            wBox(12),
            Text(
              controller.restaurant_Data.value.restaurant!.phone.toString(),
              style: AppFontStyle.text_16_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(12.h),

        // Email
        Row(
          children: [
            Icon(
              Icons.mail_outline,
              color: AppColors.mediumText,
              size: 30.h,
            ),
            wBox(12),
            Text(
              controller.restaurant_Data.value.restaurant!.email.toString(),
              style: AppFontStyle.text_16_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(12.h),

        // Website
        Row(
          children: [
            Icon(
              Icons.language_outlined,
              color: AppColors.mediumText,
              size: 30.h,
            ),
            wBox(12),
            Text(
              controller.restaurant_Data.value.restaurant!.shopEmail .toString(),
              style: AppFontStyle.text_16_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(12.h),

        // Address
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.mediumText,
              size: 30.h,
            ),
            wBox(12),
            Expanded(
              child: Text(
                controller.restaurant_Data.value.restaurant!.shopAddress.toString(),
                style: AppFontStyle.text_16_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialMedia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Social Media!",
          style: AppFontStyle.text_20_500(AppColors.darkText, family: AppFontFamily.gilroySemiBold),
        ),
        hBox(12.h),

        // Social Media Icons (You can add actual social media links here)
        Row(
          children: [
            _buildSocialIcon('assets/svg/fb-logo.svg'),
            wBox(16),
            _buildSocialIcon('assets/svg/instagram-logo.svg'),
            wBox(16),
            _buildSocialIcon('assets/svg/twitter-logo.svg'),
            wBox(16),
            _buildSocialIcon('assets/svg/youtube-logo'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String iconPath) {
    return SvgPicture.asset(
      iconPath,
      height: 20.h,
      width: 20.h,
    );
  }

  Widget _buildDeliveryServiceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery & Service Info",
          style: AppFontStyle.text_20_500(AppColors.darkText, family: AppFontFamily.gilroySemiBold),
        ),
        hBox(16.h),

        // Service Types
        Row(
          children: [
            _buildServiceChip("Dine-in"),
            wBox(8),
            _buildServiceChip("Delivery"),
          ],
        ),
        hBox(16.h),

        // Preparation Time
        Text(
          "10-15 mins Avg Preparation",
          style: AppFontStyle.text_14_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
        ),
        hBox(12.h),

        // Minimum Order
        Text(
          "\$0 Minimum order",
          style: AppFontStyle.text_14_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
        ),
      ],
    );
  }

  Widget _buildServiceChip(String text) {
    return Text(
      text,
      style: AppFontStyle.text_14_500(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
    );
  }

  Widget _buildOpenHours() {
    var openingHours = controller.restaurant_Data.value.restaurant!.openingHours;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Open Hours",
          style: AppFontStyle.text_20_500(AppColors.darkText, family: AppFontFamily.gilroySemiBold),
        ),
        hBox(16.h),

        // Days Table
        if (openingHours != null && openingHours.isNotEmpty)
          ...openingHours.map((openingHour) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    openingHour.day ?? "",
                    style: AppFontStyle.text_16_400(AppColors.darkText, family: AppFontFamily.gilroyRegular),
                  ),
                  Text(
                    openingHour.status == null
                        ? 'Closed'
                        : "${openingHour.open} - ${openingHour.close}",
                    style: openingHour.status == null
                        ? AppFontStyle.text_16_400(AppColors.lightText.withOpacity(0.5), family: AppFontFamily.gilroyRegular)
                        : AppFontStyle.text_16_400(AppColors.black, family: AppFontFamily.gilroyRegular),
                  ),
                ],
              ),
            );
          }).toList()
        else
        // Default hours from image
          Column(
            children: [
              _buildDayRow("Monday", "\$100 AM - 10:00 PM"),
              _buildDayRow("Tuesday", "\$100 AM - 10:00 PM"),
              _buildDayRow("Wednesday", "\$100 AM - 10:00 PM"),
              _buildDayRow("Thursday", "\$100 AM - 10:00 PM"),
              _buildDayRow("Friday", "\$100 AM - 10:00 PM"),
              _buildDayRow("Saturday", "\$100 AM - 10:00 PM"),
              _buildDayRow("Sunday", "Closed"),
            ],
          ),
      ],
    );
  }

  Widget _buildDayRow(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: AppFontStyle.text_16_400(AppColors.mediumText, family: AppFontFamily.gilroyRegular),
          ),
          Text(
            hours,
            style: hours == "Closed"
                ? AppFontStyle.text_16_400(AppColors.lightText.withOpacity(0.5), family: AppFontFamily.gilroyRegular)
                : AppFontStyle.text_16_400(AppColors.black, family: AppFontFamily.gilroyRegular),
          ),
        ],
      ),
    );
  }
}