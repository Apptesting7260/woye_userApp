import 'package:woye_user/Core/Utils/app_export.dart';

class CustomTitleRadioButton extends StatelessWidget {
  final String title;
  final String priceValue;
  final RxInt value;
  final RxInt groupValue;
  final ValueChanged<int?> onChanged;

  const CustomTitleRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.priceValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onChanged(value.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppFontStyle.text_16_400(AppColors.darkText),
          ),
          Row(
            children: [
              Text(
                priceValue,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  fontFamily: 'Gilroy-Regular',
                ),
              ),
              wBox(10),
              Obx(() {
                bool isSelected = value.value == groupValue.value;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: 20.h,
                  width: 20.h,
                  margin: EdgeInsets.symmetric(vertical: 8.0.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 1.w,
                        color:
                            isSelected ? AppColors.primary : AppColors.black),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 1.w,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
