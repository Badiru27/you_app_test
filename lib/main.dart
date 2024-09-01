import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:you_app/src/core/bloc/bloc_helper.dart';
import 'package:you_app/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/locator.dart';
import 'package:you_app/src/router.dart';
import 'package:you_app/src/theme/app_theme.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        createBlocProvider<ProfileBloc>(
            ProfileBloc(
                getProfileUseCase: locator<GetSavedProfileUseCase>(),
                updateProfileUseCase: locator<UpdateProfileUseCase>())
              ..add(GetUserEvent()),
            lazy: true),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MaterialApp.router(
          title: 'You App',
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: routes(),
        ),
      ),
    );
  }
}
