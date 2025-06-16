import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/faq/controller/faq_controller.dart';
import 'package:woye_user/shared/widgets/custom_expansion_tile.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  final FaqController controller = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "FAQ",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child:circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet' ||controller.error.value == 'InternetExceptionWidget') {
              return InternetExceptionWidget(
                onPress: () {
                  controller.getFaq();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.getFaq();
                },
              );
            }
          case Status.COMPLETED:
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [hBox(20), faqList()],
              ),
            );
          }
        },
      ),
    );
  }

  Widget faqList() {
    return RefreshIndicator(
      onRefresh: () {
        return controller.getFaq();
      },
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Obx(
            () =>Container(
                    padding: REdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.greyBackground.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: CustomExpansionTile(
                        title: controller.apiData.value.data?.content?[index].que
                                .toString() ??
                            "",
                        children: [
                          const Divider(),
                          hBox(10),
                          Text(
                            controller.apiData.value.data?.content?[index].ans
                                    .toString() ??
                                "",
                            maxLines: 100,
                            style: AppFontStyle.text_15_400(AppColors.mediumText,
                                family: AppFontFamily.gilroyRegular),
                          ),
                        ])),
          );
        },
        separatorBuilder: (c, i) => hBox(10),
      ),
    );
  }
}
