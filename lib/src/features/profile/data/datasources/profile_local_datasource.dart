import 'dart:convert';

import 'package:you_app/src/features/profile/data/model/profile_model.dart';
import 'package:you_app/src/service/local_storage_service.dart';

const profileKey = 'profile';
const token = 'token';

abstract class ProfileLocalDataSource {
  Future<void> saveProfile(ProfileModel profile);
  Future<ProfileModel?> getProfile();
  Future<void> deleteProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  const ProfileLocalDataSourceImpl(this.localStorageService);
  final LocalStorageService localStorageService;

  @override
  Future<ProfileModel?> getProfile() async {
    final profile = await localStorageService.getFromDisk(profileKey) as String?;
    return profile != null ?ProfileModel.fromJson(jsonDecode(profile)) : null;
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    await localStorageService.saveToDisk(profileKey, jsonEncode(profile.toJson()));
  }

  @override
  Future<void> deleteProfile() async {
    await localStorageService.removeFromDisk(profileKey);
  }

}