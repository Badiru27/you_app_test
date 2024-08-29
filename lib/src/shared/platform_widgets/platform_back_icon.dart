import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';

class PlatformBackIcon extends StatelessWidget {
  const PlatformBackIcon({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child:
              Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back)),
    );
  }
}

class PlatformBackIconWithText extends StatelessWidget {
  const PlatformBackIconWithText({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Back(
      onTap: onTap,
    ));
  }
}

class Back extends StatelessWidget {
  final void Function()? onTap;
  const Back({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Row(
          children: [
            Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              size: 18,
            ),
            Text(
              'Back',
              style: context.textTheme.displayMedium?.copyWith(fontSize: 14),
            )
          ],
        ));
  }
}

class BackIconWidget extends StatelessWidget {
  final void Function()? onTap;
  const BackIconWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Icon(
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          color: context.theme.hoverColor,
        ));
  }
}
