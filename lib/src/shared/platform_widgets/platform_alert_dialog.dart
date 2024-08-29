import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';

class PlatformAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPositivePressed;
  final VoidCallback onNegativePressed;
  final String? positiveButtonText;
  final String? negativeButtonText;

  const PlatformAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPositivePressed,
    required this.onNegativePressed,
    this.positiveButtonText = 'Cancel',
    this.negativeButtonText = 'OK',
  });

  @override
  Widget build(BuildContext context) {
    return (Theme.of(context).platform == TargetPlatform.iOS)
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog(context);
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: onPositivePressed,
          child: Text(positiveButtonText!),
        ),
        CupertinoDialogAction(
          onPressed: onNegativePressed,
          child: Text(negativeButtonText!,
              style: TextStyle(color: context.theme.colorScheme.error)),
        ),
      ],
    );
  }

  Widget _buildMaterialDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onPositivePressed,
          child:  Text(positiveButtonText!),
        ),
        TextButton(
          onPressed: onNegativePressed,
          child: Text(negativeButtonText!,
              style: TextStyle(color: context.theme.colorScheme.error)),
        ),
      ],
    );
  }
}
