/*
 * Najaz Mobile App
 * Form Validator Helper
 * 
 * This file provides a centralized form validation helper for consistent
 * validation across all forms in the app.
 * Follows Bagisto's validation pattern, tailored for Najaz.
 */

import '../application_localization.dart';
import '../constants/string_constants.dart';
import '../input_field_validators.dart';

/// Form Validator Helper
///
/// Provides static methods for common form field validations.
/// All validation methods return error message string or null if valid.
///
/// Usage:
/// ```dart
/// validator: (value) => FormValidatorHelper.validateRequired(value, 'Field Name')
/// ```
class FormValidatorHelper {
  /// Validates a required field
  ///
  /// Returns error message if field is empty, null if valid.
  ///
  /// [value]: Field value to validate
  /// [fieldName]: Name of the field (for error message)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validateRequired(value, 'First Name')
  /// ```
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.fieldRequired.localized();
      //'${StringConstants.pleaseFillLabel.localized()} $fieldName';
    }
    return null;
  }

  /// Validates an email field
  ///
  /// Returns error message if email is invalid, null if valid.
  ///
  /// [value]: Email value to validate
  /// [isRequired]: Whether the field is required (default: true)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validateEmail(value)
  /// ```
  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) {
        return StringConstants.fieldRequired.localized();
        //StringConstants.pleaseFillLabel.localized() +
        //' ' + StringConstants.email.localized();
      }
      return null;
    }

    final emailValidator = _EmailValidatorMixin();
    if (!emailValidator.isValidEmail(value)) {
      return StringConstants.validEmailLabel.localized();
    }
    return null;
  }

  /// Validates a phone number field
  ///
  /// Returns error message if phone is invalid, null if valid.
  ///
  /// [value]: Phone value to validate
  /// [isRequired]: Whether the field is required (default: true)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validatePhone(value)
  /// ```
  static String? validatePhone(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) {
        return StringConstants.fieldRequired.localized();
      }
      return null;
    }

    final phoneValidator = _PhoneValidatorMixin();
    if (!phoneValidator.isValidPhone(value)) {
      return StringConstants.validPhoneNumberLabel.localized();
    }
    return null;
  }

  /// Validates a password field
  ///
  /// Returns error message if password is invalid, null if valid.
  ///
  /// [value]: Password value to validate
  /// [minLength]: Minimum password length (default: 6)
  /// [isRequired]: Whether the field is required (default: true)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validatePassword(value)
  /// ```
  static String? validatePassword(
    String? value, {
    int minLength = 6,
    bool isRequired = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) {
        return StringConstants.fieldRequired.localized();
        //'${StringConstants.pleaseFillLabel.localized()} ${StringConstants.passwordLabel.localized()}';
      }
      return null;
    }

    final passwordValidator = _PasswordValidatorMixin();
    if (!passwordValidator.isValidPasswordLength(value, minLength: minLength)) {
      return '${StringConstants.passwordTooShort.localized()} (${StringConstants.minLengthLabel.localized()}: $minLength)';
    }
    return null;
  }

  /// Validates password confirmation
  ///
  /// Returns error message if passwords don't match, null if valid.
  ///
  /// [value]: Confirm password value
  /// [password]: Original password value
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validatePasswordConfirmation(value, passwordController.text)
  /// ```
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.fieldRequired.localized();
    }

    if (value != password) {
      return StringConstants.passwordsDoNotMatch.localized();
    }
    return null;
  }

  /// Validates a field with custom minimum length
  ///
  /// Returns error message if field is too short, null if valid.
  ///
  /// [value]: Field value to validate
  /// [minLength]: Minimum length required
  /// [fieldName]: Name of the field (for error message)
  /// [isRequired]: Whether the field is required (default: true)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validateMinLength(value, 3, 'Name')
  /// ```
  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName, {
    bool isRequired = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) {
        return '${StringConstants.pleaseFillLabel.localized()} $fieldName';
      }
      return null;
    }

    if (value.trim().length < minLength) {
      return '$fieldName ${StringConstants.minLengthLabel.localized()} $minLength';
    }
    return null;
  }

  /// Validates a field with custom maximum length
  ///
  /// Returns error message if field is too long, null if valid.
  ///
  /// [value]: Field value to validate
  /// [maxLength]: Maximum length allowed
  /// [fieldName]: Name of the field (for error message)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validateMaxLength(value, 100, 'Description')
  /// ```
  static String? validateMaxLength(
    String? value,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return null; // Empty is handled by required validator
    }

    if (value.trim().length > maxLength) {
      return '$fieldName ${StringConstants.maxLengthLabel.localized()} $maxLength';
    }
    return null;
  }

  /// Validates email OR National ID (رقم الهوية)
  ///
  /// Accepts either:
  /// - Email address (user@domain.com)
  /// - Saudi National ID (10 digits)
  ///
  /// Returns error message if invalid, null if valid.
  ///
  /// [value]: Email or National ID value to validate
  /// [isRequired]: Whether the field is required (default: true)
  /// [fieldName]: Name of the field for error messages
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validateEmailOrNationalId(value)
  /// ```
  static String? validateEmailOrNationalId(
    String? value, {
    bool isRequired = true,
    String? fieldName,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) {
        final field =
            fieldName ?? StringConstants.emailOrNationalIdLabel.localized();
        return '${StringConstants.pleaseFillLabel.localized()} $field';
      }
      return null;
    }

    final emailValidator = _EmailValidatorMixin();
    final nationalIdValidator = _NationalIdValidatorMixin();

    // Check if it's a valid email OR valid national ID
    bool isEmail = emailValidator.isValidEmail(value.trim());
    bool isNationalId = nationalIdValidator.isValidNationalId(value.trim());

    if (isEmail || isNationalId) {
      return null; // Valid (either email or national ID)
    }

    // Neither email nor national ID format
    return StringConstants.invalidEmailOrNationalId.localized();
  }

  /// Detects the type of input (email or nationalId)
  ///
  /// Returns:
  /// - 'email' if the input is a valid email
  /// - 'nationalId' if the input is a valid national ID
  /// - null if the input is neither
  ///
  /// [value]: The input value to detect
  ///
  /// Example:
  /// ```dart
  /// final type = FormValidatorHelper.detectInputType(userInput);
  /// if (type == 'email') {
  ///   // Handle email login
  /// } else if (type == 'nationalId') {
  ///   // Handle nationalId login
  /// }
  /// ```
  static String? detectInputType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final emailValidator = _EmailValidatorMixin();
    final nationalIdValidator = _NationalIdValidatorMixin();

    // Check if it's a valid email
    if (emailValidator.isValidEmail(value.trim())) {
      return 'email';
    }

    // Check if it's a valid national ID
    if (nationalIdValidator.isValidNationalId(value.trim())) {
      return 'nationalId';
    }

    // Neither email nor national ID
    return null;
  }

  /// Validates a National ID (رقم الهوية) field
  ///
  /// Returns error message if National ID is invalid, null if valid.
  ///
  /// [value]: National ID value to validate
  /// [isRequired]: Whether the field is required (default: true)
  ///
  /// Example:
  /// ```dart
  /// validator: (value) => FormValidatorHelper.validateNationalId(value)
  /// ```
  static String? validateNationalId(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) {
        return StringConstants.fieldRequired.localized();
      }
      return null;
    }

    final nationalIdValidator = _NationalIdValidatorMixin();
    if (!nationalIdValidator.isValidNationalId(value.trim())) {
      return StringConstants.invalidNationalId.localized();
    }
    return null;
  }
}

/// Internal mixin implementations for validators
class _EmailValidatorMixin with EmailValidator {}

class _PhoneValidatorMixin with PhoneNumberValidator {}

class _PasswordValidatorMixin with PasswordValidator {}

class _NationalIdValidatorMixin with NationalIdValidator {}
