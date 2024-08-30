import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/src/features/auth/domain/entities/user.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<EditAboutEvent>(_onEditAbout);
    on<GetUserEvent>(_onGetUseEvent);
    on<SaveAboutEvent>(_onSaveAboutEvent);
    on<SaveInterestEvent>(_onSaveInterestEvent);
  }

  FutureOr<void> _onEditAbout(
      EditAboutEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isEditingAbout: true));
  }

  FutureOr<void> _onGetUseEvent(
      GetUserEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
        user: const User(
            email: 'badiru@gmail.com',
            userName: 'Badiru',
            displayName: '',
            gender: 'Male',
            birthday: '',
            horoscope: 'Virgo',
            zodiac: 'Pig',
            height: 0,
            weight: 0,
            image: '',
            interest: [])));
  }

  FutureOr<void> _onSaveAboutEvent(
      SaveAboutEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
        isEditingAbout: false,
        user: state.user?.copyWith(
            displayName: event.displayName,
            gender: event.gender,
            birthday: event.birthday,
            horoscope: event.horoscope,
            zodiac: event.zodiac,
            height: event.height,
            weight: event.weight)));
  }

  FutureOr<void> _onSaveInterestEvent(
      SaveInterestEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: state.user?.copyWith(interest: event.interest)));
  }
}
