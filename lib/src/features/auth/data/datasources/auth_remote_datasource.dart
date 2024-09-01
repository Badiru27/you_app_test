import 'package:you_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:you_app/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:you_app/src/service/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<String> logIn(LoginParam data);
  Future<String> register(RegisterParam data);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> logIn(LoginParam data) async {
    final result = await apiService.post(url: '/login', body: data.toJson());
    return result['token'] as String;
  }

  @override
  Future<String> register(RegisterParam data) async {
    final result = await apiService.post(url: '/register', body: data.toJson());
    return result['token'] as String;
  }
}
