import 'package:woye_user/core/utils/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Text? title;
  final List<Widget>? actions;
  final bool isLeading;
  final double? leadingWidth;
  final bool? centetTitle;
  final bool isActions;
  final double? toolbarHeight;

  const CustomAppBar(
      {super.key,
      this.leading,
      this.title,
      this.actions,
      this.isLeading = true,
      this.leadingWidth,
      this.centetTitle,
      this.isActions = false,
      this.toolbarHeight});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: isLeading
            ? leading ??
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: REdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      width: 44.h,
                      height: 44.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Image.asset("assets/images/back.png", scale: 4),
                      ),
                    ),
                  ),
                )
            : null,
        titleSpacing: 0,
        centerTitle: isLeading,
        title: title,
        leadingWidth: leadingWidth ?? 44.w,
        toolbarHeight: toolbarHeight ?? 90.h,
        actions: actions ??
            (isActions
                ? [
                    Container(
                      padding: REdgeInsets.all(9),
                      height: 44.h,
                      width: 44.h,
                      decoration: BoxDecoration(
                          color: AppColors.greyBackground,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: SvgPicture.asset(
                        ImageConstants.notification,
                      ),
                    ),
                  ]
                : []),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
