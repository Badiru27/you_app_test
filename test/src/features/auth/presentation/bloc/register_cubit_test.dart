import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_app/src/core/error/failures.dart';
import 'package:you_app/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:you_app/src/features/auth/presentation/bloc/register_cubit.dart';

// Create a mock class for the RegisterUseCase
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

const mockRegisterParam = RegisterParam(
    userName: 'testuser', password: 'password123', email: 'test@example.com');

void main() {
  late RegistrationCubit registrationCubit;
  late MockRegisterUseCase mockRegisterUseCase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    registrationCubit = RegistrationCubit(registerUseCase: mockRegisterUseCase);
  });

  tearDown(() {
    registrationCubit.close();
  });

  setUpAll(() {
    registerFallbackValue(mockRegisterParam);
  });

  test('initial state should be RegisterState.initial()', () {
    expect(registrationCubit.state, equals(RegisterState.initial()));
  });

  blocTest<RegistrationCubit, RegisterState>(
    'emits state with updated email when emailChanged is called',
    build: () => registrationCubit,
    act: (cubit) => cubit.emailChanged('test@example.com'),
    expect: () => [
      RegisterState.initial().copyWith(email: 'test@example.com'),
    ],
  );

  blocTest<RegistrationCubit, RegisterState>(
    'emits state with updated userName when userNameChanged is called',
    build: () => registrationCubit,
    act: (cubit) => cubit.userNameChanged('testuser'),
    expect: () => [
      RegisterState.initial().copyWith(userName: 'testuser'),
    ],
  );

  blocTest<RegistrationCubit, RegisterState>(
    'emits state with updated password when passwordChanged is called',
    build: () => registrationCubit,
    act: (cubit) => cubit.passwordChanged('password123'),
    expect: () => [
      RegisterState.initial().copyWith(password: 'password123'),
    ],
  );

  blocTest<RegistrationCubit, RegisterState>(
    'emits state with updated confirmPassword when confirmPasswordChanged is called',
    build: () => registrationCubit,
    act: (cubit) => cubit.confirmPasswordChanged('password123'),
    expect: () => [
      RegisterState.initial().copyWith(confirmPassword: 'password123'),
    ],
  );

  blocTest<RegistrationCubit, RegisterState>(
    'emits state with toggled showPassword when toggleObscureText is called',
    build: () => registrationCubit,
    act: (cubit) => cubit.toggleObscureText(),
    expect: () => [
      RegisterState.initial().copyWith(showPassword: true),
    ],
  );

  blocTest<RegistrationCubit, RegisterState>(
    'emits loading state and success state when registration is successful',
    build: () {
      when(() => mockRegisterUseCase(any()))
          .thenAnswer((_) async => const Right('token'));
      return registrationCubit;
    },
    act: (cubit) async => cubit.register(),
    expect: () => [
      RegisterState.initial().copyWith(isLoading: true, error: ''),
      RegisterState.initial().copyWith(isLoading: false, error: ''),
    ],
  );

  blocTest<RegistrationCubit, RegisterState>(
    'emits loading state and error state when registration fails',
    build: () {
      when(() => mockRegisterUseCase(any())).thenAnswer((_) async =>
          const Left(ServerFailure(errorMessage: 'Registration failed')));
      return registrationCubit;
    },
    act: (cubit) async => cubit.register(),
    expect: () => [
      RegisterState.initial().copyWith(isLoading: true, error: ''),
      RegisterState.initial().copyWith(isLoading: false, error: ''),
      RegisterState.initial()
          .copyWith(isLoading: false, error: 'Registration failed'),
    ],
  );
}
