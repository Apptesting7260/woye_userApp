import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/pharmacy_product_details_screen.dart';

class CustomGridView extends StatelessWidget {
  final int? itemCount;
  final String? price;
  final String? priceBefore;
  final String? title;
  final String? quantity;
  final ScrollPhysics? physics;

  final String? imageAddress;

  final VoidCallback? onTap;
  const CustomGridView(
      {super.key,
      this.imageAddress,
      this.onTap,
      this.price,
      this.priceBefore,
      this.title,
      this.quantity,
      this.itemCount,
      this.physics});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: physics ?? const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount ?? 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65.h,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 5.h,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: onTap ??
                () {
                  Get.to(const PharmacyProductDetailsScreen(
                      image: "assets/images/tablet.png",
                      title: "Azithral Stat 100mg / Azee 100mg Tablet DT"));
                },
            child: CustomBanner(
              imageAddress: imageAddress ?? "assets/images/tablet.png",
              price: price,
              priceBefore: priceBefore,
              title: title,
              quantity: quantity,
            ),
          );
        });
  }
}
