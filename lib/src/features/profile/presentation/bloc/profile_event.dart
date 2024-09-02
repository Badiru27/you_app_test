abstract class ProfileEvent {}

class GetUserEvent extends ProfileEvent {}

class EditAboutEvent extends ProfileEvent {}

class SaveAboutEvent extends ProfileEvent {
  final String? displayName;
  final String? gender;
  final String? birthday;
  final int? height;
  final int? weight;
  final String? imageUrl;

  SaveAboutEvent({
    required this.displayName,
    required this.gender,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.imageUrl,
  });
}

class SaveInterestEvent extends ProfileEvent {
  final List<String>? interest;

  SaveInterestEvent({required this.interest});
}

class LogOutEvent extends ProfileEvent {}
