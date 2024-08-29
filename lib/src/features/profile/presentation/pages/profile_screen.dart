import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:you_app/src/core/constant/app_assets.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/profile/presentation/widgets/cover_widget.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';
import 'package:you_app/src/shared/platform_widgets/platform_back_icon.dart';
import 'package:you_app/src/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SafeArea(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Back(),
                  Text(
                    '@johndoe',
                    style:
                        context.textTheme.displayMedium?.copyWith(fontSize: 14),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAsset.downEllipsisIcon))
                ],
              )),
              AppSpacing.setVerticalSpace(20),
              CoverWidget(),
              AppSpacing.setVerticalSpace(20),
              //AboutEditWidget(),
              _editCard(
                  onTap: () {},
                  context: context,
                  title: 'About',
                  description:
                      'Add in your your to help others know you better',
                  child: Column(
                    children: [
                      _textAndDetails(
                          context: context,
                          title: 'Birthday: ',
                          description: '28 / 08 / 1995 (Age 28)'),
                      _textAndDetails(
                          context: context,
                          title: 'Horoscope: ',
                          description: 'Virgo'),
                      _textAndDetails(
                          context: context,
                          title: 'Zodiac: ',
                          description: 'Pig'),
                      _textAndDetails(
                          context: context,
                          title: 'Height: ',
                          description: '175cm'),
                      _textAndDetails(
                          context: context,
                          title: 'Weight: ',
                          description: '69 kg'),
                    ],
                  )),

              AppSpacing.setVerticalSpace(20),
              _editCard(
                  context: context,
                  title: 'Interest',
                  description: 'Add in your interest to find a better match',
                  onTap: () {},
                  child: Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      _roundText(context: context, text: 'Music'),
                      _roundText(context: context, text: 'Basketball'),
                      _roundText(context: context, text: 'Fitness'),
                      _roundText(context: context, text: 'Gymming'),
                    ],
                  )),
                  AppSpacing.setVerticalSpace(50)
            ],
          ),
        ),
      ),
    );
  }

  Widget _editCard(
      {required BuildContext context,
      required String title,
      required String description,
      required void Function()? onTap,
      required Widget? child}) {
    return AppCard(
      color: const Color(0xFF162329).withOpacity(0.4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.displayMedium?.copyWith(fontSize: 14),
              ),
              GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    AppAsset.editIcon,
                    height: 24,
                  ))
            ],
          ),
          AppSpacing.setVerticalSpace(20),
          child ??
              Text(
                description,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: AppTheme.kcWhiteColor.withOpacity(0.7)),
              )
        ],
      ),
    );
  }

  Widget _textAndDetails(
      {required BuildContext context,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium
                ?.copyWith(color: AppTheme.kcWhiteColor.withOpacity(0.4)),
          ),
          Text(description)
        ],
      ),
    );
  }
}

Widget _roundText({
  required BuildContext context,
  required String text,
}) {
  return AppCard(
    color: AppTheme.kcWhiteColor.withOpacity(0.1),
    radius: 100.r,
    borderWidth: 0,
    borderColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Text(
      text,
      style:
          context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
  );
}
