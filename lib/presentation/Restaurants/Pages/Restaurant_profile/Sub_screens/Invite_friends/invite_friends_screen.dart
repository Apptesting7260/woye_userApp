import 'package:woye_user/Core/Utils/app_export.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        // title: Text(
        //   "Invite Friends",
        //   style: AppFontStyle.text_22_600(AppColors.darkText),
        // ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            hBox(20),
            //
            header(),
            hBox(30),
            //
            emailAddress(),
            hBox(20),
            //
            sendButton()
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Invite Friends",
        style: AppFontStyle.text_24_600(AppColors.darkText),
      ),
      hBox(15),
      Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightText)),
    ]);
  }

  Widget emailAddress() {
    return CustomTextFormField(
      hintText: "Email Address",
      prefix: Padding(
        padding: REdgeInsets.only(left: 20, right: 14),
        child: SvgPicture.asset("assets/svg/email.svg"),
      ),
    );
  }

  Widget sendButton() {
    return CustomElevatedButton(
      onPressed: () {},
      text: "Send Invite",
    );
  }
}
