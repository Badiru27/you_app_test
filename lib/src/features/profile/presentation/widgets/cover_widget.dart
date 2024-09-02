import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:you_app/src/core/constant/app_assets.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';
import 'package:you_app/src/theme/app_theme.dart';

class CoverWidget extends StatelessWidget {
  final Profile? profile;
  const CoverWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return (profile?.imageUrl ?? '').isNotEmpty
        ? ImageCover(
            height: 190.h,
            image: profile!.imageUrl,
            child: _child(context: context, profile: profile))
        : AppCard(
            height: 190.h,
            width: double.infinity,
            borderColor: Colors.transparent,
            borderWidth: 0,
            color: const Color(0xFF162329).withOpacity(0.6),
            child: _child(context: context, profile: profile));
  }

  Widget _child({required Profile? profile, required BuildContext context}) {
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
                '${profile?.user.myUserName ?? ''}, ${profile?.age ?? ''}',
                style: context.textTheme.displayMedium?.copyWith(fontSize: 16),
              ),
              if (profile != null && profile.gender.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(profile.gender),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    if (profile != null && profile.zodiac.isNotEmpty)
                      _iconText(
                          text: profile.zodiac, icon: AppAsset.horoscopeIcon),
                    if (profile != null && profile.horoscope.isNotEmpty)
                      _iconText(
                          text: profile.horoscope, icon: AppAsset.zodiacIcon),
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
