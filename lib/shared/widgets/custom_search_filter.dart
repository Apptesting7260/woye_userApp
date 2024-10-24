import 'package:woye_user/Core/Utils/app_export.dart';

class CustomSearchFilter extends StatelessWidget {
  final String hintText;
  final VoidCallback onFilterTap;
  final EdgeInsets? padding;
  final EdgeInsets? searchIocnPadding;
  final double? searchIconHeight;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const CustomSearchFilter({
    super.key,
    this.hintText = "Search",
    required this.onFilterTap,
    this.padding,
    this.prefix,
    this.prefixConstraints,
    this.textStyle,
    this.hintStyle,
    this.searchIocnPadding,
    this.searchIconHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(width: 0.8, color: AppColors.textFieldBorder)),
            contentPadding: padding ?? REdgeInsets.symmetric(vertical: 8),
            textStyle:
                textStyle ?? AppFontStyle.text_14_400(AppColors.darkText),
            prefixConstraints: prefixConstraints ??
                BoxConstraints(maxHeight: 24.h, maxWidth: 40.w),
            prefix: prefix ??
                Padding(
                  padding: REdgeInsets.only(
                    left: 15,
                    right: 8,
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/search.svg",
                    height: 14,
                  ),
                ),
            hintText: hintText,
            hintStyle:
                hintStyle ?? AppFontStyle.text_12_400(AppColors.hintText),
          ),
        ),
        SizedBox(width: 8.w),
        InkWell(
          splashColor: Colors.transparent,
          onTap: onFilterTap,
          child: Container(
            padding: searchIocnPadding ??
                REdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                  width: 0.8.w,
                  color: AppColors
                      .textFieldBorder), // Replace AppColors.hintText with a color
            ),
            child: Center(
              child: Image.asset(
                "assets/images/filter.png",
                height: searchIconHeight ?? 20.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
