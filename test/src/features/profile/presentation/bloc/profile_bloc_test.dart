import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_app/src/core/usescase/usecases.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:you_app/src/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:you_app/src/features/profile/data/model/user_model.dart';
import 'package:you_app/src/features/profile/domain/entities/profile.dart';
import 'package:you_app/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_state.dart';

class MockGetSavedProfileUseCase extends Mock
    implements GetSavedProfileUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockProfileLocalDataSource extends Mock
    implements ProfileLocalDataSource {}

const mockProfileModel = Profile(
    imageUrl: 'image.com',
    birthday: '2024-09-02',
    displayName: 'display',
    gender: 'MALE',
    height: 10,
    weight: 50,
    horoscope: 'horoscope',
    interest: ['me', 'you'],
    zodiac: 'zodiac',
    user: UserModel(email: 'me@email.com', userName: 'my', id: 'id'));
void main() {
  late ProfileBloc profileBloc;
  late MockGetSavedProfileUseCase getProfileUseCase;
  late MockUpdateProfileUseCase updateProfileUseCase;
  late MockAuthLocalDataSource localDataSource;
  late MockProfileLocalDataSource profileLocalDataSource;

  setUp(() {
    getProfileUseCase = MockGetSavedProfileUseCase();
    updateProfileUseCase = MockUpdateProfileUseCase();
    localDataSource = MockAuthLocalDataSource();
    profileLocalDataSource = MockProfileLocalDataSource();

    profileBloc = ProfileBloc(
      getProfileUseCase: getProfileUseCase,
      updateProfileUseCase: updateProfileUseCase,
      localDataSource: localDataSource,
      profileLocalDataSource: profileLocalDataSource,
    );
  });

  setUpAll(() {
    registerFallbackValue(UpdateProfileParams());
  });

  tearDown(() {
    profileBloc.close();
  });

  blocTest<ProfileBloc, ProfileState>(
    'emits [isEditingAbout: true] when EditAboutEvent is added',
    build: () => profileBloc,
    act: (bloc) => bloc.add(EditAboutEvent()),
    expect: () => [
      ProfileState.initial().copyWith(isEditingAbout: true),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits state with profile when GetUserEvent is added and profile is fetched successfully',
    build: () {
      when(() => getProfileUseCase(NoParams())).thenAnswer(
          (_) async => const Right(mockProfileModel)); // mock success response
      return profileBloc;
    },
    act: (bloc) => bloc.add(GetUserEvent()),
    expect: () => [
      ProfileState.initial().copyWith(profile: mockProfileModel),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits loading states and updated profile when SaveAboutEvent is added',
    build: () {
      when(() => updateProfileUseCase(any())).thenAnswer((_) async => Right(
          mockProfileModel.copyWith(
              displayName: 'Updated Name'))); // mock success response
      return profileBloc;
    },
    act: (bloc) => bloc.add(SaveAboutEvent(displayName: 'Updated Name')),
    expect: () => [
      ProfileState.initial().copyWith(isLoading: true, isEditingAbout: false),
      ProfileState.initial().copyWith(
        isLoading: true,
        profile: mockProfileModel.copyWith(displayName: 'Updated Name'),
      ),
      ProfileState.initial().copyWith(
        isLoading: false,
        profile: mockProfileModel.copyWith(displayName: 'Updated Name'),
      ),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits loading states and updated interests when SaveInterestEvent is added',
    build: () {
      when(() => updateProfileUseCase(any())).thenAnswer((_) async => Right(
          mockProfileModel
              .copyWith(interest: ['Interest1']))); // mock success response
      return profileBloc;
    },
    act: (bloc) => bloc.add(SaveInterestEvent(interest: ['Interest1'])),
    expect: () => [
      ProfileState.initial().copyWith(isLoading: true, isEditingAbout: false),
      ProfileState.initial().copyWith(
        isLoading: true,
        profile: mockProfileModel.copyWith(interest: ['Interest1']),
      ),
      ProfileState.initial().copyWith(
        isLoading: false,
        profile: mockProfileModel.copyWith(interest: ['Interest1']),
      ),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits initial state and clears data on LogOutEvent',
    build: () {
      when(() => localDataSource.deleteToken()).thenAnswer((_) async {});
      when(() => profileLocalDataSource.deleteProfile())
          .thenAnswer((_) async {});
      return profileBloc;
    },
    act: (bloc) => bloc.add(LogOutEvent()),
    expect: () => [
      ProfileState.initial(),
    ],
    verify: (_) {
      verify(() => localDataSource.deleteToken()).called(1);
      verify(() => profileLocalDataSource.deleteProfile()).called(1);
    },
  );
}
