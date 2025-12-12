import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/pharmacy_product_details_screen.dart';

class CustomGridView extends StatelessWidget {
  final int? itemCount;
  final String? price;
  final String? priceBefore;
  final String? description;
  final String? quantity;

  final String? image;

  final VoidCallback? onTap;

  const CustomGridView(
      {super.key,
      this.image,
      this.onTap,
      this.price,
      this.priceBefore,
      this.description,
      this.quantity,
      this.itemCount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Get.to(PharmacyProductDetailsScreen(
              categoryId: "",
              productId: "",
              categoryName: '',
            ));
          },
      child: CustomBanner(
        image: image ?? "assets/images/tablet.png",
        // price: price,
        // priceBefore: priceBefore,
        description: description,
        quantity: quantity,
      ),
    );
  }
}
