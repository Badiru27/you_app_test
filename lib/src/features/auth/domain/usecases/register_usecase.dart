import 'package:dartz/dartz.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/core/usescase/usecases.dart';
import 'package:you_app/src/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase implements UseCase<String, RegisterParam> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(RegisterParam param) async {
    return await repository.register(param);
  }
}

class RegisterParam {
  final String email;
  final String userName;
  final String password;

  const RegisterParam(
      {required this.userName, required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email, 'userName': userName, 'password': password};
  }
}
