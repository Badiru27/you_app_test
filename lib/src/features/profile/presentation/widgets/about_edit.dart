import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/features/profile/presentation/bloc/edit_profile_cubit.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';
import 'package:you_app/src/shared/dummy_widgets/app_date_input.dart';
import 'package:you_app/src/shared/dummy_widgets/app_dropdown.dart';
import 'package:you_app/src/shared/dummy_widgets/app_input_field.dart';
import 'package:you_app/src/shared/dummy_widgets/gradient_text.dart';
import 'package:you_app/src/shared/platform_widgets/platform_custom_loading_indicator.dart';
import 'package:you_app/src/theme/app_theme.dart';

class AboutEditWidget extends StatelessWidget {
  final Profile? profile;
  const AboutEditWidget({super.key, required this.profile});
  static const gender = ['Male', 'Female', 'Others'];
  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ProfileBloc>();
    final editProfileCubit = context.watch<EditProfileCubit>();
    final initialGender =
        gender.where((g) => g.toUpperCase() == profile?.gender);
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
                    imageUrl: editProfileCubit.state.imageUrl,
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
              GestureDetector(
                onTap: () {
                  editProfileCubit.pickImage();
                },
                child: AppCard(
                    radius: 17.r,
                    color: const Color(0xFF162329).withOpacity(0.6),
                    image: editProfileCubit.state.file == null
                        ? null
                        : DecorationImage(
                            image: FileImage(
                                File(editProfileCubit.state.file!.path)),
                            fit: BoxFit.cover),
                    child: editProfileCubit.state.imageLoading
                        ? const Center(child: PlatformCustomLoadingIndicator())
                        : GestureDetector(
                            child: const Icon(
                              Icons.add,
                              size: 42,
                              color: AppTheme.kcPrimaryColor,
                            ),
                          )),
              ),
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
                initialValue: profile?.displayName,
              )),
          _inputWidget(
              title: 'Gender:',
              context: context,
              input: AppDropDown(
                label: 'Select Gender',
                name: 'gender',
                initialValue:
                    initialGender.isEmpty ? null : initialGender.first,
                items: gender,
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
                initialDate: DateTime(1990, 9, 7, 17, 30),
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
                child: Text(editProfileCubit.state.horoscope ??
                    profile?.horoscope ??
                    '- -'),
              )),
          _inputWidget(
              title: 'Zodiac:',
              context: context,
              input: AppCard(
                radius: 9.r,
                borderWidth: 0,
                color: AppTheme.kcWhiteColor.withOpacity(0.1),
                child: Text(
                    editProfileCubit.state.zodiac ?? profile?.zodiac ?? '- -'),
              )),
          _inputWidget(
              title: 'Height:',
              context: context,
              input: AppInputField(
                hintText: 'Add height',
                initialValue:
                    profile?.height == 0 ? null : profile?.height.toString(),
                keyboardType: TextInputType.number,
                onChanged: editProfileCubit.heightChanged,
              )),
          _inputWidget(
              title: 'Weight:',
              context: context,
              input: AppInputField(
                hintText: 'Add weight',
                initialValue:
                    profile?.weight == 0 ? null : profile?.height.toString(),
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
