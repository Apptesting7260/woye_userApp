import 'package:intl/intl.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Notifications/notification_controller.dart';

import '../../../../../Data/components/GeneralException.dart';
import '../../../../../Data/components/InternetException.dart';
import '../../../../../Shared/Widgets/CircularProgressIndicator.dart';
import '../../../../../Shared/theme/font_family.dart';
import '../../../../../shared/widgets/custom_no_data_found.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationController controller = NotificationController();

  @override
  void initState() {
    controller.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Notifications",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.refreshNotifications();
        },
        child: Obx(
          () {
            switch (controller.rxRequestStatus.value) {
              case Status.LOADING:
                return Center(child: circularProgressIndicator());
              case Status.ERROR:
                if (controller.error.value == 'No internet' || controller.error.value == 'InternetExceptionWidget') {
                  return InternetExceptionWidget(
                    onPress: () {
                      controller.getNotifications();
                    },
                  );
                } else {
                  return GeneralExceptionWidget(
                    onPress: () {
                      controller.getNotifications();
                    },
                  );
                }
              case Status.COMPLETED:
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: controller.apiData.value.notificationCount == 0
                  || (controller.apiData.value.notification?.isEmpty ?? true)
                  ? const CustomNoDataFound() :
                  Column(
                    children: [
                      hBox(20.h),
                      notificationsList(),
                      hBox(100.h),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Widget notificationsList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal:20),
      shrinkWrap: true,
      itemCount: controller.apiData.value.notificationCount ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if( controller.apiData.value.notification?[index].title == "Order Placed Successfully"){
              Get.toNamed(AppRoutes.orders,arguments: {
                "screenType" : "notificationScreen"
              });
            } else if( controller.apiData.value.notification?[index].title == "Order Delivered"){
              Get.toNamed(AppRoutes.orders,arguments: {
                "pageIndex" : 2,
                "screenType" : "notificationScreen"
              });
            }else if( controller.apiData.value.notification?[index].title == "Order Accepted"
                ||  controller.apiData.value.notification?[index].title == "Order Accepted Notification"){
              Get.toNamed(AppRoutes.orders,arguments: {
                "pageIndex" : 1,
                "screenType" : "notificationScreen"
              });
            }else if( controller.apiData.value.notification?[index].title == "Order Rejected" ||
                controller.apiData.value.notification?[index].title == "Order Cancelled"
                ||  controller.apiData.value.notification?[index].title == "Order Rejected Notification"){
              Get.toNamed(AppRoutes.orders,arguments: {
                "pageIndex" : 3,
                "screenType" : "notificationScreen"
              });
            }
          },
          child: Container(
            padding: REdgeInsets.symmetric(vertical:controller.apiData.value.notification?[index].seen != "0"? 0 : 10),
            decoration: BoxDecoration(color:  controller.apiData.value.notification?[index].seen == "0" ?
            AppColors.ultraLightPrimary.withOpacity(0.03) : AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                wBox(15.h),
                Container(
                  padding: REdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: AppColors.ultraLightPrimary,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: SvgPicture.asset(
                    "assets/svg/notification-green.svg",
                    theme: SvgTheme(currentColor: AppColors.primary),
                  ),
                ),
                wBox(15.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.apiData.value.notification?[index].title.toString() ?? "",
                        style: AppFontStyle.text_15_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                      ),
                      hBox(5.h),
                      Text(
                        controller.apiData.value.notification?[index].message.toString() ?? "",
                        style: AppFontStyle.text_14_500(AppColors.lightText,family: AppFontFamily.onestRegular),
                        maxLines: 2,
                      ),
                      hBox(5.h),
                      Text(
                        formatDate(controller.apiData.value.notification?[index].createdAt.toString() ?? ""),
                        style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => hBox(15.h),
    );
  }

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('d MMM yyyy').format(dateTime);
  }
}
