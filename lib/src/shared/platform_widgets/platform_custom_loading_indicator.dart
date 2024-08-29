
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformCustomLoadingIndicator extends StatelessWidget {

  const PlatformCustomLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
