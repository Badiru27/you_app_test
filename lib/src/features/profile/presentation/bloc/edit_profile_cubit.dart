import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState.initial());

  void displayNameChanged(String value) {
    emit(state.copyWith(displayName: value));
  }

  void genderChanged(String? value) {
    emit(state.copyWith(gender: value));
  }

  void birthdayChanged(String value) {
    final zodiac = getZodiacSign(DateFormat('yyyy-MM-dd').parse(value));
    final horoscope = getHoroscopeAnimal(zodiac);

    emit(state.copyWith(
      birthday: value,
      zodiac: zodiac,
      horoscope: horoscope,
    ));
  }

  void heightChanged(String value) {
    emit(state.copyWith(height: int.parse(value)));
  }

  void weightChanged(String value) {
    emit(state.copyWith(weight: int.parse(value)));
  }

  void imageChanged(File value) {
    emit(state.copyWith(image: value));
  }

  void reInitialize() {
    emit(EditProfileState.initial());
  }

  String getZodiacSign(DateTime birthDate) {
    int month = birthDate.month;
    int day = birthDate.day;

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return "Aries";
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return "Taurus";
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return "Gemini";
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return "Cancer";
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return "Leo";
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return "Virgo";
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return "Libra";
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return "Scorpio";
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return "Sagittarius";
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      return "Capricorn";
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return "Aquarius";
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return "Pisces";
    }

    return "Unknown";
  }

  String getHoroscopeAnimal(String zodiacSign) {
    switch (zodiacSign) {
      case "Aries":
        return "Ram";
      case "Taurus":
        return "Bull";
      case "Gemini":
        return "Monkey";
      case "Cancer":
        return "Crab";
      case "Leo":
        return "Lion";
      case "Virgo":
        return "Pig";
      case "Libra":
        return "Swan";
      case "Scorpio":
        return "Scorpion";
      case "Sagittarius":
        return "Horse";
      case "Capricorn":
        return "Goat";
      case "Aquarius":
        return "Dolphin";
      case "Pisces":
        return "Fish";
      default:
        return "Unknown";
    }
  }
}

class EditProfileState extends Equatable {
  final String? displayName;
  final String? gender;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final File? image;

  factory EditProfileState.initial() => const EditProfileState(
        displayName: null,
        gender: null,
        birthday: null,
        horoscope: null,
        zodiac: null,
        height: null,
        weight: null,
        image: null,
      );

  const EditProfileState({
    required this.displayName,
    required this.gender,
    required this.birthday,
    required this.horoscope,
    required this.zodiac,
    required this.height,
    required this.weight,
    required this.image,
  });

  EditProfileState copyWith({
    String? displayName,
    String? gender,
    String? birthday,
    String? horoscope,
    String? zodiac,
    int? height,
    int? weight,
    File? image,
  }) {
    return EditProfileState(
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      horoscope: horoscope ?? this.horoscope,
      zodiac: zodiac ?? this.zodiac,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      image: image ?? this.image,
    );
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
        image,
      ];
}
