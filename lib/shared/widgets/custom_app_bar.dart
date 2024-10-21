import 'package:woye_user/core/utils/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final bool? backEnabled;
  final double? leadingWidth;

  const CustomAppBar(
      {super.key,
      this.leading,
      this.title,
      this.actions,
      this.backEnabled,
      this.leadingWidth});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: leading ??
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: REdgeInsets.only(top: 20, bottom: 20),
                child: CircleAvatar(
                  radius: 44.w,
                  backgroundColor: AppColors.greyBackground,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ),
        leadingWidth: leadingWidth ?? 50.w,
        toolbarHeight: 90.h,
        actions: actions,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
