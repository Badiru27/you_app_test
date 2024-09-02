import 'dart:io';

import 'package:bloc_test/bloc_test.dart'; // replace with your actual import path
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:you_app/src/features/profile/presentation/bloc/edit_profile_cubit.dart';
import 'package:you_app/src/service/cloudinary_upload_service.dart';
import 'package:you_app/src/service/file_picker_service.dart';

class MockFilePickerService extends Mock implements FilePickerService {}

class MockCloudinaryUploadService extends Mock
    implements CloudinaryUploadService {}

void main() {
  late EditProfileCubit cubit;
  late MockFilePickerService filePickerService;
  late MockCloudinaryUploadService cloudinaryUploadService;

  setUp(() {
    filePickerService = MockFilePickerService();
    cloudinaryUploadService = MockCloudinaryUploadService();
    cubit = EditProfileCubit(filePickerService, cloudinaryUploadService);
  });

  setUpAll(() {
    registerFallbackValue(File('path/to/file.jpg'));
  });

  tearDown(() {
    cubit.close();
  });

  group('EditProfileCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, EditProfileState.initial());
    });

    blocTest<EditProfileCubit, EditProfileState>(
      'emits state with updated displayName when displayNameChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.displayNameChanged('New Name'),
      expect: () =>
          [EditProfileState.initial().copyWith(displayName: 'New Name')],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits state with updated gender when genderChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.genderChanged('Male'),
      expect: () => [EditProfileState.initial().copyWith(gender: 'Male')],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits state with updated birthday, zodiac, and horoscope when birthdayChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.birthdayChanged('2000-08-15'),
      expect: () => [
        EditProfileState.initial().copyWith(
          birthday: '2000-08-15',
          zodiac: 'Leo',
          horoscope: 'Lion',
        )
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits state with updated height when heightChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.heightChanged('180'),
      expect: () => [EditProfileState.initial().copyWith(height: 180)],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits state with updated weight when weightChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.weightChanged('75'),
      expect: () => [EditProfileState.initial().copyWith(weight: 75)],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits state with image loading and image URL when pickImage is called',
      build: () {
        when(() => filePickerService.pickImage()).thenAnswer(
          (_) async => XFile('path/to/file.jpg'),
        );
        when(() => cloudinaryUploadService.uploadImage(any(), any()))
            .thenAnswer((_) async => 'https://example.com/image.jpg');
        return cubit;
      },
      act: (cubit) => cubit.pickImage(),
      expect: () => [
        predicate<EditProfileState>((state) =>
            state.file?.path == 'path/to/file.jpg' &&
            state.imageLoading == true &&
            state.imageUrl == null),
        predicate<EditProfileState>((state) =>
            state.file?.path == 'path/to/file.jpg' &&
            state.imageLoading == false &&
            state.imageUrl == 'https://example.com/image.jpg'),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'reInitializes state when reInitialize is called',
      build: () => cubit,
      act: (cubit) => cubit.reInitialize(),
      expect: () => [EditProfileState.initial()],
    );
  });
}
