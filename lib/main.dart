import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:you_app/src/features/auth/presentation/pages/registration_screen.dart';
import 'package:you_app/src/features/profile/presentation/pages/interest_screen.dart';
import 'package:you_app/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:you_app/src/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        home:  LoginScreen(),
      ),
    );
  }
}


