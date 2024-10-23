import 'package:woye_user/Core/Utils/app_export.dart';

class SearchBarWithFilter extends StatelessWidget {
  final String hintText;
  final VoidCallback onFilterTap;

  const SearchBarWithFilter({
    Key? key,
    this.hintText = "Search",
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Opacity(
            opacity: .3,
            child: CustomTextFormField(
              prefix: SizedBox(
                height: 24.h,
                width: 24.h,
                child: SvgPicture.asset(
                  "assets/svg/search.svg",
                ),
              ),
              hintText: hintText,
              hintStyle: AppFontStyle.text_14_400(AppColors.hintText),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Opacity(
          opacity: .3,
          child: InkWell(
            onTap: onFilterTap,
            child: Container(
              width: 50.h,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                    width: 1.w,
                    color: AppColors
                        .textFieldBorder), // Replace AppColors.hintText with a color
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/filter.png",
                  height: 20.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
