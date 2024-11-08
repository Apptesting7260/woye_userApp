import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_profile/Sub_screens/Payment_method/Add_card/add_card_controller.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  static final AddCardController addCardController =
      Get.put(AddCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Add Card",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: addCardController.addCardFormKey,
          child: Column(
            children: [
              cardHolderName(),
              hBox(15),
              cardNumber(),
              hBox(15),
              Row(
                children: [
                  Expanded(child: monthYear()),
                  wBox(15),
                  Expanded(child: cvv())
                ],
              ),
              hBox(20),
              saveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget cardHolderName() {
    return const CustomTextFormField(
      hintText: "Card Holder Name",
    );
  }

  Widget cardNumber() {
    return const CustomTextFormField(
      hintText: "Card Number",
    );
  }

  Widget monthYear() {
    return const CustomTextFormField(
      hintText: "MM/YY",
    );
  }

  Widget cvv() {
    return const CustomTextFormField(
      hintText: "CVV",
    );
  }

  Widget saveButton() {
    return CustomElevatedButton(
        text: "Save",
        onPressed: () {
          Get.back();
        });
  }
}
