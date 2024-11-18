import 'package:woye_user/Core/Utils/app_export.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final List<Widget> children;
  Function(bool value)? onExpansionChanged;
  CustomExpansionTile(
      {super.key,
      required this.title,
      required this.children,
      this.titleTextStyle,
      this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        initiallyExpanded: false,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        shape: Border.all(color: Colors.transparent),
        collapsedShape: Border.all(color: Colors.transparent),
        tilePadding: EdgeInsets.symmetric(horizontal: 15.r),
        childrenPadding: EdgeInsets.symmetric(horizontal: 15.r),
        title: Text(
          title,
          style: titleTextStyle ?? AppFontStyle.text_18_600(AppColors.darkText),
        ),
        onExpansionChanged: onExpansionChanged,
        children: children);
  }
}
