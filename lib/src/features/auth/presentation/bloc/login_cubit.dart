import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/src/features/auth/domain/usecases/login_usecase.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void toggleObscureText() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<bool> login() async {
    emit(state.copyWith(isLoading: true, error: ''));
    final email = state.email.contains('@') ? state.email : null;
    final userName = state.email.contains('@') ? null : state.email;
    final result = await loginUseCase(
        LoginParam(userName: userName, password: state.password, email: email));
    emit(state.copyWith(isLoading: false));
    return result.fold((l) {
      emit(state.copyWith(error: l.message));
      return false;
    }, (r) => true);
  }
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final String error;
  final bool showPassword;

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        isLoading: false,
        error: '',
        showPassword: false,
      );

  const LoginState({
    required this.email,
    required this.password,
    required this.isLoading,
    required this.error,
    required this.showPassword,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
    bool? showPassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object?> get props => [email, password, isLoading, error, showPassword];
}
