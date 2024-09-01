import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/src/core/usescase/usecases.dart';
import 'package:you_app/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:you_app/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetSavedProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(ProfileState.initial()) {
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
      GetUserEvent event, Emitter<ProfileState> emit) async {
    final result = await getProfileUseCase(NoParams());

    result.fold((l) => null, (r) {
      emit(state.copyWith(profile: r));
    });
  }

  FutureOr<void> _onSaveAboutEvent(
      SaveAboutEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      error: '',
      isLoading: true,
      isEditingAbout: false,
    ));
    final result = await updateProfileUseCase(UpdateProfileParams(
      displayName: event.displayName,
      gender: event.gender?.toUpperCase(),
      birthday: event.birthday,
      height: event.height,
      weight: event.weight,
    ));
    result.fold((l) {
      emit(state.copyWith(error: l.message));
    }, (r) {
      emit(state.copyWith(profile: r.copyWith(user: state.profile?.user)));
    });

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  FutureOr<void> _onSaveInterestEvent(
      SaveInterestEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      error: '',
      isLoading: true,
      isEditingAbout: false,
    ));
    final result = await updateProfileUseCase(
        UpdateProfileParams(interest: event.interest));

    result.fold((l) {
      emit(state.copyWith(error: l.message));
    }, (r) {
      emit(state.copyWith(profile: r.copyWith(user: state.profile?.user)));
    });

    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
