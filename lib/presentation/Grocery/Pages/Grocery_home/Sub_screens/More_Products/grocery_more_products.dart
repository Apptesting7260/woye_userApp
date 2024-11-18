import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class GroceryMoreProducts extends StatelessWidget {
  const GroceryMoreProducts({super.key});

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
    return CustomGridView(
      itemCount: 20,
      imageAddress: "assets/images/grocery-item.png",
      title: "Arla DANO Full Cream Milk Powder Instant",
      quantity: "50gm",
      onTap: () {
        Get.to(() => GroceryProductDetailsScreen(
            image: "assets/images/grocery-item.png",
            title: "Arla DANO Full Cream Milk Powder Instant"));
      },
    );
  }
}
