import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/modal/GoogleLocationModel.dart';

import '../../theme/font_family.dart';

class AddressFromGoogleAPI extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final Future<Predictions>? Function(Predictions)? onSelected;
  final Future<List<Predictions>> Function(String)? suggestionsCallback;
  final Widget Function(BuildContext, Predictions)? itemBuilder;

  const AddressFromGoogleAPI({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.onSelected,
    required this.suggestionsCallback,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Predictions>(
      suggestionsCallback: (query) async {
        final results = await suggestionsCallback!(query);
        return results.toList();
      },
      hideOnEmpty: controller.text == "" ? true : false,
      onSelected: (selected) async {
        onSelected!(selected);
      },
      loadingBuilder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circularProgressIndicator2(),
          ],
        );
      },
      controller: controller,
      builder: (context, controller, focusNode) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style:AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestRegular),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppFontStyle.text_14_400(AppColors.hintText),
                isDense: true,
                contentPadding:
                    REdgeInsets.symmetric(vertical: 15, horizontal: 20),
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textFieldBorder),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textFieldBorder),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textFieldBorder),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    child: const Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onTap: () {
                      controller.clear();
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemBuilder: itemBuilder!,
    );
  }
}
