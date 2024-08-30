abstract class ProfileEvent {}

class GetUserEvent extends ProfileEvent {}

class EditAboutEvent extends ProfileEvent{}

class SaveAboutEvent extends ProfileEvent {
  final String? displayName;
  final String? gender;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;

  SaveAboutEvent(
      {required this.displayName,
      required this.gender,
      required this.birthday,
      required this.horoscope,
      required this.zodiac,
      required this.height,
      required this.weight});
}

class SaveInterestEvent extends ProfileEvent {
  final List<String>? interest;

  SaveInterestEvent({required this.interest});
}
