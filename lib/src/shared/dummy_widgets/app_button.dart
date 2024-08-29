import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/shared/platform_widgets/platform_custom_loading_indicator.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AppMainButton extends StatelessWidget {
  const AppMainButton({
    super.key,
    this.buttonColor,
    required this.title,
    this.icon,
    this.onButtonTapped,
    this.isBusy = false,
    this.width,
    this.textStyle,
    this.height,
    this.boarderColor,
  });
  final Color? buttonColor;
  final Color? boarderColor;
  final String title;
  final Widget? icon;
  final void Function()? onButtonTapped;
  final bool isBusy;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTapped,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
            gradient:  LinearGradient(colors: onButtonTapped == null? [
              const Color(0xff62CDCB).withOpacity(0.7),
              const Color(0xff4599DB).withOpacity(0.5),
            ]:
             [
              const Color(0xff62CDCB),
              const Color(0xff4599DB),
            ]),
            boxShadow: onButtonTapped == null
                ? null
                : [
                    BoxShadow(
                      color: const Color(0xff62CDCB).withOpacity(0.5),
                      offset: const Offset(0, 6),
                      blurRadius: 7,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: const Color(0xff4599DB).withOpacity(0.5),
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ],
            borderRadius: BorderRadius.circular(8)),
        child: isBusy
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: PlatformCustomLoadingIndicator(),
                ),
              )
            : Stack(alignment: Alignment.center, children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      context.textTheme.bodyLarge!.copyWith(
                          color: onButtonTapped != null
                              ? AppTheme.kcWhiteColor
                              : AppTheme.kcWhiteColor.withOpacity(0.2),
                          fontWeight: FontWeight.bold),
                ),
                if (icon != null)
                  Container(
                      padding: EdgeInsets.only(right: 15.w),
                      alignment: Alignment.centerRight,
                      child: icon!),
              ]),
      ),
    );
  }
}
