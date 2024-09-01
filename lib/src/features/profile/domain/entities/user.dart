import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String userName;

  const User({required this.email, required this.userName, required this.id});

  String get myUserName => '@$userName';

  @override
  List<Object?> get props => [email, userName, id];
}
