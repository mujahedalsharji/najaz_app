/*
 * Najaz Mobile App
 * Profile State
 */

import 'package:equatable/equatable.dart';

import '../../../models/profile_models/my_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final MyProfileModel? profile;
  final int? unreadNotificationsCount;

  const ProfileLoaded({this.profile, this.unreadNotificationsCount});

  ProfileLoaded copyWith({
    MyProfileModel? profile,
    int? unreadNotificationsCount,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
    );
  }

  @override
  List<Object?> get props => [profile, unreadNotificationsCount];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

