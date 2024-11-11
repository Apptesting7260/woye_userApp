import 'package:woye_user/Core/Utils/app_export.dart';

class ReviewDriverScreen extends StatelessWidget {
  const ReviewDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profile(),
            hBox(30),
            ratings(),
            hBox(30),
            review(),
            hBox(15),
            submitButton()
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.r,
          child: Image.asset("assets/images/profile-image.png"),
        ),
        hBox(15),
        Text(
          "David Ronney",
          textAlign: TextAlign.center,
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ],
    );
  }

  Widget ratings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your rate?",
          textAlign: TextAlign.center,
          style: AppFontStyle.text_16_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          children: [
            SvgPicture.asset(
              "assets/svg/star-white.svg",
              height: 28.h,
            ),
            wBox(5),
            SvgPicture.asset(
              "assets/svg/star-white.svg",
              height: 28.h,
            ),
            wBox(5),
            SvgPicture.asset(
              "assets/svg/star-white.svg",
              height: 28.h,
            ),
            wBox(5),
            SvgPicture.asset(
              "assets/svg/star-white.svg",
              height: 28.h,
            ),
            wBox(5),
            SvgPicture.asset(
              "assets/svg/star-white.svg",
              height: 28.h,
            ),
          ],
        ),
      ],
    );
  }

  Widget review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How was your experience ?",
          textAlign: TextAlign.center,
          style: AppFontStyle.text_16_600(AppColors.darkText),
        ),
        hBox(10),
        TextFormField(
          style: AppFontStyle.text_14_400(AppColors.darkText),
          // expands: true,
          maxLines: 10,
          minLines: 7,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.r),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(15.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(15.r)),
            hintText: "Write your review...",
            hintStyle: AppFontStyle.text_14_400(
              AppColors.lightText,
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton() {
    return CustomElevatedButton(
        text: "Submit",
        onPressed: () async {
          await Get.offAllNamed(AppRoutes.restaurantNavbar);
        });
  }
}
