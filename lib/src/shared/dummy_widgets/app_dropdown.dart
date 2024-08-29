import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AppDropDown extends StatelessWidget {
  final List<String> items;
  final String label;
  final bool showIcon;
  final String? value;
  final String name;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final Function()? onReset;
  final String? Function(String?)? validator;
  final String? initialValue;

  const AppDropDown({
    super.key,
    required this.items,
    required this.label,
    this.showIcon = false,
    this.value,
    required this.name,
    required this.onChanged,
    required this.onSaved,
    this.onReset,
    this.validator,
    required this.initialValue,
  });

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      alignment: Alignment.centerLeft,
      name: name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSaved,
      onReset: onReset,
      validator: validator,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: context.textTheme.bodyMedium
            ?.copyWith(color: AppTheme.kcWhiteColor.withOpacity(0.6)),
        enabledBorder: _border(Colors.transparent),
        focusedBorder: _border(AppTheme.kcWhiteColor.withOpacity(0.1)),
        border: _border(AppTheme.kcWhiteColor.withOpacity(0.1)),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
    );
  }
}
