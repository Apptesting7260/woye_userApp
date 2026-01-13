import 'package:woye_user/core/utils/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool isLeading;
  final double? leadingWidth;
  final bool? centetTitle;
  final bool isActions;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final void Function()? leadingOnTap;
  final double? width;
  final double? height;

  const CustomAppBar(
      {super.key,
      this.leading,
      this.title,
      this.actions,
      this.isLeading = true,
      this.leadingWidth,
      this.centetTitle,
      this.isActions = false,
      this.toolbarHeight,
      this.bottom,
      this.leadingOnTap,
      this.width,
      this.height,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: isLeading
            ? leading ??
                GestureDetector(
                  onTap: leadingOnTap ?? () {
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
                        child: SvgPicture.asset(
                            "assets/svg/back.svg",
                          width:width,
                          height:height,
                        ),
                      ),
                    ),
                  ),
                )
            : null,
        titleSpacing: 0,
        bottom: bottom,
        centerTitle: isLeading,
        title: title,
        leadingWidth: leadingWidth ?? 44.w,
        toolbarHeight: toolbarHeight ?? 90.h,
        actions: actions ??
            (isActions
                ? [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.notifications);
                      },
                      child: Container(
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
