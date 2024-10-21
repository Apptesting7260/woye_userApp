import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 200,
        leading: Text(
          "Categories",
          style: AppFontStyle.text_28_600(AppColors.darkText),
        ),
      ),
    );
  }
}
