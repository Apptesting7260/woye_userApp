import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';

class MoreProducts extends StatelessWidget {
  const MoreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "More Products",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: productList()),
    );
  }

  GridView productList() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6.h,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 5.h,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Get.to(ProductDetailsScreen(product_id: '',
                  category_id: '',
                  category_name: '',));
              },
              child: CustomItemBanner(index: index));
        });
  }
}
