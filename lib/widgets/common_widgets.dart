/*
 * Najaz Mobile App
 * Common Widgets
 * 
 * This file contains reusable widget builders and helper widgets.
 * Follows Bagisto's CommonWidgets pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_radii.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../utils/input_field_validators.dart';

/// Common Widgets
///
/// Provides reusable widget builders for forms, buttons, and UI elements.
class CommonWidgets
    with EmailValidator, PhoneNumberValidator, PasswordValidator {
  /// Builds a text field widget
  ///
  /// [context]: BuildContext
  /// [controller]: Text editing controller
  /// [hint]: Hint text for the field
  /// [label]: Label text (optional)
  /// [validator]: Form field validator (optional)
  /// [keyboardType]: Keyboard type (optional)
  /// [obscureText]: Whether to obscure text (for passwords)
  /// [prefixIcon]: Prefix icon widget (optional)
  /// [suffixIcon]: Suffix icon widget (optional)
  /// [readOnly]: Whether field is read-only
  /// [onTap]: Callback when field is tapped
  /// [maxLines]: Maximum number of lines
  /// [isRequired]: Whether field is required (shows asterisk)
  Widget getTextField(
    BuildContext context,
    TextEditingController controller,
    String hint, {
    String label = "",
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? readOnly,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    int maxLines = 1,
    bool isRequired = false,
    TextStyle? labelTextStyle,
    TextStyle? inputTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? errorTextStyle,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final resolvedLabelStyle =
        labelTextStyle ??
        const TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );
    final resolvedInputStyle = inputTextStyle ?? AppTextStyles.bodyLarge;
    final resolvedHintStyle =
        hintTextStyle ??
        AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textSecondary,
        );
    final resolvedErrorStyle =
        errorTextStyle ??
        AppTextStyles.bodySmall.copyWith(
          color: AppColors.error,
        );

    return TextFormField(
      readOnly: readOnly ?? false,
      style: resolvedInputStyle,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        label:
            isRequired && label.isNotEmpty
                ? Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          label,
                          style: resolvedLabelStyle,
                        ),
                      ),
                      // const WidgetSpan(
                      //   child: Text(
                      //     ' *',
                      //     style: TextStyle(
                      //       color: AppColors.black,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
                : label.isNotEmpty
                ? Text(label, style: resolvedLabelStyle)
                : null,
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacingNormal,
              vertical: AppSpacing.spacingNormal,
            ),
        errorStyle: resolvedErrorStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).iconTheme.color,
        hintStyle: resolvedHintStyle,
        labelStyle: labelTextStyle ?? AppTextStyles.bodyLarge,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: BorderSide(color: AppColors.error, width: 2.0),
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: Theme.of(context).iconTheme.color,
      ),
      validator: validator,
    );
  }

  /// Builds a height spacer widget
  Widget getHeightSpace(double height) => SizedBox(height: height);

  /// Builds a width spacer widget
  Widget getWidthSpace(double width) => SizedBox(width: width);

  /// Builds a text widget with customizable styling
  ///
  /// [text]: Text to display
  /// [context]: BuildContext
  /// [isBold]: Whether text should be bold
  /// [fontSize]: Font size (optional)
  Widget getText(
    String text,
    BuildContext context, {
    bool isBold = false,
    double? fontSize,
  }) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: (fontSize != null
              ? AppTextStyles.bodyLarge.copyWith(fontSize: fontSize)
              : AppTextStyles.bodyLarge)
          .copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds an app button widget
  ///
  /// [context]: BuildContext
  /// [title]: Button text
  /// [onPressed]: Callback when button is pressed
  /// [buttonWidth]: Button width (optional, uses full width if null)
  /// [showIcon]: Whether to show an icon
  /// [icon]: Icon widget (optional)
  /// [backgroundColor]: Background color (optional)
  /// [textColor]: Text color (optional)
  Widget appButton(
    BuildContext context,
    String title,
    VoidCallback onPressed, {
    double? buttonWidth,
    bool showIcon = false,
    Widget? icon,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return SizedBox(
      width: buttonWidth,
      height: 56,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor ?? AppColors.primaryColor,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon && icon != null) ...[
              icon,
              const SizedBox(width: AppSpacing.spacingSmall),
            ],
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: textColor ?? AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a divider widget
  Widget divider({double? thickness, Color? color}) {
    return Divider(
      thickness: thickness ?? 1.0,
      color: color ?? AppColors.border,
    );
  }
}
