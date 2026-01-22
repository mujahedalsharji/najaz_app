import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:najaz_app/screens/sign_up/widgets/sign_up__navigate_login_text.dart';
import 'package:najaz_app/utils/application_localization.dart';
import 'package:najaz_app/utils/helpers_extension.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_radii.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/validators/form_validator_helper.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/shimmer_widget.dart';
import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_event.dart';

class SignUpForm extends StatefulWidget {
  final bool isLoading;

  const SignUpForm({super.key, this.isLoading = false});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _agreement = false;
  bool _showAgreementError = false;
  DateTime? _selectedDate;

  // Gender options
  final List<String> _genderOptions = ['MALE', 'FEMALE'];

  TextStyle get _bagistoLabelStyle => AppTextStyles.bodyMedium.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  TextStyle get _bagistoInputStyle =>
      AppTextStyles.bodyLarge.copyWith(fontSize: 14);

  TextStyle get _bagistoHintStyle => AppTextStyles.bodyMedium.copyWith(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  TextStyle get _bagistoErrorStyle => AppTextStyles.bodySmall.copyWith(
    fontSize: 10,
    color: AppColors.error,
  );

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingLarge,
          vertical: AppSpacing.spacingMedium,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: IgnorePointer(
            ignoring: isLoading,
            child: Opacity(
              opacity: isLoading ? 0.6 : 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.spacingSmall),

                  // Full Name Field
                  CommonWidgets().getTextField(
                    context,
                    _fullNameController,
                    StringConstants.fullName.localized(),
                    label: StringConstants.fullName.localized(),
                    prefixIcon: Icon(FontAwesomeIcons.user),
                    isRequired: true,
                    labelTextStyle: _bagistoLabelStyle,
                    inputTextStyle: _bagistoInputStyle,
                    hintTextStyle: _bagistoHintStyle,
                    errorTextStyle: _bagistoErrorStyle,
                    validator:
                        (value) => FormValidatorHelper.validateRequired(
                          value,
                          StringConstants.fullName.localized(),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.spacingMedium),

                  // Gender Dropdown
                  genderDropdown(),
                  const SizedBox(height: AppSpacing.spacingMedium),

                  // Phone Field
                  CommonWidgets().getTextField(
                    context,
                    _phoneController,
                    prefixIcon: Icon(FontAwesomeIcons.phoneFlip),
                    StringConstants.phoneNumberLabel.localized(),
                    label: StringConstants.phoneNumberLabel.localized(),
                    keyboardType: TextInputType.phone,
                    isRequired: true,
                    labelTextStyle: _bagistoLabelStyle,
                    inputTextStyle: _bagistoInputStyle,
                    hintTextStyle: _bagistoHintStyle,
                    errorTextStyle: _bagistoErrorStyle,
                    validator:
                        (value) => FormValidatorHelper.validatePhone(value),
                  ),
                  const SizedBox(height: AppSpacing.spacingMedium),

                  // National ID Field
                  CommonWidgets().getTextField(
                    context,
                    _nationalIdController,
                    prefixIcon: Icon(FontAwesomeIcons.idCard),
                    StringConstants.nationalIdLabel.localized(),
                    label: StringConstants.nationalIdLabel.localized(),
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    labelTextStyle: _bagistoLabelStyle,
                    inputTextStyle: _bagistoInputStyle,
                    hintTextStyle: _bagistoHintStyle,
                    errorTextStyle: _bagistoErrorStyle,
                    validator:
                        (value) =>
                            FormValidatorHelper.validateNationalId(value),
                  ),
                  const SizedBox(height: AppSpacing.spacingMedium),

                  // Date of Birth Field
                  _buildDateOfBirthField(),
                  const SizedBox(height: AppSpacing.spacingMedium),

                  // Password and Confirm Password Fields in one row
                  Row(
                    children: [
                      // Password Field (half width)
                      Expanded(
                        child: CommonWidgets().getTextField(
                          context,
                          _passwordController,
                          prefixIcon: Icon(Icons.lock_outline, size: 20),
                          StringConstants.passwordLabel.localized(),
                          label: StringConstants.passwordLabel.localized(),
                          isRequired: true,
                          obscureText: !_showPassword,
                          labelTextStyle: _bagistoLabelStyle,
                          inputTextStyle: _bagistoInputStyle,
                          hintTextStyle: _bagistoHintStyle,
                          errorTextStyle: _bagistoErrorStyle,
                          validator:
                              (value) =>
                                  FormValidatorHelper.validatePassword(value),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spacingMedium),
                      // Confirm Password Field (half width)
                      Expanded(
                        child: TextFormField(
                          style: _bagistoInputStyle,
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: !_showConfirmPassword,
                          decoration: InputDecoration(
                            label: Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  WidgetSpan(
                                    child: Text(
                                      StringConstants.confirmPasswordLabel
                                          .localized(),
                                      style: _bagistoLabelStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintText:
                                StringConstants.confirmPasswordLabel.localized(),
                            isDense: true,
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.spacingNormal,
                              vertical: AppSpacing.spacingNormal,
                            ),
                            errorStyle: _bagistoErrorStyle,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Icon(Icons.lock_outline, size: 20),
                            prefixIconColor: Theme.of(context).iconTheme.color,
                            hintStyle: _bagistoHintStyle,
                            labelStyle: _bagistoLabelStyle,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadii.input),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadii.input),
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadii.input),
                              borderSide: BorderSide(color: AppColors.error),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadii.input),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showConfirmPassword = !_showConfirmPassword;
                                });
                              },
                            ),
                            suffixIconColor:
                                Theme.of(context).iconTheme.color,
                          ),
                          validator:
                              (value) =>
                                  FormValidatorHelper.validatePasswordConfirmation(
                                    value,
                                    _passwordController.text,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height:90),

                  // Agreement Checkbox

                  //  const SizedBox(height: AppSpacing.spacingLarge),

                  // Submit Button
                  _buildSubmitButton(),
                  // const SizedBox(height: AppSpacing.spacingMedium),

                  // Already have account? Login text
                  sign_up_NavigateLoginText(context: context),
                  const SizedBox(height: AppSpacing.spacingLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds gender dropdown field
  Widget genderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      style: _bagistoInputStyle,
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: StringConstants.genderLabel.localized(),
                style: _bagistoLabelStyle,
              ),
            ],
          ),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingNormal,
          vertical: AppSpacing.spacingNormal,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.error, width: 2.0),
        ),
      ),
      items:
          _genderOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value == 'MALE'
                    ? StringConstants.male.localized()
                    : StringConstants.female.localized(),
              ),
            );
          }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringConstants.genderRequired.localized();
        }
        return null;
      },
    );
  }

  /// Builds date of birth field with date picker
  Widget _buildDateOfBirthField() {
    return CommonWidgets().getTextField(
      context,
      _dateOfBirthController,
      StringConstants.dateOfBirthHint.localized(),
      label: StringConstants.dateOfBirthLabel.localized(),

      isRequired: true,
      labelTextStyle: _bagistoLabelStyle,
      inputTextStyle: _bagistoInputStyle,
      hintTextStyle: _bagistoHintStyle,
      errorTextStyle: _bagistoErrorStyle,
      readOnly: true,
      onTap: () => _selectDate(context),
      suffixIcon: Icon(Icons.calendar_today, color: AppColors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return FormValidatorHelper.validateRequired(
            value,
            StringConstants.dateOfBirthLabel.localized(),
          );
        }
        return null;
      },
    );
  }

  /// Opens date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ??
          DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text = picked.toDateString();
      });
    }
  }

  /// Builds submit button
  Widget _buildSubmitButton() {
    final isLoading = widget.isLoading;

    if (isLoading) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              AppColors.primaryColor,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.button),
              ),
            ),
            elevation: WidgetStateProperty.all(0),
          ),
          onPressed: null,
          child: const ShimmerContainer(
            width: 20,
            height: 20,
            borderRadius: 10,
          ),
        ),
      );
    }

    return CommonWidgets().appButton(
      context,
      StringConstants.createAccount.localized(),
      textColor: AppColors.white,
      _onSubmit,
    );
  }

  /// Handles form submission
  void _onSubmit() {
    if (widget.isLoading) return;

    // Validate agreement
    if (!_agreement) {
      setState(() {
        _showAgreementError = true;
      });
      return;
    }

    // Validate form
    if (_formKey.currentState!.validate()) {
      final fullName = _fullNameController.text.trim();
      final nameParts = fullName.splitFullName();

      Navigator.of(context).pushNamed(
        RouteConstants.privacyPolicy,
        arguments: {
          'firstName': nameParts['firstName'],
          'middleName': nameParts['middleName'],
          'lastName': nameParts['lastName'],
          'gender': _selectedGender,
          'phone': _phoneController.text.trim(),
          'nationalId': _nationalIdController.text.trim(),
          'dateOfBirth': _dateOfBirthController.text.trim(),
          'citizenTypeId': 1,
          'password': _passwordController.text.trim(),
          'passwordConfirmation': _confirmPasswordController.text.trim(),
        },
      );
    }
  }
}
