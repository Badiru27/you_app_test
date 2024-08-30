import 'package:equatable/equatable.dart';
import 'package:you_app/src/features/auth/domain/entities/user.dart';

class ProfileState extends Equatable {
  final User? user;
  final bool isEditingAbout;

  factory ProfileState.initial() =>
      const ProfileState(user: null, isEditingAbout: false);

  const ProfileState({
    required this.user,
    required this.isEditingAbout,
  });

  ProfileState copyWith({
    User? user,
    bool? isEditingAbout,
  }) =>
      ProfileState(
        user: user ?? this.user,
        isEditingAbout: isEditingAbout ?? this.isEditingAbout,
      );
  @override
  List<Object?> get props => [user, isEditingAbout];
}
