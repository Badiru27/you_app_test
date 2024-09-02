import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/core/usescase/usecases.dart';
import 'package:you_app/src/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<String, LoginParam> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParam param) async {
    return await repository.login(param);
  }
}

class LoginParam extends Equatable {
  final String? email;
  final String? userName;
  final String password;

  const LoginParam(
      {required this.userName, required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email, 'userName': userName, 'password': password};
  }

  @override
  List<Object?> get props => [email, userName, password];
}
