import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_expansion_tile.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List headings = [
      "What is App",
      "How to use App",
      "App is Free?",
      "Why use App?",
      "How I can delete all data?"
    ];
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "FAQ",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [hBox(20), faqList(headings)],
        ),
      ),
    );
  }

  Widget faqList(List<dynamic> headings) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.greyBackground.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: CustomExpansionTile(title: headings[index], children: [
              const Divider(),
              hBox(10),
              Text(
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                overflow: TextOverflow.visible,
                style: AppFontStyle.text_14_400(AppColors.mediumText),
              ),
            ]));
      },
      separatorBuilder: (c, i) => hBox(10),
    );
  }
}
