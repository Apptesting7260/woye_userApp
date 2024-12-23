import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:woye_user/Shared/Widgets/custom_text_form_field.dart';
import 'package:woye_user/shared/theme/colors.dart';

class address_autofill_field<T> extends StatelessWidget {
  final String hintText;
  final Widget? prefix;
  final Widget? postfix;
  final VoidCallback? onPostfixTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputFormatter? inputFormatter;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool hidetext;
  final bool readOnly;
  final Widget Function(BuildContext, T)? itemBuilder;
  final bool showMaxLength;
  final bool isAhead;
  final Future<List<T>> Function(String)? suggestionsCallback;
  final Future<T>? Function(T)? onSelected;

  const address_autofill_field({
    super.key,
    required this.hintText,
    this.prefix,
    this.postfix,
    this.onPostfixTap,
    required this.controller,
    this.keyboardType,
    this.inputFormatter,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.hidetext = false,
    this.readOnly = false,
    this.itemBuilder,
    this.showMaxLength = false,
    this.isAhead = false,
    this.suggestionsCallback,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return isAhead
        ? TypeAheadField<T>(
            suggestionsCallback: (query) async {
              final results = await suggestionsCallback!(query);
              return results.toList();
            },
            onSelected: (selected) async {
              onSelected!(selected);
            },
            loadingBuilder: (context) {
              return Center(
                child: CupertinoActivityIndicator(
                    radius: 10.0, color: AppColors.primary),
              );
            },
            controller: controller,
            itemBuilder: itemBuilder!,
            hideOnEmpty: controller.text.isEmpty,
            builder: (context, controller, focusNode) {
              return CustomTextFormField(
                controller: controller,
                focusNode: focusNode,
                hintText: hintText,
              );
            },
          )
        : CustomTextFormField(
            controller: controller,
            focusNode: focusNode,
            hintText: hintText,
          );
  }
}
