import 'package:woye_user/Core/Utils/app_export.dart';

class MoreProducts extends StatelessWidget {
  const MoreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "More Products",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      body: GridView.builder(
          padding: REdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true,
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7.h,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 4.h),
          itemBuilder: (context, index) {
            return CustomItemBanner(index: index);
          }),
    );
  }
}
