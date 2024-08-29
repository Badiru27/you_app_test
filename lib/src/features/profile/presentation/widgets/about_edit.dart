import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';
import 'package:you_app/src/shared/dummy_widgets/app_date_input.dart';
import 'package:you_app/src/shared/dummy_widgets/app_dropdown.dart';
import 'package:you_app/src/shared/dummy_widgets/app_input_field.dart';
import 'package:you_app/src/shared/dummy_widgets/gradient_text.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AboutEditWidget extends StatelessWidget {
  const AboutEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: const Color(0xFF162329).withOpacity(0.3),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'About',
                style: context.textTheme.displayMedium?.copyWith(fontSize: 14),
              ),
              GradientText(
                text: 'Save & Update',
              )
            ],
          ),
          AppSpacing.setVerticalSpace(20),
          Row(
            children: [
              AppCard(
                  radius: 17.r,
                  color: const Color(0xFF162329).withOpacity(0.6),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.add,
                      size: 42,
                      color: AppTheme.kcPrimaryColor,
                    ),
                  )),
              AppSpacing.setHorizontalSpace(20),
              Text(
                'Add image',
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          AppSpacing.setVerticalSpace(20),
          inputWidget(
              title: 'Display name:',
              context: context,
              input: AppInputField(
                hintText: 'Enter name',
              )),
          inputWidget(
              title: 'Gender:',
              context: context,
              input: AppDropDown(
                label: 'Select Gender',
                name: 'gender',
                initialValue: null,
                items: ['Male', 'Female', 'Other'],
                onChanged: (val) {},
                onSaved: (val) {},
              )),
          inputWidget(
              title: 'Birthday:',
              context: context,
              input: AppDatePicker(
                label: 'DD MM YYYY',
              )),
          inputWidget(
              title: 'Horoscope:',
              context: context,
              input: AppInputField(
                hintText: '--',
              )),
          inputWidget(
              title: 'Zodiac:',
              context: context,
              input: AppInputField(
                hintText: '--',
              )),
          inputWidget(
              title: 'Height:',
              context: context,
              input: AppInputField(
                hintText: 'Add height',
              )),
          inputWidget(
              title: 'Weight:',
              context: context,
              input: AppInputField(
                hintText: 'Add weight',
              )),
        ],
      ),
    );
  }

  Widget inputWidget(
      {required String title,
      required Widget input,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          AppSpacing.setHorizontalSpace(20),
          SizedBox(
            width: AppSpacing.screenWidth(context) * 0.5,
            child: input,
          )
        ],
      ),
    );
  }
}
