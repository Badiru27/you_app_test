import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.minLines = 1,
    this.activeBorderColor,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusNode,
    this.enabled,
    this.initialValue,
  });
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final Color? activeBorderColor;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final FocusNode? focusNode;
  final bool? enabled;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      style: theme.textTheme.bodyMedium?.copyWith(color: theme.hoverColor),
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      enabled: enabled,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            context.textTheme.bodyMedium
                ?.copyWith(color: AppTheme.kcWhiteColor.withOpacity(0.6)),
        enabledBorder: enabledBorder,
        disabledBorder: disabledBorder,
        errorBorder: errorBorder,
        focusedBorder: focusedBorder ??
            (activeBorderColor != null
                ? theme.inputDecorationTheme.focusedBorder?.copyWith(
                    borderSide: BorderSide(color: activeBorderColor!),
                  )
                : theme.inputDecorationTheme.focusedBorder),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: suffixIcon,
              )
            : null,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: prefixIcon,
              )
            : null,
      ),
    );
  }
}
