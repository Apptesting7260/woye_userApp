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
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading ??
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: REdgeInsets.only(left: 24, top: 20),
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
      leadingWidth: leadingWidth ?? 70.w,
      toolbarHeight: 110.h,
      actions: actions,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(110.h);
}
