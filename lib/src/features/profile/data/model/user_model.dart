import 'package:you_app/src/features/profile/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.email, required super.userName, required super.id});

  static const _email = 'email';
  static const _userName = 'userName';
  static const _id = 'id';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json[_email] ?? '',
      userName: json[_userName] ?? '',
      id: json[_id] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _email: email,
      _userName: userName,
      _id: id,
    };
  }
}
