// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:you_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:you_app/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:you_app/src/locator.dart';
import 'package:you_app/src/shared/platform_widgets/platform_custom_loading_indicator.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({super.key});

  static const routeName = '/';

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleRouting(context: context);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PlatformCustomLoadingIndicator(),
      ),
    );
  }

  _handleRouting({required BuildContext context}) async {
    final authLocalStorage = locator<AuthLocalDataSource>();

    final token = await authLocalStorage.getToken();

    if (token != null) {
      context.push(ProfileScreen.routeName);
    } else {
      context.push(LoginScreen.routeName);
    }
  }
}
