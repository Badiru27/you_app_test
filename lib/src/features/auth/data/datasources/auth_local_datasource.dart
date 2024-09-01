
import 'package:you_app/src/service/local_storage_service.dart';

const tokenKey = 'token';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this.localStorageService);
  final LocalStorageService localStorageService;

  @override
  Future<String?> getToken() async {
    return await localStorageService.getFromDisk(tokenKey) as String?;
  }

  @override
  Future<void> saveToken(String token) async {
    await localStorageService.saveToDisk(tokenKey, token);
  }

  @override
  Future<void> deleteToken() async {
    await localStorageService.removeFromDisk(tokenKey);
  }
}
