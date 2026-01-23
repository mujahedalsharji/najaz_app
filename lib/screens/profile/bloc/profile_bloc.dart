/*
 * Najaz Mobile App
 * Profile BLoC
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/profile_models/my_profile_model.dart';
import '../../../utils/shared_preferences/shared_preference_helper.dart';
import 'profile_event.dart';
import 'profile_repository.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(const ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<RefreshProfileEvent>(_onRefreshProfile);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    try {
      final results = await Future.wait([
        repository.fetchMyProfile(),
        repository.fetchUnreadNotificationsCount(),
      ]);

      final profile = results[0] as MyProfileModel?;
      final unreadCount = results[1] as int?;

      if (profile != null && profile.isSuccess) {
        final isVerified =
            profile.isVerified == true ||
            profile.identityVerificationStatus == true;
        appStoragePref.setAccountVerified(isVerified);
        emit(ProfileLoaded(
          profile: profile,
          unreadNotificationsCount: unreadCount,
        ));
      } else {
        emit(ProfileError(
          message:
              profile?.message ??
              profile?.graphqlErrors ??
              'Failed to fetch profile',
        ));
      }
    } catch (error) {
      emit(ProfileError(message: error.toString()));
    }
  }

  Future<void> _onRefreshProfile(
    RefreshProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    int? existingUnreadCount;
    if (currentState is ProfileLoaded) {
      existingUnreadCount = currentState.unreadNotificationsCount;
      emit(currentState.copyWith());
    }

    try {
      final profile = await repository.fetchMyProfile();
      final unreadCount = await repository.fetchUnreadNotificationsCount();

      if (profile != null && profile.isSuccess) {
        final isVerified =
            profile.isVerified == true ||
            profile.identityVerificationStatus == true;
        appStoragePref.setAccountVerified(isVerified);
        emit(ProfileLoaded(
          profile: profile,
          unreadNotificationsCount: unreadCount ?? existingUnreadCount,
        ));
      } else {
        emit(ProfileError(
          message:
              profile?.message ??
              profile?.graphqlErrors ??
              'Failed to refresh profile',
        ));
      }
    } catch (error) {
      emit(ProfileError(message: error.toString()));
    }
  }
}

