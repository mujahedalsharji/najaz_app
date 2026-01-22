/*
 * Najaz Mobile App
 * Account Verification Event
 * 
 * This file defines events for the Account Verification BLoC.
 * Follows Bagisto's event pattern, tailored for Najaz.
 */

import 'dart:io';

import 'package:equatable/equatable.dart';

/// Base event class for account verification
abstract class AccountVerificationBaseEvent extends Equatable {
  const AccountVerificationBaseEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize verification flow
class VerificationInitialEvent extends AccountVerificationBaseEvent {
  const VerificationInitialEvent();
}

/// Event to check existing verification status
class CheckVerificationStatusEvent extends AccountVerificationBaseEvent {
  const CheckVerificationStatusEvent();
}

/// Event to navigate to a specific step
class NavigateToStepEvent extends AccountVerificationBaseEvent {
  final int step;

  const NavigateToStepEvent({required this.step});

  @override
  List<Object?> get props => [step];
}

/// Event to update personal information (Step 1)
class UpdatePersonalInfoEvent extends AccountVerificationBaseEvent {
  final String? fullName;
  final String? dateOfBirth;
  final String? nationalId;
  final String? gender;
  final bool shouldUpdateProfile;

  const UpdatePersonalInfoEvent({
    this.fullName,
    this.dateOfBirth,
    this.nationalId,
    this.gender,
    this.shouldUpdateProfile = false,
  });

  @override
  List<Object?> get props =>
      [fullName, dateOfBirth, nationalId, gender, shouldUpdateProfile];
}

/// Event to confirm data usage for verification (Step 1 checkbox)
class ConfirmDataUsageEvent extends AccountVerificationBaseEvent {
  final bool confirmed;

  const ConfirmDataUsageEvent({required this.confirmed});

  @override
  List<Object?> get props => [confirmed];
}

/// Event to update profile with new data
class UpdateProfileEvent extends AccountVerificationBaseEvent {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? dateOfBirth;
  final String? nationalId;
  final String? gender;

  const UpdateProfileEvent({
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.nationalId,
    this.gender,
  });

  @override
  List<Object?> get props =>
      [firstName, middleName, lastName, dateOfBirth, nationalId, gender];
}

/// Event to upload ID card images (Step 2)
class UploadIdCardEvent extends AccountVerificationBaseEvent {
  final File? frontImage;
  final File? backImage;
  final bool clearFrontImageUrl;
  final bool clearBackImageUrl;

  const UploadIdCardEvent({
    this.frontImage,
    this.backImage,
    this.clearFrontImageUrl = false,
    this.clearBackImageUrl = false,
  });

  @override
  List<Object?> get props =>
      [frontImage, backImage, clearFrontImageUrl, clearBackImageUrl];
}

/// Event to start video verification (Step 3)
class StartVideoVerificationEvent extends AccountVerificationBaseEvent {
  const StartVideoVerificationEvent();
}

/// Event to save video file path
class SaveVideoPathEvent extends AccountVerificationBaseEvent {
  final String? videoPath;

  const SaveVideoPathEvent({this.videoPath});

  @override
  List<Object?> get props => [videoPath];
}

/// Event to submit verification (Step 4)
class SubmitVerificationEvent extends AccountVerificationBaseEvent {
  const SubmitVerificationEvent();
}

/// Event to resume verification from saved state
class ResumeVerificationEvent extends AccountVerificationBaseEvent {
  const ResumeVerificationEvent();
}

/// Event to save verification progress
class SaveVerificationProgressEvent extends AccountVerificationBaseEvent {
  const SaveVerificationProgressEvent();
}

/// Event to clear verification data
class ClearVerificationDataEvent extends AccountVerificationBaseEvent {
  const ClearVerificationDataEvent();
}

/// Event to start editing existing verification
class StartEditVerificationEvent extends AccountVerificationBaseEvent {
  final String verificationId;
  final Map<String, dynamic>? currentData;

  const StartEditVerificationEvent({
    required this.verificationId,
    this.currentData,
  });

  @override
  List<Object?> get props => [verificationId, currentData];
}

