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
  final Widget? filterIcon;
  final Color? filterColor;
  final bool? showfilterIcon;

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
    this.filterIcon,
    this.filterColor,
    this.showfilterIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    Paint paint = Paint();
    paint.color = AppColors.black;
    paint.invertColors = true;
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(width: 0.8, color: AppColors.textFieldBorder)),
            contentPadding: padding ?? REdgeInsets.symmetric(vertical: 6),
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
                hintStyle ?? AppFontStyle.text_10_400(AppColors.hintText),
          ),
        ),
        SizedBox(width: showfilterIcon == true ? 8.w : 0),
        showfilterIcon == true
            ? InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: onFilterTap,
                child: Container(
                  padding: searchIocnPadding ??
                      REdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: filterColor,

                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        width: 0.8.w,
                        color: AppColors
                            .textFieldBorder), // Replace AppColors.hintText with a color
                  ),
                  child: Center(
                    child: filterIcon ??
                        Image.asset(
                          "assets/images/filter.png",
                          height: searchIconHeight ?? 20.h,
                        ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
