import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:you_app/src/core/constant/app_assets.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/auth/domain/entities/user.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';
import 'package:you_app/src/theme/app_theme.dart';

class CoverWidget extends StatelessWidget {
  final User? user;
  const CoverWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return user == null || (user?.image ?? '').isNotEmpty
        ? ImageCover(
            height: 190.h,
            image: AppAsset.imageCover,
            child: _child(context: context, user: user))
        : AppCard(
            height: 190.h,
            width: double.infinity,
            borderColor: Colors.transparent,
            borderWidth: 0,
            color: const Color(0xFF162329).withOpacity(0.6),
            child: _child(context: context, user: user));
  }

  Widget _child({required User? user, required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {},
            child: const SizedBox.shrink(),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user?.myUserName}, ${user?.age}',
                style: context.textTheme.displayMedium?.copyWith(fontSize: 16),
              ),
              if (user != null && user.gender.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(user.gender),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    if (user != null && user.horoscope.isNotEmpty)
                      _iconText(
                          text: user.horoscope, icon: AppAsset.horoscopeIcon),
                    if (user != null && user.zodiac.isNotEmpty)
                      _iconText(text: user.zodiac, icon: AppAsset.zodiacIcon)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconText({required String icon, required String text}) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: AppCard(
            radius: 100,
            color: AppTheme.kcWhiteColor.withOpacity(0.1),
            borderColor: Colors.transparent,
            borderWidth: 0,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                SvgPicture.asset(icon),
                AppSpacing.horizontalSpaceSmall,
                Text(text),
              ],
            )),
      );
}
