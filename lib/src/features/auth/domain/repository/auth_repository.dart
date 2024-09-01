import 'package:dartz/dartz.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:you_app/src/features/auth/domain/usecases/register_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(LoginParam param);
  Future<Either<Failure, String>> register(RegisterParam param);
}
