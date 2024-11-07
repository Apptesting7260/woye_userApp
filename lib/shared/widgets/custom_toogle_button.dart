import 'package:woye_user/Core/Utils/app_export.dart';

class CustomToogleButton extends StatelessWidget {
  final String title;
  final RxInt value;
  final RxInt groupValue;
  final String icon;
  final String selectedIcon;
  final ValueChanged<int?> onChanged;

  const CustomToogleButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.icon,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onChanged(value.value),
      child: Row(
        children: [
          Obx(() {
            bool isSelected = value.value == groupValue.value;

            return AnimatedContainer(
                width: 102.w,
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 15),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.lightPrimary,
                    width: 1.w,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(isSelected ? selectedIcon : icon),
                    wBox(5),
                    Text(
                      title,
                      style: AppFontStyle.text_14_500(
                          isSelected ? AppColors.primary : AppColors.darkText),
                    )
                  ],
                ));
          }),
        ],
      ),
    );
  }
}
