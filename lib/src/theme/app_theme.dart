import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTheme {
  static BorderRadius appBorderRadius = BorderRadius.circular(30.r);
  static BorderRadius inputFieldBorderRadius = BorderRadius.circular(9.r);
  static double buttonWidth = 160.w;
  static double buttonHeight = 52.h;
  static double selectHeight = 40.h;

  static const kcBackgroundColor = Color(0xFF100F13);
  static const kcPrimaryColor = Color(0xFFe4cb9c);
  static const kcBrowColor = Color(0xFFFFDF8D);
  static const kcBlackColor = Color(0xFF292929);
  static const kcGrayColor = Color(0XFF929497);
  static const kcLightGrayColor = Color(0XFFF6F6F6);
  static const kcWhiteColor = Color(0xFFFEFEFE);
  static const kcLightGreenColor = Color(0xFFDBFFDB);
  static const kcYellowColor = Color(0xFFFFFE86);
  static const kcGoldColor = Color(0xFFF8DC9C);
  static const kcBlueColor = Color(0xFFA3C0FF);
  static const kcErrorColor = Color(0xFFFF5247);
  static const kcOrangeColor = Color(0xFFFFA500);

  static const kcPrimaryColorCode = 0xFFB59ADE;
  static const String fontFamily1 = 'Outfit';
  static const String fontFamily2 = 'Outfit';



  //input background colors
  static const lightGrayColor = Color(0XFFF6F6F6);
  static const darkGrayColor = Color(0XFF282828);
  static const blackColor = Color(0xFF100F13);


  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: kcPrimaryColor,
      fontFamily: fontFamily1,
    
      colorScheme: const ColorScheme(
          surfaceContainer: kcBackgroundColor,
          
          brightness: Brightness.dark,
          primary: kcPrimaryColor,
          secondary: kcPrimaryColor,
          surface: kcWhiteColor,
          error: kcErrorColor,
          onPrimary: kcBackgroundColor,
          onSecondary: kcBackgroundColor,
          onSurface: kcBackgroundColor,
          onError: kcBackgroundColor,
          onSurfaceVariant: kcWhiteColor),
      cardColor: darkGrayColor,
      canvasColor: kcBackgroundColor,
      hoverColor: kcWhiteColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kcWhiteColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: kcWhiteColor.withOpacity(0.1),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: kcWhiteColor.withOpacity(0.3), width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kcErrorColor, width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kcPrimaryColor, width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: kcPrimaryColor,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.5,
            color: kcPrimaryColor,
          ),
        ),
        labelColor: kcWhiteColor,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorColor: kcPrimaryColor,
      ),
      snackBarTheme: const SnackBarThemeData(
        actionTextColor: kcWhiteColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: kcBackgroundColor, elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: kcBackgroundColor,
        selectedItemColor: kcPrimaryColor,
        unselectedItemColor: kcGrayColor,
        elevation: 0,
      ),
      scaffoldBackgroundColor: kcBackgroundColor,
      appBarTheme: const AppBarTheme(backgroundColor: kcBackgroundColor),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 24.h,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily1,
            color: kcWhiteColor),
        displayMedium: TextStyle(
            fontSize: 20.h,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily2,
            color: kcWhiteColor),
        displaySmall: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily1,
            color: kcWhiteColor),
        bodyLarge: TextStyle(
            fontSize: 16.h, fontFamily: fontFamily1, color: kcWhiteColor),
        bodyMedium: TextStyle(
            fontSize: 13.h, fontFamily: fontFamily1, color: kcWhiteColor),
        bodySmall: TextStyle(
            fontSize: 12.h, fontFamily: fontFamily1, color: kcWhiteColor),
        labelLarge: TextStyle(
            fontSize: 12.h, fontFamily: fontFamily1, color: kcWhiteColor),
        labelMedium: TextStyle(
            fontSize: 10.h, fontFamily: fontFamily1, color: kcWhiteColor),
        labelSmall: TextStyle(
            fontSize: 8.h, fontFamily: fontFamily1, color: kcWhiteColor),
      ));

  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: kcPrimaryColor,
      fontFamily: fontFamily1,
      // backgroundColor: kcWhiteColor,
      colorScheme: const ColorScheme(
          background: kcWhiteColor,
          brightness: Brightness.light,
          primary: kcPrimaryColor,
          secondary: kcPrimaryColor,
          surface: kcWhiteColor,
          error: kcErrorColor,
          onPrimary: kcWhiteColor,
          onSecondary: kcWhiteColor,
          onSurface: kcWhiteColor,
          onError: kcWhiteColor,
          onBackground: kcGrayColor),
      cardColor: kcLightGrayColor,
      canvasColor: kcWhiteColor,
      hoverColor: kcBlackColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: kcPrimaryColor,
        unselectedItemColor: kcGrayColor,
        elevation: 0,
      ),
      snackBarTheme: const SnackBarThemeData(
        actionTextColor: kcBlackColor,
      ),
      tabBarTheme: const TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: kcPrimaryColor,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.5,
            color: kcPrimaryColor,
          ),
        ),
        labelColor: kcBlackColor,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorColor: kcPrimaryColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kcBackgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: lightGrayColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: kcBackgroundColor.withOpacity(0.9), width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kcErrorColor, width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kcPrimaryColor, width: 1.0),
          borderRadius: inputFieldBorderRadius,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: kcWhiteColor, elevation: 0),
      scaffoldBackgroundColor: kcWhiteColor,
      appBarTheme: const AppBarTheme(backgroundColor: kcWhiteColor),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 24.h,
            fontWeight: FontWeight.bold,
            color: kcBlackColor,
            fontFamily: fontFamily1),
        displayMedium: TextStyle(
            fontSize: 20.h,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily2,
            color: kcBlackColor),
        displaySmall: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily1,
            color: kcBlackColor),
        bodyLarge: TextStyle(
            fontSize: 16.h, fontFamily: fontFamily1, color: kcGrayColor),
        bodyMedium: TextStyle(
            fontSize: 14.h, fontFamily: fontFamily1, color: kcGrayColor),
        bodySmall: TextStyle(
            fontSize: 12.h, fontFamily: fontFamily1, color: kcGrayColor),
      ));
}
