import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final RxInt value;
  final RxInt groupValue;
  final ValueChanged<int?> onChanged;

  const CustomRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
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
              duration: const Duration(milliseconds: 200),
              height: 20.h,
              width: 20.h,
              margin: EdgeInsets.symmetric(vertical: 8.0.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.w,
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1.w,
                  ),
                ),
              ),
            );
          }),
          wBox(10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              fontFamily: AppFontFamily.gilroyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
