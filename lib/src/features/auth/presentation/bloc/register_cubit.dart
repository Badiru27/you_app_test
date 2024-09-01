import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/src/features/auth/domain/usecases/register_usecase.dart';

class RegistrationCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  RegistrationCubit({required this.registerUseCase})
      : super(RegisterState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void userNameChanged(String value) {
    emit(state.copyWith(userName: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  void toggleObscureText() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<bool> register() async {
    emit(state.copyWith(isLoading: true, error: ''));
    final result = await registerUseCase(RegisterParam(
        userName: state.userName,
        password: state.password,
        email: state.email));
    emit(state.copyWith(isLoading: false));

    return result.fold((l) {
      emit(state.copyWith(error: l.message));
      return false;
    }, (r) => true);
  }
}

class RegisterState extends Equatable {
  final String email;
  final String userName;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String error;
  final bool showPassword;

  factory RegisterState.initial() => const RegisterState(
        email: '',
        userName: '',
        password: '',
        confirmPassword: '',
        isLoading: false,
        error: '',
        showPassword: false,
      );

  const RegisterState({
    required this.email,
    required this.password,
    required this.isLoading,
    required this.error,
    required this.showPassword,
    required this.userName,
    required this.confirmPassword,
  });

  RegisterState copyWith(
      {String? email,
      String? password,
      bool? isLoading,
      String? error,
      bool? showPassword,
      String? userName,
      String? confirmPassword}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showPassword: showPassword ?? this.showPassword,
      userName: userName ?? this.userName,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isLoading,
        error,
        showPassword,
        userName,
        confirmPassword
      ];
}
