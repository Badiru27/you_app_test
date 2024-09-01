import 'package:dartz/dartz.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, Profile>> getSavedProfile();
  Future<Either<Failure, Profile>> updateProfile(UpdateProfileParams params);
}
