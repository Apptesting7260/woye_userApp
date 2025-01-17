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
            child: productList()));
  }

  GridView productList() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65.h,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 5.h,
        ),
        itemBuilder: (context, index) {
          return CustomBanner(
              // image: moreProducts[index].urlImage.toString(),
              // sale_price: moreProducts[index].salePrice.toString(),
              // regular_price: moreProducts[index].regularPrice.toString(),
              // title: moreProducts[index].title.toString(),
              // quantity: moreProducts[index].packagingValue.toString(),
              // categoryId: moreProducts[index].categoryId.toString(),
              // product_id: moreProducts[index].id.toString(),
              // shop_name: moreProducts[index].shopName.toString(),
              // is_in_wishlist: moreProducts[index].isInWishlist,
              // isLoading: moreProducts[index].isLoading,
              // categoryName: moreProducts[index].categoryName.toString(),
              );
        });
  }
}
