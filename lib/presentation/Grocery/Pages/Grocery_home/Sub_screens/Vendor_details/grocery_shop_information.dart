import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/GroceryDetailsController.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../../../../Shared/theme/font_family.dart';
import '../../../../../Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/controller/more_products_controller.dart';

class GroceryShopInformation extends StatefulWidget {
   GroceryShopInformation({super.key});

  @override
  State<GroceryShopInformation> createState() => _GroceryShopInformationState();
}

class _GroceryShopInformationState extends State<GroceryShopInformation> {
   final GroceryDetailsController controller =  Get.put(GroceryDetailsController());
   final SeeAllProductReviewController seeAllProductReviewController =   Get.put(SeeAllProductReviewController());

   String groceryId = "";

   @override
   void initState() {
     var arguments = Get.arguments ?? {};
     groceryId = arguments['groceryId'] ?? "";
     pt("groceryId >>>>>>>>>>>> $groceryId");
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameEmailAdd(),
              hBox(25.h),
              openHours(),
                hBox(18.h),
                description(),
            //   if (controller.pharma_Data.value.review?.isNotEmpty ?? false)
            // reviews(),
               hBox(15.h),
            ],
                  ),
          ),
        ),
    );
  }

   Widget nameEmailAdd(){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        /* Row(
           children: [
             Icon(Icons.person_outline_rounded,color: AppColors.black.withOpacity(0.8),size: 25,),
             wBox(8),
             Flexible(
               child: Text(
                 "${controller.pharma_Data.value.pharmaShop!.firstName ?? ""} ${controller.pharma_Data.value.pharmaShop!.lastName ?? ""}",
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
                 controller.pharma_Data.value.pharmaShop!.email.toString(),
                 overflow: TextOverflow.ellipsis,
                 style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
               ),
             )
           ],
         ),
         hBox(12.h),*/
         Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Icon(Icons.location_on_outlined,color: AppColors.black.withOpacity(0.8),size: 25,),
             wBox(8),
             Flexible(
               child: Text(
                 controller.pharma_Data.value.pharmaShop!.shopAddress
                     .toString(),
                 maxLines: 10,
                 overflow: TextOverflow.ellipsis,
                 style: AppFontStyle.text_17_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
               ),
             )
           ],
         ),
       ],);
   }

   Widget openHours() {
     var openingHours = controller.pharma_Data.value.pharmaShop?.openingHours;

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
       children: [
         Text(
           "Descriptions",
           style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
         ),
         hBox(10),
         Text(
           controller.pharma_Data.value.pharmaShop?.shopDes.toString() ?? "",
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
         children: [
           Column(
             children: [
               ListView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: (controller.pharma_Data.value.review?.isNotEmpty ?? false) ? 1 : 0,
                 itemBuilder: (context, index) {
                   return (controller.pharma_Data.value.review?.isNotEmpty ?? false)
                       ? Column(
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(50.r),
                             child: CachedNetworkImage(
                               imageUrl: controller.pharma_Data.value.review![index].user?.imageUrl.toString() ?? "",
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
                                     borderRadius: BorderRadius.circular(20),
                                   ),
                                   child: Padding(
                                     padding:  EdgeInsets.all(10.h),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Text(
                                           controller.pharma_Data.value.review?[index].user?.firstName.toString() ?? "Unknown User",
                                           style: AppFontStyle.text_16_400(
                                               AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                         ),
                                         hBox(5),
                                         RatingBar.readOnly(
                                           filledIcon: Icons.star,
                                           emptyIcon: Icons.star,
                                           filledColor: AppColors.goldStar,
                                           emptyColor: AppColors.normalStar,
                                           initialRating: double.parse(controller
                                               .pharma_Data.value.review?[index].rating?.toString()??""),
                                           maxRating: 5,
                                           size: 20.h,
                                         ),
                                         hBox(10),
                                         Text(
                                           controller.pharma_Data.value
                                               .review?[index].message
                                               .toString() ?? "",
                                           style: AppFontStyle.text_16_400(
                                               AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                           maxLines: 2,
                                         ),
                                         hBox(10),
                                         Text(
                                           controller.formatDate(controller
                                               .pharma_Data
                                               .value
                                               .review![index]
                                               .updatedAt
                                               .toString()),
                                           style: AppFontStyle.text_15_400(
                                               AppColors.lightText,family: AppFontFamily.gilroyMedium),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),

                                 if (controller.pharma_Data.value
                                     .review![index].reply !=
                                     null)
                                   Padding(
                                     padding:  EdgeInsets.only(top: 10.h),
                                     child: Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.end,
                                       children: [
                                         Icon(
                                           Icons.reply,
                                           color: AppColors.primary,
                                         ),
                                         Flexible(
                                           child: Text(
                                             controller.pharma_Data.value
                                                 .review![index].reply
                                                 .toString()
                                                 .trim(),
                                             style: AppFontStyle.text_16_400(
                                                 AppColors.lightText,family: AppFontFamily.gilroyMedium),
                                             maxLines: 100,
                                             overflow: TextOverflow.ellipsis,
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
           controller.pharma_Data.value.totalReviews!.toInt() > 0
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
                       'product_id': groceryId.toString(),
                       'product_review':controller.pharma_Data.value.averageRating,
                       'review_count': controller.pharma_Data.value.totalReviews.toString(),
                       "type": "grocery",
                     },
                   );
                   seeAllProductReviewController.seeAllProductReviewApi(vendorId: groceryId.toString(), type: "grocery");

                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       "See All (${controller.pharma_Data.value.totalReviews.toString()})",
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
}
