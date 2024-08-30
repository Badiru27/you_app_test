import 'package:flutter/material.dart';
import 'package:you_app/src/shared/platform_widgets/platform_custom_loading_indicator.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PlatformCustomLoadingIndicator(),
      ),
    );
  }
}
