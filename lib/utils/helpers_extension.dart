/*
 * Najaz Mobile App
 * Helper Extensions
 * 
 * This file contains common extension methods for Flutter types.
 * Follows Bagisto's extension pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension on Color for hexadecimal color conversion
///
/// Provides methods to convert between Color objects and hex strings.
extension HexColor on Color {
  /// Creates a Color from a hexadecimal color string
  ///
  /// String can be in formats:
  /// - "aabbcc" (RGB, alpha defaults to FF)
  /// - "ffaabbcc" (ARGB)
  /// - "#aabbcc" (with optional leading "#")
  ///
  /// Examples:
  /// - Color.fromHex("FF5722") → Red color
  /// - Color.fromHex("#FF5722") → Red color (with #)
  /// - Color.fromHex("80FF5722") → Red color with 50% opacity
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    // If only 6 or 7 characters (with #), add alpha channel (FF = fully opaque)
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Converts a Color to hexadecimal string
  ///
  /// Returns hex string with optional leading "#" (default: true).
  /// Format: "#AARRGGBB" (8 characters including alpha)
  ///
  /// Example:
  /// - Colors.red.toHex() → "#FFFF0000"
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }

  /// Converts a Color to CSS-style hexadecimal string
  ///
  /// Returns hex string in CSS format: "#RRGGBBAA"
  ///
  /// Example:
  /// - Colors.red.toCssHex() → "#FF0000FF"
  // String toCssHex() {
  //   final r = red.toRadixString(16).padLeft(2, '0');
  //   final g = green.toRadixString(16).padLeft(2, '0');
  //   final b = blue.toRadixString(16).padLeft(2, '0');
  //   final a = alpha.toRadixString(16).padLeft(2, '0');
  //   return '#$r$g$b$a';
  // }
}

/// Extension on String for common string operations
///
/// Provides helper methods for string manipulation and validation.
extension StringHelpers on String {
  /// Checks if string is empty or only whitespace
  bool get isBlank => trim().isEmpty;

  /// Checks if string is not empty and not only whitespace
  bool get isNotBlank => trim().isNotEmpty;

  /// Capitalizes the first letter of the string
  ///
  /// Example: "hello" → "Hello"
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes the first letter of each word
  ///
  /// Example: "hello world" → "Hello World"
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Splits full name into first name, middle name, and last name
  ///
  /// Returns a Map with keys: 'firstName', 'middleName', 'lastName'
  /// - If name has 1 word: firstName = word, middleName = null, lastName = null
  /// - If name has 2 words: firstName = first word, middleName = null, lastName = second word
  /// - If name has 3+ words: firstName = first word, middleName = middle words, lastName = last word
  ///
  /// Example:
  /// - "أحمد محمد علي" → {firstName: "أحمد", middleName: "محمد", lastName: "علي"}
  /// - "أحمد علي" → {firstName: "أحمد", middleName: null, lastName: "علي"}
  /// - "أحمد" → {firstName: "أحمد", middleName: null, lastName: null}
  Map<String, String?> splitFullName() {
    final trimmedName = trim();
    if (trimmedName.isEmpty) {
      return {'firstName': null, 'middleName': null, 'lastName': null};
    }

    final nameParts =
        trimmedName.split(' ').where((part) => part.isNotEmpty).toList();

    if (nameParts.isEmpty) {
      return {'firstName': null, 'middleName': null, 'lastName': null};
    }

    if (nameParts.length == 1) {
      return {
        'firstName': nameParts[0],
        'middleName': null,
        'lastName': null,
      };
    } else if (nameParts.length == 2) {
      return {
        'firstName': nameParts[0],
        'middleName': null,
        'lastName': nameParts[1],
      };
    } else {
      final firstName = nameParts[0];
      final lastName = nameParts[nameParts.length - 1];
      final middleName = nameParts.sublist(1, nameParts.length - 1).join(' ');

      return {
        'firstName': firstName,
        'middleName': middleName.isEmpty ? null : middleName,
        'lastName': lastName,
      };
    }
  }

  /// Truncates string to specified length with optional ellipsis
  ///
  /// [maxLength]: Maximum length of the string
  /// [ellipsis]: String to append if truncated (default: "...")
  ///
  /// Example:
  /// - "Hello World".truncate(5) → "Hello..."
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}

/// Extension on BuildContext for common context operations
///
/// Provides helper methods to access theme, media query, and localization.
extension ContextHelpers on BuildContext {
  /// Gets the current theme
  ThemeData get theme => Theme.of(this);

  /// Gets the current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Gets the current color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Gets the current media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Gets screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Gets screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Checks if the device is in landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Checks if the device is in portrait orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
}

/// Extension on DateTime for date formatting
///
/// Provides methods to format dates in various formats.
extension DateTimeHelpers on DateTime {
  /// Formats date as "yyyy-MM-dd"
  ///
  /// Example: 2024-12-19
  String toDateString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Formats date and time as "yyyy-MM-dd HH:mm:ss"
  ///
  /// Example: 2024-12-19 14:30:00
  String toDateTimeString() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  /// Formats date in a readable format
  ///
  /// Example: "December 19, 2024"
  String toReadableDate() {
    return DateFormat('MMMM dd, yyyy').format(this);
  }

  /// Formats time as "HH:mm"
  ///
  /// Example: 14:30
  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }
}

/// Helper function to get value from dynamic data using key
///
/// Safely extracts a value from a Map using the provided key.
/// Returns null if data is not a Map or key doesn't exist.
///
/// Example:
/// - getValueFromDynamic({'name': 'John'}, 'name') → 'John'
/// - getValueFromDynamic({'name': 'John'}, 'age') → null
dynamic getValueFromDynamic(dynamic data, String key) {
  if (data == null) return null;
  if (data is Map && data.containsKey(key)) {
    return data[key];
  }
  return null;
}
