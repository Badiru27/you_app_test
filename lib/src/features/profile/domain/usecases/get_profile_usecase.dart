import 'package:dartz/dartz.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/core/usescase/usecases.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase implements UseCase<Profile, NoParams> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams param) async {
    return await repository.getProfile();
  }
}
class GetSavedProfileUseCase implements UseCase<Profile, NoParams> {
  final ProfileRepository repository;

  GetSavedProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams param) async {
    return await repository.getSavedProfile();
  }
}
