/*
 * Najaz Mobile App
 * Account Verification State
 * 
 * This file defines states for the Account Verification BLoC.
 * Follows Bagisto's state pattern, tailored for Najaz.
 */

import 'dart:io';

import 'package:equatable/equatable.dart';

/// Base state class for account verification
abstract class AccountVerificationBaseState extends Equatable {
  const AccountVerificationBaseState();

  @override
  List<Object?> get props => [];
}

/// Enum for verification status
enum VerificationStatus { success, fail }

/// Initial verification state
class VerificationInitialState extends AccountVerificationBaseState {
  const VerificationInitialState();
}

/// Loading state
class VerificationLoadingState extends AccountVerificationBaseState {
  const VerificationLoadingState();
}

/// Step state with current step and data
class VerificationStepState extends AccountVerificationBaseState {
  /// Current step (1-4)
  final int currentStep;

  /// Verification ID (when editing existing verification)
  final String? verificationId;

  /// Personal information data (Step 1)
  final String? fullName;
  final String? dateOfBirth;
  final String? nationalId;
  final String? gender;

  /// ID card images (Step 2) - local files
  final File? frontImage;
  final File? backImage;

  /// ID card image URLs (Step 2) - existing uploaded images
  final String? frontImageUrl;
  final String? backImageUrl;

  /// Video path (Step 3) - local file path
  final String? videoPath;

  /// Video URL (Step 3) - existing uploaded video
  final String? videoUrl;

  /// Whether step is valid
  final bool isStepValid;

  /// Whether user confirmed using this data for verification (Step 1 checkbox)
  final bool dataConfirmed;

  const VerificationStepState({
    this.currentStep = 1,
    this.verificationId,
    this.fullName,
    this.dateOfBirth,
    this.nationalId,
    this.gender,
    this.frontImage,
    this.backImage,
    this.frontImageUrl,
    this.backImageUrl,
    this.videoPath,
    this.videoUrl,
    this.isStepValid = false,
    this.dataConfirmed = false,
  });

  /// Create copy with updated values
  VerificationStepState copyWith({
    int? currentStep,
    String? verificationId,
    String? fullName,
    String? dateOfBirth,
    String? nationalId,
    String? gender,
    File? frontImage,
    File? backImage,
    String? frontImageUrl,
    String? backImageUrl,
    String? videoPath,
    String? videoUrl,
    bool? isStepValid,
    bool? dataConfirmed,
  }) {
    return VerificationStepState(
      currentStep: currentStep ?? this.currentStep,
      verificationId: verificationId ?? this.verificationId,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationalId: nationalId ?? this.nationalId,
      gender: gender ?? this.gender,
      frontImage: frontImage ?? this.frontImage,
      backImage: backImage ?? this.backImage,
      frontImageUrl: frontImageUrl ?? this.frontImageUrl,
      backImageUrl: backImageUrl ?? this.backImageUrl,
      videoPath: videoPath ?? this.videoPath,
      videoUrl: videoUrl ?? this.videoUrl,
      isStepValid: isStepValid ?? this.isStepValid,
      dataConfirmed: dataConfirmed ?? this.dataConfirmed,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        verificationId,
        fullName,
        dateOfBirth,
        nationalId,
        gender,
        frontImage,
        backImage,
        frontImageUrl,
        backImageUrl,
        videoPath,
        videoUrl,
        isStepValid,
        dataConfirmed,
      ];
}

/// Verification success state
class VerificationSuccessState extends AccountVerificationBaseState {
  final String? message;

  const VerificationSuccessState({this.message});

  @override
  List<Object?> get props => [message];
}

/// Verification status loaded state (existing verification found)
class VerificationStatusLoadedState extends AccountVerificationBaseState {
  final Map<String, dynamic>? verificationData;

  const VerificationStatusLoadedState({this.verificationData});

  @override
  List<Object?> get props => [verificationData];
}

/// Verification error state
class VerificationErrorState extends AccountVerificationBaseState {
  final String error;

  const VerificationErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

