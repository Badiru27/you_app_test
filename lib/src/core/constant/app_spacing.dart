import 'package:flutter/material.dart';
import 'package:you_app/src/core/extensions/responsiveness.dart';


class AppSpacing {
  static double screenWidth(context) => MediaQuery.of(context).size.width;
  static double screenHeight(context) => MediaQuery.of(context).size.height;
// Vertical Spacing
  static const verticalSpaceTiny = SizedBox(
    height: 5,
  );
  static const verticalSpaceVerySmall = SizedBox(height: 8);
  static const verticalSpaceSmall = SizedBox(height: 10);
  static const verticalSpaceMedium = SizedBox(height: 15);
  static const verticalSpaceLarge = SizedBox(height: 18);
  static const verticalSpaceExtraLarge = SizedBox(height: 35);
  static const verticalSpaceFairlyLarge = SizedBox(height: 24);
  static SizedBox setVerticalSpace(int h) => SizedBox(height: h.height);

// horizontal Spacing
  static const horizontalSpaceTiny = SizedBox(width: 5);
  static const horizontalSpaceVerySmall = SizedBox(width: 8);
  static const horizontalSpaceSmall = SizedBox(width: 10);
  static const horizontalSpaceMedium = SizedBox(width: 15);
  static const horizontalSpaceLarge = SizedBox(width: 18);
  static const horizontalSpaceExtraLarge = SizedBox(width: 30);
  static SizedBox setHorizontalSpace(num w) => SizedBox(width: w.width);

}
