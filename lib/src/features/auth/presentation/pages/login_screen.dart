import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/shared/dummy_widgets/app_background_container.dart';
import 'package:you_app/src/shared/dummy_widgets/app_button.dart';
import 'package:you_app/src/shared/dummy_widgets/app_input_field.dart';
import 'package:you_app/src/shared/dummy_widgets/app_password_input_field.dart';
import 'package:you_app/src/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppBackgroundContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              ),
              AppSpacing.setVerticalSpace(15),
              AppPasswordInputField(
                hintText: 'Password',
              ),
              AppSpacing.setVerticalSpace(25),
              AppMainButton(
                title: 'Register',
                onButtonTapped: () {},
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
                        decorationColor: AppTheme.kcPrimaryColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ])),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
