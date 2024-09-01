import 'package:you_app/src/features/profile/data/model/profile_model.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:you_app/src/service/api_service.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(UpdateProfileParams params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl(this.apiService);
  @override
  Future<ProfileModel> getProfile() async {
    final result = await apiService.get(url: '/getProfile');

    return ProfileModel.fromJson(result['data'] as Map<String, dynamic>);
  }

  @override
  Future<ProfileModel> updateProfile(UpdateProfileParams params) async {
    final result =
        await apiService.put(url: '/updateProfile', body: params.toJson());

    return ProfileModel.fromJson(result['data'] as Map<String, dynamic>);
  }
}
