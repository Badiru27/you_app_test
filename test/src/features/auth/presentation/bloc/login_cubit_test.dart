import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:you_app/src/features/auth/presentation/bloc/login_cubit.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    loginCubit.close();
  });

  setUpAll(() {
    registerFallbackValue(
        const LoginParam(userName: null, password: 'password', email: 'email'));
  });

  test('initial state should be LoginState.initial()', () {
    expect(loginCubit.state, equals(LoginState.initial()));
  });

  blocTest<LoginCubit, LoginState>(
    'emits state with updated email when emailChanged is called',
    build: () => loginCubit,
    act: (cubit) => cubit.emailChanged('test@example.com'),
    expect: () => [
      LoginState.initial().copyWith(email: 'test@example.com'),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits state with updated password when passwordChanged is called',
    build: () => loginCubit,
    act: (cubit) => cubit.passwordChanged('password123'),
    expect: () => [
      LoginState.initial().copyWith(password: 'password123'),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits state with toggled showPassword when toggleObscureText is called',
    build: () => loginCubit,
    act: (cubit) => cubit.toggleObscureText(),
    expect: () => [
      LoginState.initial().copyWith(showPassword: true),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits loading state and success state when login is successful',
    build: () {
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Right('token'));
      return loginCubit;
    },
    act: (cubit) async => cubit.login(),
    expect: () => [
      LoginState.initial().copyWith(isLoading: true, error: ''),
      LoginState.initial().copyWith(isLoading: false),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits loading state and error state when login fails',
    build: () {
      when(() => mockLoginUseCase(any())).thenAnswer((_) async =>
          const Left(ServerFailure(errorMessage: 'Something went wrong')));
      return loginCubit;
    },
    act: (cubit) async => cubit.login(),
    expect: () => [
      LoginState.initial().copyWith(isLoading: true, error: ''),
      LoginState.initial().copyWith(isLoading: false, error: ''),
      LoginState.initial().copyWith(isLoading: false, error: 'Something went wrong'),
    ],
  );
}
