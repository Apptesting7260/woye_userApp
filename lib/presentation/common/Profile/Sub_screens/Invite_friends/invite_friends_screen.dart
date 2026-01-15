import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Invite_friends/invite_friends_controller.dart';

import '../../../../../Shared/theme/font_family.dart';

class InviteFriendsScreen extends StatelessWidget {
  InviteFriendsScreen({super.key});

  final InviteFriendsController controller = Get.put(InviteFriendsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: true,
        // title: Text(
        //   "Invite Friends",
        //   style: AppFontStyle.text_22_600(AppColors.darkText),
        // ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: controller.formKey,
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
      ),
    );
  }

  Widget header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Invite Friends",
        style: AppFontStyle.text_24_600(AppColors.darkText,family: AppFontFamily.onestRegular),
      ),
      hBox(15),
      Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          style: TextStyle(
              fontSize: 15.sp,
              fontFamily: AppFontFamily.onestRegular,
              fontWeight: FontWeight.w400,
              color: AppColors.lightText)),
    ]);
  }

  Widget emailAddress() {
    return Obx(
      ()=> CustomTextFormField(
        controller: controller.emailTextFieldController.value,
        hintText: "Email Address",
        onChanged: (val){
          controller.isRed.value = true;
        },
        hintStyle: AppFontStyle.text_15_400(AppColors.lightText,family: AppFontFamily.onestRegular),
       textStyle: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestRegular),
        prefix: Padding(
          padding: REdgeInsets.only(left: 20, right: 14),
          child: SvgPicture.asset("assets/svg/email.svg"),
        ),
        validator: (value) {
          if(controller.isRed.value){
            if(value == null || value == ""||value.isEmpty || !isValidEmail(value)){
              return "please enter email address";
            }
          }
          return null;
        },
      ),
    );
  }

  Widget sendButton() {
    return Obx(
      ()=> CustomElevatedButton(
        isLoading: controller.rxRequestStatus.value == Status.LOADING,
      fontFamily: AppFontFamily.onestMedium,
        onPressed: () {
          final email = controller.emailTextFieldController.value.text;

          if (email.isNotEmpty && isValidEmail(email)) {
            if (controller.formKey.currentState?.validate() ?? false) {
              controller.inviteFriends();
            }
          } else {
            controller.isRed.value = true;
            controller.formKey.currentState?.validate();
          }
        },
        text: "Send Invite",
      ),
    );
  }
}
