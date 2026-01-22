/*
 * Najaz Mobile App
 * Input Field Validators
 * 
 * This file contains validation mixins for input fields.
 * Follows Bagisto's input field validators pattern, tailored for Najaz.
 */

/// Mixin for phone number validation
///
/// Provides method to validate phone numbers.
/// Supports international and local phone number formats.
mixin PhoneNumberValidator {
  /// Validates a phone number
  ///
  /// Supports:
  /// - International format with + prefix
  /// - Local format (10-12 digits)
  ///
  /// Examples:
  /// - Valid: "+966501234567", "0501234567", "501234567"
  /// - Invalid: "123", "abc", ""
  bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;

    // Remove spaces, dashes, and parentheses
    String cleanedPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check for international format (+ followed by country code and number)
    // Or local format (10-12 digits)
    return RegExp(r'^(\+?[0-9]{1,4})?[0-9]{8,12}$').hasMatch(cleanedPhone);
  }
}

/// Mixin for email validation
///
/// Provides method to validate email addresses using standard email regex pattern.
mixin EmailValidator {
  /// Validates an email address
  ///
  /// Uses standard email regex pattern to validate:
  /// - Email format (user@domain.com)
  /// - Domain with valid TLD
  ///
  /// Examples:
  /// - Valid: "user@example.com", "test.email@domain.co.uk"
  /// - Invalid: "invalid.email", "@domain.com", "user@"
  bool isValidEmail(String email) {
    if (email.isEmpty) return false;

    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }
}

/// Mixin for password validation
///
/// Provides methods to validate password strength and format.
mixin PasswordValidator {
  /// Validates password minimum length
  ///
  /// Checks if password meets minimum length requirement (default: 6 characters).
  /// Can be customized with [minLength] parameter.
  bool isValidPasswordLength(String password, {int minLength = 6}) {
    return password.length >= minLength;
  }

  /// Validates password strength
  ///
  /// Checks if password contains:
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one digit
  /// - Minimum length of 6 characters
  ///
  /// Returns true if all conditions are met.
  bool isStrongPassword(String password, {int minLength = 6}) {
    if (password.length < minLength) return false;

    bool hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    bool hasLower = RegExp(r'[a-z]').hasMatch(password);
    bool hasDigit = RegExp(r'[0-9]').hasMatch(password);

    return hasUpper && hasLower && hasDigit;
  }
}

/// Mixin for National ID (رقم الهوية) validation
///
/// Provides method to validate Saudi National ID numbers.
/// Saudi National ID is exactly 10 digits.
mixin NationalIdValidator {
  /// Validates a Saudi National ID (رقم الهوية)
  ///
  /// Saudi National ID format:
  /// - Exactly 10 digits
  /// - No letters or special characters
  ///
  /// Examples:
  /// - Valid: "1234567890", "1234567891"
  /// - Invalid: "123", "123456789", "abc1234567"
  bool isValidNationalId(String nationalId) {
    if (nationalId.isEmpty) return false;

    // Remove spaces, dashes, and other formatting characters
    String cleanedId = nationalId.replaceAll(RegExp(r'[\s\-]'), '');

    // Saudi National ID is exactly 11 digits
    return RegExp(r'^[0-9]{11}$').hasMatch(cleanedId);
  }
}

/// Mixin for OTP validation
///
/// Provides method to validate OTP (One-Time Password) codes.
// mixin OtpValidator {
//   /// Validates an OTP code
//   ///
//   /// Checks if OTP contains only digits and matches the expected length
//   /// (default: 6 digits, as per AppConstants).
//   bool isValidOtp(String otp, {int length = 6}) {
//     if (otp.isEmpty) return false;
//
//     // OTP should contain only digits and match the expected length
//     return RegExp(r'^[0-9]{' + length.toString() + r'}$').hasMatch(otp);
//   }
// }
