import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';

class PlatformSwitch extends HookWidget {
  const PlatformSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          activeColor: context.theme.primaryColor,
          value: value,
          onChanged: onChanged,
        ),
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
      );
    }
  }
}
