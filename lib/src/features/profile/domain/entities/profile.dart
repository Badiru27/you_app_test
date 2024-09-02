import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:you_app/src/features/profile/data/model/user_model.dart';

class Profile extends Equatable {
  final String displayName;
  final String gender;
  final String birthday;
  final String horoscope;
  final String zodiac;
  final int height;
  final int weight;
  final String imageUrl;
  final List<String> interest;
  final UserModel user;

  const Profile({
    required this.displayName,
    required this.gender,
    required this.birthday,
    required this.horoscope,
    required this.zodiac,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.interest,
    required this.user,
  });

  Profile copyWith({
    String? email,
    String? userName,
    String? displayName,
    String? gender,
    String? birthday,
    String? horoscope,
    String? zodiac,
    int? height,
    int? weight,
    String? imageUrl,
    List<String>? interest,
    UserModel? user,
  }) {
    return Profile(
        displayName: displayName ?? this.displayName,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        horoscope: horoscope ?? this.horoscope,
        zodiac: zodiac ?? this.zodiac,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        imageUrl: imageUrl ?? this.imageUrl,
        interest: interest ?? this.interest,
        user: user ?? this.user);
  }

  bool get aboutIsEmpty =>
      birthday.isEmpty &&
      horoscope.isEmpty &&
      zodiac.isEmpty &&
      height == 0 &&
      weight == 0;

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
        displayName,
        gender,
        birthday,
        horoscope,
        zodiac,
        height,
        weight,
        imageUrl,
        interest,
        user
      ];
}
