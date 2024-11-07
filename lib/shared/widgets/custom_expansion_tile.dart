import 'package:woye_user/Core/Utils/app_export.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final  List<Widget> children;
  const CustomExpansionTile({super.key, required this.title, required this.children,});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: Border.all(color: Colors.transparent),
      collapsedShape: Border.all(color: Colors.transparent),
      tilePadding: EdgeInsets.symmetric(horizontal: 15.r),
      childrenPadding: EdgeInsets.symmetric(horizontal: 15.r),
      title: Text(
        title,
        style: AppFontStyle.text_18_600(AppColors.darkText),
      ),
      children:children,
    );
  }
}
