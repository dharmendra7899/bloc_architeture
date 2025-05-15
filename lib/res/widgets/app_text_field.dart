import 'package:counter_demo_bloc/res/widgets/context_extension.dart';
import 'package:counter_demo_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? iconData;
  final Widget? leadingIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool readOnly;
  final bool showTitle;
  final bool mandatory;
  final Color? borderColor;
  final Color? fillColor;
  final TextEditingController? controller;
  final Function()? onTap;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final String? counterText;
  final double? fontSize;
  final Widget? prefixIcon;
  final TextInputType? keyBoardType;
  final bool? enabled;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.labelText,
    this.width = 1,
    this.iconData,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.showTitle = true,
    this.mandatory = false,
    this.autoFocus = false,
    this.height,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.leadingIcon,
    this.initialValue,
    this.style = const TextStyle(),
    this.validator,
    this.fontSize = 14,
    this.obscureText = false,
    this.focusNode,
    this.keyBoardType,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderColor,
    this.labelStyle,
    this.maxLength,
    this.fillColor,
    this.counterText,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 15,
    ),
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(labelText ?? "", style: context.textTheme.labelMedium),
            mandatory == true
                ? Text(
                  ' *',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: appColors.error,
                  ),
                )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 5),
        TextFormField(
          inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
          enabled: enabled,
          autofocus: autoFocus,
          focusNode: focusNode,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly,
          obscureText: obscureText,
          onTap: onTap,
          textAlign: textAlign,
          keyboardType: keyBoardType,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: maxLength,
          maxLines: maxLines,
          enableSuggestions: true,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            color: appColors.titleColor,
          ),
          obscuringCharacter: obscuringCharacter,
          decoration: InputDecoration(
            errorMaxLines: 3,
            prefixIcon: prefixIcon,
            counterText: '',
            fillColor: fillColor ?? appColors.loginBg,
            prefix: leadingIcon,
            hintStyle: context.textTheme.bodyLarge?.copyWith(
              fontSize: 15,
              color: appColors.editTextColor,
            ),
            hintText: hintText ?? "",
            suffixIcon: iconData,
            contentPadding: contentPadding,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimText = newValue.text.trimLeft();
      return TextEditingValue(
        text: trimText,
        selection: TextSelection(
          baseOffset: trimText.length,
          extentOffset: trimText.length,
        ),
      );
    }

    return newValue;
  }
}
