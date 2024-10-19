import 'package:woye_user/core/app_export.dart';

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
      iconTheme: IconThemeData(),
      automaticallyImplyLeading: false,
      leading: leading,
      leadingWidth: leadingWidth ?? 70.w,
      toolbarHeight: 90.h,
      actions: actions,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
