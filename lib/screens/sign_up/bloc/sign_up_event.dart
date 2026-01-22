/*
 * Najaz Mobile App
 * Sign-Up Event
 * 
 * This file defines events for the Sign-Up BLoC.
 * Follows Bagisto's sign-up event pattern, tailored for Najaz.
 */

import 'package:equatable/equatable.dart';

/// Base event class for sign-up
abstract class SignUpBaseEvent extends Equatable {
  const SignUpBaseEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch sign-up data
class FetchSignUpEvent extends SignUpBaseEvent {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender; // MALE or FEMALE
  final String? phone;
  final String? nationalId;
  final String? dateOfBirth; // ISO format string (YYYY-MM-DD)
  final int? citizenTypeId;
  final String? password;
  final String? passwordConfirmation;
  final bool? agreement;

  const FetchSignUpEvent({
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.phone,
    this.nationalId,
    this.dateOfBirth,
    this.citizenTypeId,
    this.password,
    this.passwordConfirmation,
    this.agreement,
  });

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        gender,
        phone,
        nationalId,
        dateOfBirth,
        citizenTypeId,
        password,
        passwordConfirmation,
        agreement,
      ];
}

