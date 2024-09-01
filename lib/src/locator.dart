import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:you_app/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:you_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:you_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:you_app/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:you_app/src/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:you_app/src/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:you_app/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:you_app/src/features/profile/domain/repository/profile_repository.dart';
import 'package:you_app/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:you_app/src/service/api_service.dart';
import 'package:you_app/src/service/local_storage_service.dart';

final locator = GetIt.instance;

void setUpLocator() {
  //Services
  locator.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(Dio(), locator<AuthLocalDataSource>()),
  );
  locator.registerLazySingleton<LocalStorageService>(
    () => const LocalStorageService(),
  );

  //Data sources
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(locator.get<LocalStorageService>()),
  );
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: locator.get<ApiService>()),
  );
  locator.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(locator.get<LocalStorageService>()),
  );
  locator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(locator.get<ApiService>()),
  );

  // Repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        remoteDataSource: locator.get<AuthRemoteDataSource>(),
        localDataSource: locator.get<AuthLocalDataSource>(),
        profileRepository: locator<ProfileRepository>()),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
        remoteDataSource: locator.get<ProfileRemoteDataSource>(),
        localDataSource: locator.get<ProfileLocalDataSource>()),
  );

  //UseCases
  locator.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(locator.get<AuthRepository>()),
  );
  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(locator.get<AuthRepository>()),
  );
  locator.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(locator.get<ProfileRepository>()),
  );
  locator.registerLazySingleton<GetSavedProfileUseCase>(
    () => GetSavedProfileUseCase(locator.get<ProfileRepository>()),
  );
  locator.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(locator.get<ProfileRepository>()),
  );
}
