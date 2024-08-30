import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class User extends Equatable {
  final String email;
  final String userName;
  final String displayName;
  final String gender;
  final String birthday;
  final String horoscope;
  final String zodiac;
  final int height;
  final int weight;
  final String image;
  final List<String> interest;

  const User({
    required this.email,
    required this.userName,
    required this.displayName,
    required this.gender,
    required this.birthday,
    required this.horoscope,
    required this.zodiac,
    required this.height,
    required this.weight,
    required this.image,
    required this.interest,
  });

  User copyWith({
    String? email,
    String? userName,
    String? displayName,
    String? gender,
    String? birthday,
    String? horoscope,
    String? zodiac,
    int? height,
    int? weight,
    String? image,
    List<String>? interest,
  }) {
    return User(
      email: email ?? this.email,
      userName: userName ?? this.userName,
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      horoscope: horoscope ?? this.horoscope,
      zodiac: zodiac ?? this.zodiac,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      image: image ?? this.image,
      interest: interest ?? this.interest,
    );
  }

  bool get aboutIsEmpty =>
      birthday.isEmpty &&
      horoscope.isEmpty &&
      zodiac.isEmpty &&
      height == 0 &&
      weight == 0;

  String get myUserName => '@$userName';

  String get age {
    if (birthday.isEmpty) return '';

    try {
      DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthday);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return '$age';
    } catch (e) {
      return '';
    }
  }

  @override
  List<Object?> get props => [
        email,
        userName,
        displayName,
        gender,
        birthday,
        horoscope,
        zodiac,
        height,
        weight,
        image,
        interest,
      ];
}
