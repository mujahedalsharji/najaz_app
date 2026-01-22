/*
 * Najaz Mobile App
 * Account Verification BLoC
 * 
 * This file implements the business logic for the Account Verification screen.
 * Follows Bagisto's BLoC pattern, tailored for Najaz.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/server_configuration.dart';
import '../../../utils/shared_preferences/shared_preference_helper.dart';
import 'account_verification_event.dart';
import 'account_verification_repository.dart';
import 'account_verification_state.dart';

/// Account Verification BLoC
///
/// Handles account verification business logic and state management
class AccountVerificationBloc
    extends Bloc<AccountVerificationBaseEvent, AccountVerificationBaseState> {
  AccountVerificationRepository? repository;

  AccountVerificationBloc({this.repository})
      : super(const VerificationInitialState()) {
    on<VerificationInitialEvent>(_mapVerificationInitialEventToState);
    on<CheckVerificationStatusEvent>(_mapCheckVerificationStatusEventToState);
    on<NavigateToStepEvent>(_mapNavigateToStepEventToState);
    on<UpdatePersonalInfoEvent>(_mapUpdatePersonalInfoEventToState);
    on<UploadIdCardEvent>(_mapUploadIdCardEventToState);
    on<SaveVideoPathEvent>(_mapSaveVideoPathEventToState);
    on<SubmitVerificationEvent>(_mapSubmitVerificationEventToState);
    on<ResumeVerificationEvent>(_mapResumeVerificationEventToState);
    on<SaveVerificationProgressEvent>(_mapSaveVerificationProgressEventToState);
    on<ClearVerificationDataEvent>(_mapClearVerificationDataEventToState);
    on<StartEditVerificationEvent>(_mapStartEditVerificationEventToState);
    on<ConfirmDataUsageEvent>(_mapConfirmDataUsageEventToState);
    on<UpdateProfileEvent>(_mapUpdateProfileEventToState);
  }

  /// Maps VerificationInitialEvent to state
  Future<void> _mapVerificationInitialEventToState(
    VerificationInitialEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    // First, check if user has existing verification
    emit(const VerificationLoadingState());

    final statusResult = await repository?.checkVerificationStatus();

    if (statusResult != null && statusResult['hasVerification'] == true) {
      // User has existing verification, show status
      emit(VerificationStatusLoadedState(
        verificationData: statusResult,
      ));
      return;
    }

    // No existing verification, load saved progress if available
    final savedData = appStoragePref.getAccountVerificationData();
    if (savedData != null) {
      emit(VerificationStepState(
        currentStep: savedData['currentStep'] ?? 1,
        fullName: savedData['fullName'],
        dateOfBirth: savedData['dateOfBirth'],
        nationalId: savedData['nationalId'],
        // Note: File paths cannot be restored directly
        // User will need to re-upload images
      ));
    } else {
      emit(const VerificationStepState(currentStep: 1));
    }
  }

  /// Maps CheckVerificationStatusEvent to state
  Future<void> _mapCheckVerificationStatusEventToState(
    CheckVerificationStatusEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    emit(const VerificationLoadingState());

    final statusResult = await repository?.checkVerificationStatus();

    if (statusResult != null && statusResult['hasVerification'] == true) {
      emit(VerificationStatusLoadedState(
        verificationData: statusResult,
      ));
    } else {
      // No existing verification, show step form
      final savedData = appStoragePref.getAccountVerificationData();
      if (savedData != null) {
        emit(VerificationStepState(
          currentStep: savedData['currentStep'] ?? 1,
          fullName: savedData['fullName'],
          dateOfBirth: savedData['dateOfBirth'],
          nationalId: savedData['nationalId'],
        ));
      } else {
        emit(const VerificationStepState(currentStep: 1));
      }
    }
  }

  /// Maps NavigateToStepEvent to state
  Future<void> _mapNavigateToStepEventToState(
    NavigateToStepEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is VerificationStepState) {
      emit(currentState.copyWith(currentStep: event.step));
    }
  }

  /// Maps UpdatePersonalInfoEvent to state
  Future<void> _mapUpdatePersonalInfoEventToState(
    UpdatePersonalInfoEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is VerificationStepState) {
      // Validate step 1 data - must have all data AND confirmation checkbox checked
      final hasAllData = (event.fullName?.isNotEmpty ?? false) &&
          (event.dateOfBirth?.isNotEmpty ?? false) &&
          (event.nationalId?.isNotEmpty ?? false) &&
          (event.gender?.isNotEmpty ?? false);
      final isStepValid = hasAllData && currentState.dataConfirmed;

      emit(currentState.copyWith(
        fullName: event.fullName,
        dateOfBirth: event.dateOfBirth,
        nationalId: event.nationalId,
        gender: event.gender,
        isStepValid: isStepValid,
      ));
    }
  }

  /// Maps ConfirmDataUsageEvent to state
  Future<void> _mapConfirmDataUsageEventToState(
    ConfirmDataUsageEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is VerificationStepState) {
      // Re-validate step with new confirmation status
      final hasAllData = (currentState.fullName?.isNotEmpty ?? false) &&
          (currentState.dateOfBirth?.isNotEmpty ?? false) &&
          (currentState.nationalId?.isNotEmpty ?? false) &&
          (currentState.gender?.isNotEmpty ?? false);
      final isStepValid = hasAllData && event.confirmed;

      emit(currentState.copyWith(
        dataConfirmed: event.confirmed,
        isStepValid: isStepValid,
      ));
    }
  }

  /// Maps UpdateProfileEvent to state
  Future<void> _mapUpdateProfileEventToState(
    UpdateProfileEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! VerificationStepState) {
      return;
    }

    emit(const VerificationLoadingState());

    try {
      final updateResult = await repository?.updateProfile(
        firstName: event.firstName,
        middleName: event.middleName,
        lastName: event.lastName,
        dateOfBirth: event.dateOfBirth,
        nationalId: event.nationalId,
        gender: event.gender,
      );

      // Check if update was successful
      final isSuccess = updateResult != null &&
          (updateResult['success'] == true || updateResult['status'] == true);

      if (isSuccess) {
        // Update state with new profile data
        final updatedFullName =
            '${event.firstName ?? ''} ${event.middleName ?? ''} ${event.lastName ?? ''}'
                .trim();

        emit(currentState.copyWith(
          fullName:
              updatedFullName.isNotEmpty ? updatedFullName : currentState.fullName,
          dateOfBirth: event.dateOfBirth ?? currentState.dateOfBirth,
          nationalId: event.nationalId ?? currentState.nationalId,
          gender: event.gender ?? currentState.gender,
        ));
      } else {
        emit(VerificationErrorState(
          error: updateResult?['message'] as String? ??
              updateResult?['graphqlErrors'] as String? ??
              'فشل تحديث الملف الشخصي',
        ));
      }
    } catch (e) {
      emit(VerificationErrorState(error: e.toString()));
    }
  }

  /// Maps UploadIdCardEvent to state
  Future<void> _mapUploadIdCardEventToState(
    UploadIdCardEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is VerificationStepState) {
      // Validate step 2 data - check both files and URLs
      final frontValid = event.frontImage != null ||
          (currentState.frontImageUrl != null && !event.clearFrontImageUrl);
      final backValid = event.backImage != null ||
          (currentState.backImageUrl != null && !event.clearBackImageUrl);
      final isStepValid = frontValid && backValid;

      emit(currentState.copyWith(
        frontImage: event.frontImage,
        backImage: event.backImage,
        frontImageUrl:
            event.clearFrontImageUrl ? null : currentState.frontImageUrl,
        backImageUrl: event.clearBackImageUrl ? null : currentState.backImageUrl,
        isStepValid: isStepValid,
      ));
    }
  }

  /// Maps SaveVideoPathEvent to state
  Future<void> _mapSaveVideoPathEventToState(
    SaveVideoPathEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is VerificationStepState) {
      // Validate step 3 data
      final isStepValid = event.videoPath != null && event.videoPath!.isNotEmpty;

      emit(currentState.copyWith(
        videoPath: event.videoPath,
        isStepValid: isStepValid,
      ));
    }
  }

  /// Maps SubmitVerificationEvent to state
  Future<void> _mapSubmitVerificationEventToState(
    SubmitVerificationEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! VerificationStepState) {
      emit(const VerificationErrorState(
        error: 'Invalid state for submission',
      ));
      return;
    }

    // Validate all required data
    if (currentState.fullName == null ||
        currentState.dateOfBirth == null ||
        currentState.nationalId == null ||
        currentState.frontImage == null ||
        currentState.backImage == null) {
      emit(const VerificationErrorState(
        error: 'Please complete all required steps',
      ));
      return;
    }

    emit(const VerificationLoadingState());

    try {
      // Prepare video file if available
      File? faceVideoFile;
      if (currentState.videoPath != null) {
        faceVideoFile = File(currentState.videoPath!);
        if (!await faceVideoFile.exists()) {
          faceVideoFile = null;
        }
      }

      // Submit verification with file uploads
      final submitResult = await repository?.submitIdentityVerification(
        frontDocument: currentState.frontImage!,
        backDocument: currentState.backImage!,
        faceVideo: faceVideoFile,
      );

      if (submitResult != null && submitResult['success'] == true) {
        // Mark account as verified in preferences
        appStoragePref.setAccountVerified(true);
        appStoragePref.setAccountVerificationData(null); // Clear saved data

        emit(VerificationSuccessState(
          message: submitResult['message'] as String?,
        ));
      } else {
        emit(VerificationErrorState(
          error: submitResult?['message'] as String? ??
              'Failed to submit verification',
        ));
      }
    } catch (e) {
      emit(VerificationErrorState(error: e.toString()));
    }
  }

  /// Maps ResumeVerificationEvent to state
  Future<void> _mapResumeVerificationEventToState(
    ResumeVerificationEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    // Load saved progress
    final savedData = appStoragePref.getAccountVerificationData();
    if (savedData != null) {
      emit(VerificationStepState(
        currentStep: savedData['currentStep'] ?? 1,
        fullName: savedData['fullName'],
        dateOfBirth: savedData['dateOfBirth'],
        nationalId: savedData['nationalId'],
      ));
    } else {
      emit(const VerificationStepState(currentStep: 1));
    }
  }

  /// Maps SaveVerificationProgressEvent to state
  Future<void> _mapSaveVerificationProgressEventToState(
    SaveVerificationProgressEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is VerificationStepState) {
      // Save progress to SharedPreferences
      final progressData = {
        'currentStep': currentState.currentStep,
        'fullName': currentState.fullName,
        'dateOfBirth': currentState.dateOfBirth,
        'nationalId': currentState.nationalId,
        // Note: File paths are not saved as they may become invalid
      };

      appStoragePref.setAccountVerificationData(progressData);
    }
  }

  /// Maps ClearVerificationDataEvent to state
  Future<void> _mapClearVerificationDataEventToState(
    ClearVerificationDataEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    appStoragePref.setAccountVerificationData(null);
    emit(const VerificationStepState(currentStep: 1));
  }

  /// Maps StartEditVerificationEvent to state
  Future<void> _mapStartEditVerificationEventToState(
    StartEditVerificationEvent event,
    Emitter<AccountVerificationBaseState> emit,
  ) async {
    // Extract data from current verification if available
    final currentData = event.currentData;
    final citizen = currentData?['citizen'] as Map<String, dynamic>?;

    /// Helper function to build full image URL
    String? _buildImageUrl(String? imagePath) {
      if (imagePath == null || imagePath.isEmpty) {
        return null;
      }

      // If already a full URL, return as-is
      if (imagePath.startsWith('http://') ||
          imagePath.startsWith('https://')) {
        return imagePath;
      }

      // Remove leading slash if present
      final cleanPath =
          imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

      // Build full URL: baseDomain/public/storage/imagePath
      return '$baseDomain/public/storage/$cleanPath';
    }

    // Extract image URLs from documents
    String? frontImageUrl;
    String? backImageUrl;
    final documents = currentData?['documents'];
    if (documents != null) {
      if (documents is List && documents.isNotEmpty) {
        // If documents is a list, take first two items
        for (var i = 0; i < documents.length && i < 2; i++) {
          final doc = documents[i];
          String? url;
          if (doc is String) {
            url = doc;
          } else if (doc is Map) {
            // Try different possible keys
            url =
                doc['url'] as String? ?? doc['path'] as String? ?? doc['file'] as String?;
          }

          if (url != null && url.isNotEmpty) {
            final fullUrl = _buildImageUrl(url);
            if (i == 0) {
              frontImageUrl = fullUrl;
            } else if (i == 1) {
              backImageUrl = fullUrl;
            }
          }
        }
      } else if (documents is String) {
        // If documents is a JSON string, try to parse it
        try {
          // If it's a simple string URL, use it as front image
          if (documents.isNotEmpty &&
              (documents.startsWith('http') || documents.startsWith('/'))) {
            frontImageUrl = _buildImageUrl(documents);
          } else {
            // Try to parse as JSON
            final parsed = json.decode(documents);
            if (parsed is List && parsed.isNotEmpty) {
              frontImageUrl = _buildImageUrl(parsed[0]?.toString());
              if (parsed.length > 1) {
                backImageUrl = _buildImageUrl(parsed[1]?.toString());
              }
            }
          }
        } catch (e) {
          // If parsing fails, try using the string as-is if it looks like a URL
          if (documents.isNotEmpty && documents.length > 10) {
            frontImageUrl = _buildImageUrl(documents);
          }
        }
      }
    }

    // Extract video URL
    final videoUrlRaw = currentData?['face_video'] as String?;
    final videoUrl = _buildImageUrl(videoUrlRaw);

    // Start from step 1 with existing data if available
    emit(VerificationStepState(
      currentStep: 1,
      verificationId: event.verificationId,
      fullName: citizen?['firstName'] != null
          ? '${citizen?['firstName'] ?? ''} ${citizen?['middleName'] ?? ''} ${citizen?['lastName'] ?? ''}'
              .trim()
          : null,
      dateOfBirth: citizen?['dateOfBirth'] as String?,
      nationalId: citizen?['nationalId'] as String?,
      gender: citizen?['gender'] as String?,
      frontImageUrl: frontImageUrl,
      backImageUrl: backImageUrl,
      videoUrl: videoUrl,
      isStepValid: false, // User needs to review/update data
    ));
  }
}

