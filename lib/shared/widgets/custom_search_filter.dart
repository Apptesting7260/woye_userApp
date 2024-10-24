import 'package:woye_user/Core/Utils/app_export.dart';

class SearchBarWithFilter extends StatelessWidget {
  final String hintText;
  final VoidCallback onFilterTap;

  const SearchBarWithFilter({
    super.key,
    this.hintText = "Search",
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            // height: 40,
            borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(width: 0.8, color: AppColors.textFieldBorder)),
            contentPadding: REdgeInsets.only(top: 10, bottom: 10),
            textStyle: AppFontStyle.text_10_400(AppColors.darkText),
            prefixConstraints: BoxConstraints(
              maxHeight: 18.h,
            ),
            prefix: Padding(
              padding: REdgeInsets.only(
                left: 15,
                right: 5,
                // bottom: 4,
              ),
              child: SvgPicture.asset(
                "assets/svg/search.svg",
                height: 12,
              ),
            ),
            hintText: hintText,
            hintStyle: AppFontStyle.text_10_400(AppColors.hintText),
          ),
        ),
        SizedBox(width: 8.w),
        InkWell(
          splashColor: Colors.transparent,
          onTap: onFilterTap,
          child: Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  width: 0.8.w,
                  color: AppColors
                      .textFieldBorder), // Replace AppColors.hintText with a color
            ),
            child: Center(
              child: Image.asset(
                "assets/images/filter.png",
                height: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
