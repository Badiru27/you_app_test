import 'package:you_app/src/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.email,
    required super.userName,
    required super.displayName,
    required super.gender,
    required super.birthday,
    required super.horoscope,
    required super.zodiac,
    required super.height,
    required super.weight,
    required super.image,
    required super.interest,
  });
}
