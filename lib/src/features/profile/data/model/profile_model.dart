import 'package:you_app/src/features/profile/data/model/user_model.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.user,
    required super.displayName,
    required super.gender,
    required super.birthday,
    required super.horoscope,
    required super.zodiac,
    required super.height,
    required super.weight,
    required super.imageUrl,
    required super.interest,
  });

  static const _user = 'user';
  static const _displayName = 'displayName';
  static const _gender = 'gender';
  static const _birthday = 'birthday';
  static const _horoscope = 'horoscope';
  static const _zodiac = 'zodiac';
  static const _height = 'height';
  static const _weight = 'weight';
  static const _image = 'imageUrl';
  static const _interest = 'interest';

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: UserModel.fromJson(json[_user]??{}),
      displayName: json[_displayName] ?? '',
      gender: json[_gender] ?? '',
      birthday: json[_birthday] ?? '',
      horoscope: json[_horoscope] ?? '',
      zodiac: json[_zodiac] ?? '',
      height: json[_height] ?? 0,
      weight: json[_weight] ?? 0,
      imageUrl: json[_image] ?? '',
      interest: List<String>.from(json[_interest] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _user: user.toJson(),
      _displayName: displayName,
      _gender: gender,
      _birthday: birthday,
      _horoscope: horoscope,
      _zodiac: zodiac,
      _height: height,
      _weight: weight,
      _image: imageUrl,
      _interest: interest,
    };
  }
}
