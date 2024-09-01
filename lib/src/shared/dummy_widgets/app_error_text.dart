import 'package:flutter/material.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AppErrorText extends StatelessWidget {
  final String error;
  const AppErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(error,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppTheme.kcErrorColor,
            )),
        AppSpacing.setVerticalSpace(10)
      ],
    );
  }
}
