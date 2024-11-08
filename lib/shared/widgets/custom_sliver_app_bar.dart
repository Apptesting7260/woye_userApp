import 'package:woye_user/Core/Utils/app_export.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        snap: true,
        floating: true,
        expandedHeight: 70.h,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(top: 10, bottom: 15),
          title: SizedBox(
            height: 35.h,
            child: CustomTextFormField(
              textStyle: AppFontStyle.text_10_400(AppColors.darkText),
              contentPadding: REdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(10.r),
              hintText: "Search",
              hintStyle: AppFontStyle.text_10_400(AppColors.hintText),
              prefix: Padding(
                padding: REdgeInsets.only(left: 15, right: 8),
                child: SvgPicture.asset(
                  "assets/svg/search.svg",
                  height: 14.h,
                ),
              ),
              prefixConstraints: BoxConstraints(
                minWidth: 30.w,
              ),
            ),
          ),
        ));
  }
}
