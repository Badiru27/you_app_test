import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/src/core/bloc/bloc_helper.dart';
import 'package:you_app/src/features/auth/presentation/bloc/login_cubit.dart';
import 'package:you_app/src/features/auth/presentation/bloc/register_cubit.dart';
import 'package:you_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:you_app/src/features/auth/presentation/pages/registration_screen.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/pages/interest_screen.dart';
import 'package:you_app/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:you_app/src/shared/smart_widgets/app_container.dart';

GoRouter routes() {
  return GoRouter(initialLocation: ProfileScreen.routeName, routes: [
    GoRoute(
        path: AppContainer.routeName,
        builder: (context, state) {
          return const AppContainer();
        }),
    GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) {
          return createBlocProviderWithChild(LoginCubit(),
              child: LoginScreen());
        }),
    GoRoute(
        path: RegistrationScreen.routeName,
        builder: (context, state) {
          return createBlocProviderWithChild(RegistrationCubit(),
              child: RegistrationScreen());
        }),
    GoRoute(
        path: ProfileScreen.routeName,
        builder: (context, state) {
          return  const ProfileScreen();
        }),
    GoRoute(
        path: InterestScreen.routeName,
        builder: (context, state) {
          return const InterestScreen();
        }),
  ]);
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
