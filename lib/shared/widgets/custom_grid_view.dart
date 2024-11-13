import 'package:woye_user/Core/Utils/app_export.dart';

class CustomGridView extends StatelessWidget {
  final String? image;
  const CustomGridView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
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
                // Get.to(ProductDetailsScreen(
                //     image: "assets/images/cat-image${index % 5}.png",
                //     title: "McMushroom Pizza"));
              },
              child: CustomItemBanner(
                image: image,
              ));
        });
  }
}
