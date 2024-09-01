import 'package:dartz/dartz.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/core/usescase/usecases.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<Profile, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Profile>> call(UpdateProfileParams param) async {
    return await repository.updateProfile(param);
  }
}

class UpdateProfileParams {
  final String? displayName;
  final String? gender;
  final String? birthday;
  final int? height;
  final int? weight;
  final String? image;
  final List<String>? interest;

  UpdateProfileParams(
      {this.displayName,
      this.gender,
      this.birthday,
      this.height,
      this.weight,
      this.image,
      this.interest});

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'gender': gender,
      'birthday': birthday,
      'height': height,
      'weight': weight,
      'image': image,
      'interest': interest,
    };
  }
}
