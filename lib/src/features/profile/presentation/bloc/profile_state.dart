import 'package:equatable/equatable.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';

class ProfileState extends Equatable {
  final Profile? profile;
  final bool isEditingAbout;
  final String error;
  final bool isLoading;

  factory ProfileState.initial() => const ProfileState(
      profile: null, isEditingAbout: false, error: '', isLoading: false);

  const ProfileState({
    required this.profile,
    required this.isEditingAbout,
    required this.error,
    required this.isLoading,
  });

  ProfileState copyWith({
    Profile? profile,
    bool? isEditingAbout,
    String? error,
    bool? isLoading,
  }) =>
      ProfileState(
          profile: profile ?? this.profile,
          isEditingAbout: isEditingAbout ?? this.isEditingAbout,
          error: error ?? this.error,
          isLoading: isLoading ?? this.isLoading);
  @override
  List<Object?> get props => [profile, isEditingAbout, error, isLoading];
}
