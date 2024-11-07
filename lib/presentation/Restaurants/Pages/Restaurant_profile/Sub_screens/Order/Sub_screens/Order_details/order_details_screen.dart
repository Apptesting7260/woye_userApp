import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_expansion_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Order Details",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              heading(),
              hBox(30),
              orderDetails(),
              hBox(20),
              orderId(),
              hBox(20),
              paymentDetails(),
              hBox(20),
              buttons(),
              hBox(50)
            ],
          )),
    );
  }

  Widget heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hey, John!",
          style: AppFontStyle.text_28_600(AppColors.darkText),
        ),
        hBox(20),
        Wrap(
          children: [
            Text(
              "Thank you for your order! We'll keep you updated on its arrival.",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightText),
            ),
          ],
        ),
      ],
    );
  }

  Widget orderDetails() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(
        title: "Order Details",
        children: [
          const Divider(),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "#1947034",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order placed",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Mon, 04 Apr - 12:00 AM",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "\$10.00",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total ",
                style: AppFontStyle.text_14_600(AppColors.darkText),
              ),
              Text(
                "\$120.00",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ],
          ),
          hBox(10),
          Divider(),
          hBox(10),
          Text(
            "Delivery Address",
            style: AppFontStyle.text_18_600(AppColors.darkText),
          ),
          hBox(10),
          Text(
            "Home",
            style: AppFontStyle.text_14_400(AppColors.primary),
          ),
          hBox(10),
          Text(
            "Jone Deo ",
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
          hBox(10),
          Text(
            "D 888 Abc Road, Greenfield, Abc Manchester, 199",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(10),
          Text(
            "+791 12 123 1234 ",
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
          hBox(15),
        ],
      ),
    );
  }

  Widget orderId() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.textFieldBorder)),
        child: CustomExpansionTile(
          title: "Order Id #1947034",
          children: [
            Divider(),
            hBox(20),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/cat-image0.png",
                      height: 100,
                    )),
                wBox(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "McMushroom Pizza",
                      style: AppFontStyle.text_14_600(AppColors.darkText),
                    ),
                    hBox(10),
                    Row(
                      children: [
                        Text(
                          "Qty:",
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                        Text(
                          "1",
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                      ],
                    ),
                    hBox(10),
                    Text(
                      "\$120.00",
                      style: AppFontStyle.text_14_600(AppColors.primary),
                    ),
                  ],
                )
              ],
            ),
            hBox(15),
            Divider(),
            hBox(15),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/cat-image0.png",
                      height: 100,
                    )),
                wBox(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "McMushroom Pizza",
                      style: AppFontStyle.text_14_600(AppColors.darkText),
                    ),
                    hBox(10),
                    Row(
                      children: [
                        Text(
                          "Qty:",
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                        Text(
                          "1",
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                      ],
                    ),
                    hBox(10),
                    Text(
                      "\$120.00",
                      style: AppFontStyle.text_14_600(AppColors.primary),
                    ),
                  ],
                )
              ],
            ),
            hBox(15),
            Divider(),
            hBox(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: AppFontStyle.text_12_400(AppColors.lightText),
                ),
                Text(
                  "\$132.00",
                  style: AppFontStyle.text_12_600(AppColors.darkText),
                ),
              ],
            ),
            hBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: AppFontStyle.text_12_400(AppColors.lightText),
                ),
                Text(
                  "\$10.00",
                  style: AppFontStyle.text_12_600(AppColors.darkText),
                ),
              ],
            ),
            hBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Charge",
                  style: AppFontStyle.text_12_400(AppColors.lightText),
                ),
                Text(
                  "\$2.00",
                  style: AppFontStyle.text_12_600(AppColors.darkText),
                ),
              ],
            ),
            hBox(15),
            Divider(),
            hBox(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total ",
                  style: AppFontStyle.text_14_600(AppColors.darkText),
                ),
                Text(
                  "\$120.00",
                  style: AppFontStyle.text_14_600(AppColors.primary),
                ),
              ],
            ),
            hBox(15),
          ],
        ));
  }

  Widget paymentDetails() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(title: "Payments Details", children: [
        Divider(),
        hBox(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment method",
              style: AppFontStyle.text_12_400(AppColors.lightText),
            ),
            Text(
              "Credit card",
              style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Date",
              style: AppFontStyle.text_12_400(AppColors.lightText),
            ),
            Text(
              "25 July, 2024",
              style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: AppFontStyle.text_12_400(AppColors.lightText),
            ),
            Text(
              "\$132.00",
              style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(15)
      ]),
    );
  }

  Widget buttons() {
    return Column(children: [
      CustomOutlinedButton(
          onPressed: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/invoice.svg",
                height: 22,
              ),
              wBox(10),
              Text(
                "Download Invoice",
                style: AppFontStyle.text_14_400(AppColors.darkText),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.black,
                size: 18.h,
              )
            ],
          )),
      hBox(15),
      CustomOutlinedButton(
          onPressed: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/delete-outlined.svg",
                height: 22,
              ),
              wBox(10),
              Text(
                "Cancel Order",
                style: AppFontStyle.text_14_400(AppColors.darkText),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.black,
                size: 18.h,
              )
            ],
          )),
      hBox(15),
      CustomElevatedButton(
        onPressed: () {},
        text: "Continue Shopping",
      )
    ]);
  }
}
