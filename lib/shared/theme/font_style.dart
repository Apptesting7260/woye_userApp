import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontStyle {
  static TextStyle _textStyle(
      Color color, double size, FontWeight fontWeight, TextOverflow overflow) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        fontFamily: "Gilroy");
  }

  static text_14_400(Color color) {
    return _textStyle(color, 14.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_15_400(Color color) {
    return _textStyle(color, 15.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_16_400(Color color) {
    return _textStyle(color, 16.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_18_400(Color color) {
    return _textStyle(color, 18.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_20_400(Color color) {
    return _textStyle(color, 20.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_22_400(Color color) {
    return _textStyle(color, 22.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_24_400(Color color) {
    return _textStyle(color, 24.sp, FontWeight.w400, TextOverflow.ellipsis);
  }

  static text_14_600(Color color) {
    return _textStyle(color, 14.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_15_600(Color color) {
    return _textStyle(color, 15.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_16_600(Color color) {
    return _textStyle(
      color,
      16.sp,
      FontWeight.w600,
      TextOverflow.ellipsis,
    );
  }

  static text_18_600(Color color) {
    return _textStyle(color, 18.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_20_600(Color color) {
    return _textStyle(color, 20.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_22_600(Color color) {
    return _textStyle(color, 22.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_24_600(Color color) {
    return _textStyle(color, 24.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_26_600(Color color) {
    return _textStyle(color, 26.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_28_600(Color color) {
    return _textStyle(color, 28.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_30_600(Color color) {
    return _textStyle(color, 30.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_36_600(Color color) {
    return _textStyle(color, 36.sp, FontWeight.w600, TextOverflow.ellipsis);
  }

  static text_40_600(Color color) {
    return _textStyle(
      color,
      40.sp,
      FontWeight.w600,
      TextOverflow.ellipsis,
    );
  }

  static text_56_800(Color color) {
    return _textStyle(color, 56.sp, FontWeight.w800, TextOverflow.ellipsis);
  }

  static customText(Color color, double size, FontWeight fontWeight) {
    return _textStyle(color, size, fontWeight, TextOverflow.ellipsis);
  }
}
