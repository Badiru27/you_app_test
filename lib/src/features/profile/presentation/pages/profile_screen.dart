import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/src/core/bloc/bloc_helper.dart';
import 'package:you_app/src/core/constant/app_assets.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:you_app/src/features/profile/presentation/bloc/edit_profile_cubit.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_state.dart';
import 'package:you_app/src/features/profile/presentation/pages/interest_screen.dart';
import 'package:you_app/src/features/profile/presentation/widgets/about_edit.dart';
import 'package:you_app/src/features/profile/presentation/widgets/cover_widget.dart';
import 'package:you_app/src/locator.dart';
import 'package:you_app/src/service/cloudinary_upload_service.dart';
import 'package:you_app/src/service/file_picker_service.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';
import 'package:you_app/src/shared/platform_widgets/platform_back_icon.dart';
import 'package:you_app/src/shared/platform_widgets/platform_custom_loading_indicator.dart';
import 'package:you_app/src/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SafeArea(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Back(
                        onTap: () {},
                      ),
                      Text(
                        state.profile?.user.myUserName ?? '',
                        style: context.textTheme.displayMedium
                            ?.copyWith(fontSize: 14),
                      ),
                      PopupMenuButton<String>(
                          icon: SvgPicture.asset(AppAsset.downEllipsisIcon),
                          onSelected: (val) {
                            switch (val) {
                              case 'log-out':
                                profileBloc.add(LogOutEvent());
                                context.go(LoginScreen.routeName);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                    value: 'log-out',
                                    child: ListTile(
                                      leading: const Icon(Icons.login_outlined),
                                      title: Text(
                                        'Logout',
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                                color: AppTheme.kcWhiteColor),
                                      ),
                                    )),
                              ])
                    ],
                  )),
                  AppSpacing.setVerticalSpace(20),
                  CoverWidget(
                    profile: state.profile,
                  ),
                  AppSpacing.setVerticalSpace(20),
                  if (state.isEditingAbout)
                    createBlocProviderWithChild(
                        EditProfileCubit(locator<FilePickerService>(),
                            locator<CloudinaryUploadService>()),
                        child: AboutEditWidget(
                          profile: state.profile,
                        ))
                  else
                    _editCard(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        profileBloc.add(EditAboutEvent());
                      },
                      isLoading: state.isLoading,
                      context: context,
                      title: 'About',
                      description:
                          'Add in your your to help others know you better',
                      child: state.profile != null &&
                              !state.profile!.aboutIsEmpty
                          ? Column(
                              children: [
                                if (state.profile!.birthday.isNotEmpty)
                                  _textAndDetails(
                                      context: context,
                                      title: 'Birthday: ',
                                      description:
                                          '${state.profile?.birthday.split('T')[0]} (Age ${state.profile?.age})'),
                                if (state.profile!.horoscope.isNotEmpty)
                                  _textAndDetails(
                                      context: context,
                                      title: 'Horoscope: ',
                                      description:
                                          state.profile?.horoscope ?? ''),
                                if (state.profile!.zodiac.isNotEmpty)
                                  _textAndDetails(
                                      context: context,
                                      title: 'Zodiac: ',
                                      description: state.profile?.zodiac ?? ''),
                                if (state.profile!.height != 0)
                                  _textAndDetails(
                                      context: context,
                                      title: 'Height: ',
                                      description:
                                          '${state.profile?.height ?? ''} cm'),
                                if (state.profile!.weight != 0)
                                  _textAndDetails(
                                      context: context,
                                      title: 'Weight: ',
                                      description:
                                          '${state.profile?.weight ?? ''} kg'),
                              ],
                            )
                          : null,
                    ),
                  AppSpacing.setVerticalSpace(20),
                  _editCard(
                      context: context,
                      title: 'Interest',
                      isLoading: state.isLoading,
                      description:
                          'Add in your interest to find a better match',
                      onTap: () {
                        context.push(InterestScreen.routeName);
                      },
                      child: (state.profile?.interest ?? []).isEmpty
                          ? null
                          : Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: (state.profile?.interest ?? [])
                                  .map(
                                    (text) => _roundText(
                                        context: context, text: text),
                                  )
                                  .toList(),
                            )),
                  AppSpacing.setVerticalSpace(50)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _editCard({
    required BuildContext context,
    required String title,
    required String description,
    required void Function()? onTap,
    required Widget? child,
    required bool isLoading,
  }) {
    return AppCard(
      color: const Color(0xFF162329).withOpacity(0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.displayMedium?.copyWith(fontSize: 14),
              ),
              isLoading
                  ? const PlatformCustomLoadingIndicator()
                  : GestureDetector(
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
