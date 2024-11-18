import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class PharmacyMoreProducts extends StatelessWidget {
  const PharmacyMoreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Products",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Column(
            children: [hBox(20), productList(), hBox(50)],
          )),
    );
  }

  Widget productList() {
    return const CustomGridView();
  }
}
