import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:you_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:you_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:you_app/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:you_app/src/features/profile/domain/repository/profile_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final ProfileRepository profileRepository;

  AuthRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.profileRepository});

  final _logger = Logger();
  @override
  Future<Either<Failure, String>> login(LoginParam param) async {
    try {
      final result = await remoteDataSource.logIn(param);
      await localDataSource.saveToken(result);
      profileRepository.getProfile();
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return const Left(ServerFailure(errorMessage: 'Wrong credential'));
      } else if (e.response?.statusCode == 404) {
        return const Left(ServerFailure(errorMessage: 'Invalid input'));
      }
      return const Left(ServerFailure(errorMessage: 'Server acting weird'));
    } catch (e) {
      _logger.e(e);
      return const Left(ServerFailure(errorMessage: 'Server acting weird'));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterParam param) async {
    try {
      final result = await remoteDataSource.register(param);
      await localDataSource.saveToken(result);
      profileRepository.getProfile();
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return const Left(
            ServerFailure(errorMessage: 'Username or Email already exist'));
      } else if (e.response?.statusCode == 404) {
        return const Left(ServerFailure(errorMessage: 'Invalid input'));
      }
      return const Left(ServerFailure(errorMessage: 'Server acting weird'));
    } catch (e) {
      _logger.e(e);
      return const Left(ServerFailure(errorMessage: 'Server acting weird'));
    }
  }
}
