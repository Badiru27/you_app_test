import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/core/extensions/validator.dart';
import 'package:you_app/src/features/auth/presentation/bloc/register_cubit.dart';
import 'package:you_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:you_app/src/shared/dummy_widgets/app_background_container.dart';
import 'package:you_app/src/shared/dummy_widgets/app_button.dart';
import 'package:you_app/src/shared/dummy_widgets/app_input_field.dart';
import 'package:you_app/src/shared/dummy_widgets/app_password_input_field.dart';
import 'package:you_app/src/shared/platform_widgets/platform_back_icon.dart';
import 'package:you_app/src/theme/app_theme.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  static const routeName = '/registration';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegistrationCubit>();
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
                const PlatformBackIconWithText(),
                AppSpacing.setVerticalSpace(80),
                Text(
                  'Register',
                  style: context.textTheme.displayLarge,
                ),
                AppSpacing.setVerticalSpace(25),
                AppInputField(
                  hintText: 'Enter Email',
                  onChanged: registerCubit.emailChanged,
                  validator: context.validateEmailAddress,
                ),
                AppSpacing.setVerticalSpace(15),
                AppInputField(
                  hintText: 'Create Username',
                  onChanged: registerCubit.userNameChanged,
                  validator: context.validateUserName,
                ),
                AppSpacing.setVerticalSpace(15),
                AppPasswordInputField(
                  hintText: 'Create Password',
                  onChanged: registerCubit.passwordChanged,
                  validator: context.validatePassword,
                  obscureText: !registerCubit.state.showPassword,
                  onSuffixTapped: registerCubit.toggleObscureText,
                ),
                AppSpacing.setVerticalSpace(15),
                AppPasswordInputField(
                  hintText: 'Confirm Password',
                  obscureText: !registerCubit.state.showPassword,
                  onChanged: registerCubit.confirmPasswordChanged,
                  onSuffixTapped: registerCubit.toggleObscureText,
                  validator: (val) {
                    if (val != registerCubit.state.password) {
                      return 'Password not matched';
                    }

                    return null;
                  },
                ),
                AppSpacing.setVerticalSpace(25),
                AppMainButton(
                  title: 'Register',
                  isBusy: registerCubit.state.isLoading,
                  onButtonTapped: () async {
                    if (_formKey.currentState!.validate()) {
                      await registerCubit.register();
                    }
                  },
                ),
                AppSpacing.setVerticalSpace(50),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Have an account? ",
                        style: context.textTheme.labelLarge),
                    TextSpan(
                        text: 'Login here',
                        style: context.textTheme.titleSmall?.copyWith(
                            color: AppTheme.kcPrimaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.kcPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(LoginScreen.routeName);
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
