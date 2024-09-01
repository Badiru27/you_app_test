import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:you_app/src/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/features/profile/domain/repository/profile_repository.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  final _logger = Logger();

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final result = await remoteDataSource.getProfile();
      localDataSource.saveProfile(result);
      return Right(result);
    } catch (e) {
      _logger.e(e);
      return const Left(ServerFailure(errorMessage: 'Server acting weird'));
    }
  }

  @override
  Future<Either<Failure, Profile>> getSavedProfile() async {
    try {
      final result = await localDataSource.getProfile();
      if (result != null) {
        getProfile();
        return Right(result);
      }

      return getProfile();
    } catch (e) {
      _logger.e(e);
      return const Left(ServerFailure(errorMessage: 'Server acting weird'));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(
      UpdateProfileParams params) async {
    try {
      final result = await remoteDataSource.updateProfile(params);
      localDataSource.saveProfile(result);
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return const Left(ServerFailure(
            errorMessage: 'you are not allow to update this profile'));
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
