import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/profile/presentation/bloc/edit_profile_cubit.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
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
    final homeBloc = context.read<ProfileBloc>();
    final editProfileCubit = context.watch<EditProfileCubit>();
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
              GestureDetector(
                onTap: () {
                  homeBloc.add(SaveAboutEvent(
                    birthday: editProfileCubit.state.birthday,
                    displayName: editProfileCubit.state.displayName,
                    gender: editProfileCubit.state.gender,
                    height: editProfileCubit.state.height,
                    weight: editProfileCubit.state.weight,
                    horoscope: editProfileCubit.state.horoscope,
                    zodiac: editProfileCubit.state.zodiac,
                  ));
                  editProfileCubit.reInitialize();
                },
                child: const GradientText(
                  text: 'Save & Update',
                ),
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
          _inputWidget(
              title: 'Display name:',
              context: context,
              input: AppInputField(
                hintText: 'Enter name',
                onChanged: editProfileCubit.displayNameChanged,
              )),
          _inputWidget(
              title: 'Gender:',
              context: context,
              input: AppDropDown(
                label: 'Select Gender',
                name: 'gender',
                initialValue: null,
                items: const ['Male', 'Female', 'Others'],
                onChanged: editProfileCubit.genderChanged,
                onSaved: (val) {},
              )),
          _inputWidget(
              title: 'Birthday:',
              context: context,
              input: AppDatePicker(
                label: 'DD MM YYYY',
                lastDate: DateTime(2010, 9, 7, 17, 30),
                firstDate: DateTime(1940, 9, 7, 17, 30),
                initialDate:  DateTime(1990, 9, 7, 17, 30),
                onChanged: (val) {
                  if (val == null) return;
                  editProfileCubit
                      .birthdayChanged(val.toIso8601String().split('T')[0]);
                },
              )),
          _inputWidget(
              title: 'Horoscope:',
              context: context,
              input: AppCard(
                radius: 9.r,
                borderWidth: 0,
                color: AppTheme.kcWhiteColor.withOpacity(0.1),
                child: Text(editProfileCubit.state.horoscope ?? '- -'),
              )),
          _inputWidget(
              title: 'Zodiac:',
              context: context,
              input: AppCard(
                radius: 9.r,
                borderWidth: 0,
                color: AppTheme.kcWhiteColor.withOpacity(0.1),
                child: Text(editProfileCubit.state.zodiac ?? '- -'),
              )),
          _inputWidget(
              title: 'Height:',
              context: context,
              input: AppInputField(
                hintText: 'Add height',
                keyboardType: TextInputType.number,
                onChanged: editProfileCubit.heightChanged,
              )),
          _inputWidget(
              title: 'Weight:',
              context: context,
              input: AppInputField(
                hintText: 'Add weight',
                keyboardType: TextInputType.number,
                onChanged: editProfileCubit.weightChanged,
              )),
        ],
      ),
    );
  }

  Widget _inputWidget(
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
