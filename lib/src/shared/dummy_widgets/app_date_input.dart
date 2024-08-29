import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AppDatePicker extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Function(DateTime?)? onChanged;
  final String? Function(DateTime?)? validator;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const AppDatePicker(
      {super.key,
      required this.label,
      this.controller,
      this.keyboardType,
      this.obscureText,
      this.validator,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.onChanged});

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: AppTheme.inputFieldBorderRadius,
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme,
      child: FormBuilderDateTimePicker(
        name: label,
        textAlign: TextAlign.end,
        style: context.textTheme.bodyMedium,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        format: DateFormat('dd-MM-yyyy'),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputType: InputType.date,
        decoration: InputDecoration(
          label: Text(
            label,
            style: context.textTheme.bodyMedium
            ?.copyWith(color: AppTheme.kcWhiteColor.withOpacity(0.6)),
            textAlign: TextAlign.end,
          ),
          enabledBorder: _border(Colors.transparent),
          focusedBorder: _border(AppTheme.kcWhiteColor.withOpacity(0.1)),
          border: _border(AppTheme.kcWhiteColor.withOpacity(0.1)),
        ),
      ),
    );
  }
}
