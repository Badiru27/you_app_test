import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/core/extensions/validator.dart';
import 'package:you_app/src/features/auth/presentation/bloc/login_cubit.dart';
import 'package:you_app/src/features/auth/presentation/pages/registration_screen.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:you_app/src/shared/dummy_widgets/app_background_container.dart';
import 'package:you_app/src/shared/dummy_widgets/app_button.dart';
import 'package:you_app/src/shared/dummy_widgets/app_error_text.dart';
import 'package:you_app/src/shared/dummy_widgets/app_input_field.dart';
import 'package:you_app/src/shared/dummy_widgets/app_password_input_field.dart';
import 'package:you_app/src/theme/app_theme.dart';

class LoginScreen extends HookWidget {
  LoginScreen({super.key});

  static const routeName = '/login';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();
    final profileCubit = context.read<ProfileBloc>();
    return Scaffold(
        body: AppBackgroundContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.setVerticalSpace(120),
                Text(
                  'Login',
                  style: context.textTheme.displayLarge,
                ),
                AppSpacing.setVerticalSpace(25),
                AppInputField(
                  hintText: 'Enter Username/Email',
                  onChanged: loginCubit.emailChanged,
                  validator: context.validateEmailAddressOrUsername,
                ),
                AppSpacing.setVerticalSpace(15),
                AppPasswordInputField(
                  hintText: 'Password',
                  onChanged: loginCubit.passwordChanged,
                  obscureText: !loginCubit.state.showPassword,
                  onSuffixTapped: loginCubit.toggleObscureText,
                ),
                AppSpacing.setVerticalSpace(25),
                if (loginCubit.state.error.isNotEmpty)
                  AppErrorText(error: loginCubit.state.error),
                AppMainButton(
                  title: ' Login ',
                  isBusy: loginCubit.state.isLoading,
                  onButtonTapped: () {
                    if (_formKey.currentState!.validate()) {
                      loginCubit.login().then((val) {
                        if (val) {
                          profileCubit.add(GetUserEvent());
                          context.go(ProfileScreen.routeName);
                        }
                      });
                    }
                  },
                ),
                AppSpacing.setVerticalSpace(50),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "No account? ",
                        style: context.textTheme.labelLarge),
                    TextSpan(
                        text: 'Register here',
                        style: context.textTheme.titleSmall?.copyWith(
                            color: AppTheme.kcPrimaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.kcPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(RegistrationScreen.routeName);
                          }),
                  ])),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
