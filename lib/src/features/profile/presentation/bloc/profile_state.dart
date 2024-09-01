import 'package:equatable/equatable.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';

class ProfileState extends Equatable {
  final Profile? profile;
  final bool isEditingAbout;

  factory ProfileState.initial() =>
      const ProfileState(profile: null, isEditingAbout: false);

  const ProfileState({
    required this.profile,
    required this.isEditingAbout,
  });

  ProfileState copyWith({
    Profile? user,
    bool? isEditingAbout,
  }) =>
      ProfileState(
        profile: user ?? this.profile,
        isEditingAbout: isEditingAbout ?? this.isEditingAbout,
      );
  @override
  List<Object?> get props => [profile, isEditingAbout];
}
