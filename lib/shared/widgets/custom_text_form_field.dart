import 'package:flutter/services.dart';
import 'package:woye_user/core/utils/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.enabled,
    this.onChanged,
    this.onTapOutside,
    this.borderRadius,
    this.inputFormatters,
    this.minLines,
  });

  final Alignment? alignment;

  final double? width;
  final double? height;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final int? minLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final BorderRadius? borderRadius;

  final FormFieldValidator<String>? validator;
  final bool? enabled;
  final Function(String value)? onChanged;
  final TapRegionCallback? onTapOutside;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        height: height,
        child: TextFormField(
          // expands: true,

          onTapOutside: onTapOutside,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enabled ?? true,
          controller: controller,
          // focusNode: focusNode ?? FocusNode(),
          // autofocus: autofocus!,
          style: textStyle ?? AppFontStyle.text_16_400(AppColors.darkText),
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          // maxLines: null,
          // minLines: null,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          decoration: decoration,
          validator: validator,
          inputFormatters: inputFormatters,
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? AppFontStyle.text_14_400(AppColors.hintText),
        prefixIcon: prefix,
        prefixIconConstraints:
            prefixConstraints ?? BoxConstraints(minWidth: 30.w),
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            REdgeInsets.symmetric(vertical: 15, horizontal: 20),
        fillColor: fillColor ?? Colors.transparent,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBorder),
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(15.r)),
            ),
        // GradientOutlineInputBorder(
        //     borderRadius:
        //         borderRadius ?? const BorderRadius.all(Radius.circular(60)),
        //     gradient: AppColors.borderGradient),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBorder),
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(15.r)),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBorder),
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(15.r)),
            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillPrimary => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillWhiteA => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillPrimaryTL24 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.h),
        borderSide: BorderSide.none,
      );
  static UnderlineInputBorder get underLineOnError =>
      const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      );
  static OutlineInputBorder get outlineBlueGrayTL20 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillWhiteATL16 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillPrimaryTL12 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineBlueGrayTL15 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.h),
        borderSide: BorderSide.none,
      );
}
