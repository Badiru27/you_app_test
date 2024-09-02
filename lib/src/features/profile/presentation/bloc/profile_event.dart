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
    this.displayName,
    this.gender,
    this.birthday,
    this.height,
    this.weight,
    this.imageUrl,
  });
}

class SaveInterestEvent extends ProfileEvent {
  final List<String>? interest;

  SaveInterestEvent({this.interest});
}

class LogOutEvent extends ProfileEvent {}
