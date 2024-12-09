import 'package:woye_user/Core/Utils/app_export.dart';

class AppFontStyle {
  static TextStyle _textStyle(Color color, double size, FontWeight fontWeight,
      {height}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        height: height ?? 1.4.h,
        overflow: TextOverflow.ellipsis,
        fontFamily: 'Gilroy');
  }

  ///`font-weight:300 ===========>`
  static text_16_300(Color color, {height}) {
    return _textStyle(color, 16.sp, FontWeight.w300, height: height);
  }

  static text_14_300(Color color, {height}) {
    return _textStyle(color, 14.sp, FontWeight.w300, height: height);
  }

  static text_18_300(Color color, {height}) {
    return _textStyle(color, 18.sp, FontWeight.w300, height: height);
  }

  ///`font-weight:400 ===========>`

  static text_10_400(Color color, {height}) {
    return _textStyle(color, 10.sp, FontWeight.w400, height: height);
  }

  static text_12_400(Color color, {height}) {
    return _textStyle(color, 12.sp, FontWeight.w400, height: height);
  }

  static text_13_400(Color color, {height}) {
    return _textStyle(color, 13.sp, FontWeight.w400, height: height);
  }

  static text_14_400(Color color, {height}) {
    return _textStyle(color, 14.sp, FontWeight.w400, height: height);
  }

  static text_15_400(Color color, {height}) {
    return _textStyle(color, 15.sp, FontWeight.w400, height: height);
  }

  // static text_16_400(Color color, {height, FontWeight}) {
  //   return _textStyle(color, 16.sp, FontWeight ?? FontWeight.w400,
  //       height: height);
  // }
  static text_16_400(Color color, {double? height, FontWeight? fontWeight}) {
    return _textStyle(color, 16.sp, fontWeight ?? FontWeight.w400, height: height);
  }


  static text_18_400(Color color, {height}) {
    return _textStyle(color, 18.sp, FontWeight.w400, height: height);
  }

  static text_20_400(Color color, {height}) {
    return _textStyle(color, 20.sp, FontWeight.w400, height: height);
  }

  static text_22_400(Color color, {height}) {
    return _textStyle(color, 22.sp, FontWeight.w400, height: height);
  }

  static text_24_400(Color color, {height}) {
    return _textStyle(color, 24.sp, FontWeight.w400, height: height);
  }

  static text_26_400(Color color, {height}) {
    return _textStyle(color, 26.sp, FontWeight.w400, height: height);
  }

  static text_34_400(Color color, {height}) {
    return _textStyle(color, 34.sp, FontWeight.w400, height: height);
  }

  ///`font-weight:500 ===========>`

  static text_14_500(Color color, {height}) {
    return _textStyle(color, 14.sp, FontWeight.w500, height: height);
  }

  static text_16_500(Color color, {height}) {
    return _textStyle(color, 16.sp, FontWeight.w500, height: height);
  }

  ///`font-weight:600 ===========>`

  static text_12_600(Color color, {height}) {
    return _textStyle(color, 12.sp, FontWeight.w600, height: height);
  }

  static text_14_600(Color color, {height}) {
    return _textStyle(color, 14.sp, FontWeight.w600, height: height);
  }

  static text_15_600(Color color, {height}) {
    return _textStyle(color, 15.sp, FontWeight.w600, height: height);
  }

  static text_16_600(Color color, {height}) {
    return _textStyle(color, 16.sp, FontWeight.w600, height: height);
  }

  static text_18_600(Color color, {height}) {
    return _textStyle(color, 18.sp, FontWeight.w600, height: height);
  }

  static text_20_600(Color color, {height}) {
    return _textStyle(color, 20.sp, FontWeight.w600, height: height);
  }

  static text_22_600(Color color, {height}) {
    return _textStyle(color, 22.sp, FontWeight.w600, height: height);
  }

  static text_24_600(Color color, {height}) {
    return _textStyle(color, 24.sp, FontWeight.w600, height: height);
  }

  static text_26_600(Color color, {height}) {
    return _textStyle(color, 26.sp, FontWeight.w600, height: height);
  }

  static text_28_600(Color color, {height}) {
    return _textStyle(color, 28.sp, FontWeight.w600, height: height);
  }

  static text_30_600(Color color, {height}) {
    return _textStyle(color, 30.sp, FontWeight.w600, height: height);
  }

  static text_34_600(Color color, {height}) {
    return _textStyle(color, 34.sp, FontWeight.w600, height: height);
  }

  static text_36_600(Color color, {height}) {
    return _textStyle(color, 36.sp, FontWeight.w600, height: height);
  }

  static text_40_600(Color color, {height}) {
    return _textStyle(color, 40.sp, FontWeight.w600, height: height);
  }

  static text_14_800(Color color, {height}) {
    return _textStyle(color, 14.sp, FontWeight.w800, height: height);
  }

  static text_15_800(Color color, {height}) {
    return _textStyle(color, 15.sp, FontWeight.w800, height: height);
  }

  static text_16_800(Color color, {height}) {
    return _textStyle(color, 16.sp, FontWeight.w800, height: height);
  }

  static text_18_800(Color color, {height}) {
    return _textStyle(color, 18.sp, FontWeight.w800, height: height);
  }

  static text_20_800(Color color, {height}) {
    return _textStyle(color, 20.sp, FontWeight.w800, height: height);
  }

  static text_22_800(Color color, {height}) {
    return _textStyle(color, 22.sp, FontWeight.w800, height: height);
  }

  static text_24_800(Color color, {height}) {
    return _textStyle(color, 24.sp, FontWeight.w800, height: height);
  }

  static text_26_800(Color color, {height}) {
    return _textStyle(color, 26.sp, FontWeight.w800, height: height);
  }

  static text_28_800(Color color, {height}) {
    return _textStyle(color, 28.sp, FontWeight.w800, height: height);
  }

  static text_30_800(Color color, {height}) {
    return _textStyle(color, 30.sp, FontWeight.w800, height: height);
  }

  static text_56_800(Color color, {height}) {
    return _textStyle(color, 56.sp, FontWeight.w800, height: height);
  }

  ///`custom text ===========>`

  static customText(Color color, double size, FontWeight fontWeight, {height}) {
    return _textStyle(color, size, fontWeight, height: height);
  }
}
