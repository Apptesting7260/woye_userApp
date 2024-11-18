import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woye_user/Core/Utils/app_export.dart';

class PharmacyRateVendorScreen extends StatelessWidget {
  const PharmacyRateVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hBox(40),
            giveRating(),
            hBox(30),
            giveReview(),
            hBox(20),
            submitButton(),
            hBox(50),
          ],
        ),
      ),
    );
  }

  Widget giveRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your rate?",
          style: AppFontStyle.text_18_600(AppColors.darkText),
        ),
        hBox(20),
        RatingBar(
            itemPadding: REdgeInsets.only(right: 10),
            itemSize: 36.h,
            initialRating: 0,
            allowHalfRating: true,
            ratingWidget: RatingWidget(
                full: SvgPicture.asset("assets/svg/star-yellow.svg"),
                half: SvgPicture.asset("assets/svg/star-white.svg"),
                empty: SvgPicture.asset("assets/svg/star-white.svg")),
            onRatingUpdate: (v) {}),
      ],
    );
  }

  Widget giveReview() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "What is your rate?",
        style: AppFontStyle.text_18_600(AppColors.darkText),
      ),
      hBox(20),
      const CustomTextFormField(
        maxLines: 7,
        minLines: 7,
        hintText: "Write your review...",
      )
    ]);
  }

  Widget submitButton() {
    return CustomElevatedButton(
      onPressed: () {},
      text: "Submit",
    );
  }
}
