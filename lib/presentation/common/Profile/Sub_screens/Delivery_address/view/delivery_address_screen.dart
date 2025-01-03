import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Edit_address/edit_address_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/controller/delivery_address_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/delete_address/delete_address_controller.dart';

class DeliveryAddressScreen extends StatelessWidget {
  DeliveryAddressScreen({super.key});

  final DeliveryAddressController controller =
      Get.put(DeliveryAddressController());

  final DeleteAddressController deleteAddressController =
      Get.put(DeleteAddressController());

  final EditAdressController editController = Get.put(EditAdressController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    String? type = arguments['type'];
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Delivery Address",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet') {
              return InternetExceptionWidget(
                onPress: () {
                  controller.refreshDeliveryAddressApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.refreshDeliveryAddressApi();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshDeliveryAddressApi();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: REdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  children: [
                    if (controller.deliveryAddressData.value.data!.isNotEmpty)
                      addressList(),
                    hBox(30.h),
                    addAddress(),
                    if (type != "Profile") changeAddressButton(),
                    hBox(30.h),
                  ],
                ),
              ),
            );
        }
      }),
    );
  }

  Widget addressList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.deliveryAddressData.value.data!.length,
      itemBuilder: (context, index) {
        return Obx(
          () => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              controller.selectedAddressIndex.value = index;
              print("object${controller.selectedAddressIndex.value}");
            },
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                      color: (controller.selectedAddressIndex.value == index)
                          ? AppColors.primary
                          : AppColors.lightPrimary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 5.r),
                      height: 20.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary)),
                      child: (controller.selectedAddressIndex.value == index)
                          ? SvgPicture.asset(
                              "assets/svg/green-check-circle.svg")
                          : null,
                    ),
                  ),
                  wBox(6),
                  Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              controller.deliveryAddressData.value.data![index]
                                  .addressType
                                  .toString(),
                              style:
                                  AppFontStyle.text_20_600(AppColors.darkText),
                            ),
                            wBox(10.h),
                            if (controller.deliveryAddressData.value
                                    .data![index].isDefault ==
                                1)
                              Text(
                                "default",
                                style: AppFontStyle.text_14_400(
                                    AppColors.lightText),
                              ),
                            const Spacer(),
                            if (controller.deliveryAddressData.value
                                    .data![index].isDefault !=
                                1)
                              GestureDetector(
                                onTap: () {
                                  showDeleteAddressDialog(
                                      addressId: controller.deliveryAddressData
                                          .value.data![index].id
                                          .toString());
                                },
                                child: SvgPicture.asset(
                                  "assets/svg/delete-outlined.svg",
                                  height: 20,
                                ),
                              ),
                            wBox(5.h),
                            InkWell(
                                onTap: () {
                                  editController.setAddressData(index);
                                  Get.toNamed(AppRoutes.editAddressScreen);
                                },
                                child: SvgPicture.asset("assets/svg/edit.svg")),
                          ],
                        ),
                        hBox(10.h),
                        Text(
                          controller
                              .deliveryAddressData.value.data![index].fullName
                              .toString(),
                          style: AppFontStyle.text_14_400(AppColors.darkText),
                        ),
                        hBox(10.h),
                        Text(
                          "${controller.deliveryAddressData.value.data![index].houseDetails.toString()}\n${controller.deliveryAddressData.value.data![index].address.toString()}",
                          style: AppFontStyle.text_14_400(AppColors.lightText),
                          maxLines: 4,
                        ),
                        hBox(10.h),
                        Text(
                          "${controller.deliveryAddressData.value.data![index].countryCode.toString()} ${controller.deliveryAddressData.value.data![index].phoneNumber.toString()}",
                          style: AppFontStyle.text_14_400(AppColors.darkText),
                        ),
                        if (controller.deliveryAddressData.value.data![index]
                                .deliveryInstruction !=
                            null)
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "Delivery Instruction: ${controller.deliveryAddressData.value.data![index].deliveryInstruction.toString()}",
                              maxLines: 2,
                              style:
                                  AppFontStyle.text_14_400(AppColors.darkText),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (c, i) => hBox(15),
    );
  }

  Widget addAddress() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.primary)),
      child: ListTile(
        onTap: () {
          Get.toNamed(AppRoutes.addAddressScreen, arguments: {'cartKey': ""});
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.r),
        horizontalTitleGap: 10.w,
        leading: SvgPicture.asset(
          "assets/svg/pin_location.svg",
          height: 22.h,
        ),
        title: Text(
          "Add Address",
          style: AppFontStyle.text_16_400(AppColors.primary),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          size: 20.h,
        ),
      ),
    );
    // Container(
    //   padding: REdgeInsetsDirectional.all(15),
    //   height: 60.h,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20.r),
    //       border: Border.all(color: AppColors.primary)),
    //   child: Row(
    //     children: [
    //       SvgPicture.asset("assets/svg/pin_location.svg"),
    //       wBox(10),
    //       Text(
    //         "Add Address",
    //         style: AppFontStyle.text_16_400(AppColors.primary),
    //       ),
    //       Spacer(),
    //       Icon(
    //         Icons.arrow_forward_ios_sharp,
    //         size: 20.h,
    //       )
    //     ],
    //   ),
    // );
  }

  Widget changeAddressButton() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: CustomElevatedButton(
          onPressed: () {
            editController.changeAddressApi(
              addressId: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].id.toString(),
              name: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].fullName.toString(),
              houseNo: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].houseDetails.toString(),
              addressTypeName: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].addressType.toString(),
              selectedCountryCode: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].countryCode.toString(),
              mobNo: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].phoneNumber.toString(),
              location: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].address.toString(),
              latitude: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].latitude.toString(),
              longitude: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].longitude.toString(),
              deliveryInstruction: controller.deliveryAddressData.value.data![controller.selectedAddressIndex.value].deliveryInstruction ?? "",

            );
          },
          isLoading: editController.rxRequestStatus.value == Status.LOADING,
          text: "Change Address",
        ),
      ),
    );
  }

  Future showDeleteAddressDialog({
    required String addressId,
  }) {
    return Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog.adaptive(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Address',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Are you sure you want to delete this address?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      height: 40.h,
                      color: AppColors.black,
                      onPressed: () {
                        Get.back();
                      },
                      text: "Cancel",
                      textStyle: AppFontStyle.text_14_400(AppColors.darkText),
                    ),
                  ),
                  wBox(15),
                  Obx(
                    () => Expanded(
                      child: CustomElevatedButton(
                        height: 40.h,
                        isLoading:
                            deleteAddressController.rxRequestStatus.value ==
                                (Status.LOADING),
                        onPressed: () {
                          deleteAddressController.deleteAddressApi(
                              addressId: addressId);
                        },
                        text: "Yes",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
