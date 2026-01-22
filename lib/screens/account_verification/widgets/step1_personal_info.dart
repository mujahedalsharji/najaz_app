/*
 * Najaz Mobile App
 * Step 1: Personal Information
 * 
 * This widget displays the personal information form for verification Step 1.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_radii.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/helpers_extension.dart';
import '../../../utils/validators/form_validator_helper.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/show_message.dart';
import '../bloc/account_verification_bloc.dart';
import '../bloc/account_verification_event.dart';
import '../bloc/account_verification_state.dart';

/// Step 1: Personal Information Form
class Step1PersonalInfo extends StatefulWidget {
  final VerificationStepState state;

  const Step1PersonalInfo({super.key, required this.state});

  @override
  State<Step1PersonalInfo> createState() => _Step1PersonalInfoState();
}

class _Step1PersonalInfoState extends State<Step1PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _nationalIdController = TextEditingController();

  DateTime? _selectedDate;
  bool _dataConfirmed = false;
  String? _selectedGender;
  String? _originalFullName;
  String? _originalDateOfBirth;
  String? _originalNationalId;
  String? _originalGender;
  bool _isSavingProfile = false;

  // Gender options
  final List<String> _genderOptions = ['MALE', 'FEMALE'];

  @override
  void initState() {
    super.initState();
    // Load existing data from state
    _fullNameController.text = widget.state.fullName ?? '';
    _dateOfBirthController.text = widget.state.dateOfBirth ?? '';
    _nationalIdController.text = widget.state.nationalId ?? '';

    // Ensure gender value matches one of the options (convert to uppercase)
    final genderFromState = widget.state.gender;
    if (genderFromState != null && genderFromState.isNotEmpty) {
      final upperGender = genderFromState.toUpperCase();
      // Only set if it matches one of our options
      if (_genderOptions.contains(upperGender)) {
        _selectedGender = upperGender;
      }
    }

    // Store original values to detect changes
    _originalFullName = widget.state.fullName;
    _originalDateOfBirth = widget.state.dateOfBirth;
    _originalNationalId = widget.state.nationalId;
    _originalGender = widget.state.gender;

    // Load confirmation state
    _dataConfirmed = widget.state.dataConfirmed;
  }

  @override
  void didUpdateWidget(Step1PersonalInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update confirmation state if changed from parent
    if (widget.state.dataConfirmed != oldWidget.state.dataConfirmed) {
      _dataConfirmed = widget.state.dataConfirmed;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountVerificationBloc, AccountVerificationBaseState>(
      listener: (context, state) {
        // Listen for profile update success
        if (_isSavingProfile) {
          if (state is VerificationStepState && state.currentStep == 1) {
            // Profile update completed successfully
            ShowMessage.successNotification(
              StringConstants.changesSaved.localized(),
              context,
            );
            // Update original values after successful save (without triggering rebuild)
            // This will make _hasDataChanged() return false on next build
            _originalFullName = state.fullName;
            _originalDateOfBirth = state.dateOfBirth;
            _originalNationalId = state.nationalId;
            _originalGender = state.gender;
            _isSavingProfile = false;
          } else if (state is VerificationErrorState) {
            // Profile update failed
            _isSavingProfile = false;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacingLarge),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () => _validateAndUpdateState(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                StringConstants.personalInfo.localized(),
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.spacingMedium),
              // Description
              Text(
                StringConstants.personalInfoDescription.localized(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.spacingLarge),
              // Full Name Field
              CommonWidgets().getTextField(
                context,
                _fullNameController,
                StringConstants.fullName.localized(),
                label: StringConstants.fullName.localized(),
                prefixIcon: const Icon(FontAwesomeIcons.user),
                isRequired: true,
                onChanged: (_) => _validateAndUpdateState(),
                validator: (value) => FormValidatorHelper.validateRequired(
                  value,
                  StringConstants.fullName.localized(),
                ),
              ),
              const SizedBox(height: AppSpacing.spacingLarge),
              // Gender Dropdown
              _buildGenderDropdown(),
              const SizedBox(height: AppSpacing.spacingLarge),
              // Date of Birth Field
              CommonWidgets().getTextField(
                context,
                _dateOfBirthController,
                StringConstants.dateOfBirthHint.localized(),
                label: StringConstants.dateOfBirthLabel.localized(),
                isRequired: true,
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon:
                    const Icon(Icons.calendar_today, color: AppColors.black),
                onChanged: (_) => _validateAndUpdateState(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return FormValidatorHelper.validateRequired(
                      value,
                      StringConstants.dateOfBirthLabel.localized(),
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.spacingLarge),
              // National ID Field
              CommonWidgets().getTextField(
                context,
                _nationalIdController,
                StringConstants.nationalIdLabel.localized(),
                label: StringConstants.nationalIdLabel.localized(),
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(FontAwesomeIcons.idCard),
                isRequired: true,
                onChanged: (_) => _validateAndUpdateState(),
                validator: (value) =>
                    FormValidatorHelper.validateNationalId(value),
              ),
              // Save Changes button (only show when editing existing verification)
              if (widget.state.verificationId != null && _hasDataChanged()) ...[
                const SizedBox(height: AppSpacing.spacingLarge),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveProfileChanges,
                    icon: const Icon(Icons.save, color: AppColors.white),
                    label: Text(
                      StringConstants.saveChanges.localized(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.spacingLarge),
              // Data confirmation checkbox
              Container(
                padding: const EdgeInsets.all(AppSpacing.spacingMedium),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  border: Border.all(
                    color:
                        _dataConfirmed ? AppColors.primaryColor : AppColors.border,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _dataConfirmed,
                      onChanged: (value) {
                        setState(() {
                          _dataConfirmed = value ?? false;
                        });
                        context.read<AccountVerificationBloc>().add(
                              ConfirmDataUsageEvent(confirmed: _dataConfirmed),
                            );
                        _validateAndUpdateState();
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          StringConstants.confirmDataUsage.localized(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.spacingWide),
            ],
          ),
        ),
      ),
    );
  }

  /// Opens date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
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
      _validateAndUpdateState();
    }
  }

  /// Builds gender dropdown field
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        label: Text(
          StringConstants.genderLabel.localized(),
          style: AppTextStyles.inputLabel,
        ),
        hintText: StringConstants.genderHint.localized(),
        hintStyle: AppTextStyles.inputHint,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingNormal,
          vertical: AppSpacing.spacingNormal,
        ),
        isDense: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(
          FontAwesomeIcons.venusMars,
          size: 20,
        ),
        prefixIconColor: Theme.of(context).iconTheme.color,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: AppColors.error, width: 2.0),
        ),
      ),
      items: _genderOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Icon(
                value == 'MALE' ? FontAwesomeIcons.mars : FontAwesomeIcons.venus,
                size: 16,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: AppSpacing.spacingNormal),
              Text(
                value == 'MALE'
                    ? StringConstants.male.localized()
                    : StringConstants.female.localized(),
                style: AppTextStyles.inputText,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedGender = value;
        });
        _validateAndUpdateState();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringConstants.genderRequired.localized();
        }
        return null;
      },
      style: AppTextStyles.inputText,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.textSecondary,
      ),
      iconSize: 24,
      dropdownColor: AppColors.white,
      borderRadius: BorderRadius.circular(AppRadii.input),
      menuMaxHeight: 200,
    );
  }

  /// Validate form and update BLoC state
  void _validateAndUpdateState() {
    if (_formKey.currentState?.validate() ?? false) {
      final fullName = _fullNameController.text.trim();
      final dateOfBirth = _dateOfBirthController.text.trim();
      final nationalId = _nationalIdController.text.trim();

      // Update BLoC with current form data (without auto-updating profile)
      context.read<AccountVerificationBloc>().add(
            UpdatePersonalInfoEvent(
              fullName: fullName,
              dateOfBirth: dateOfBirth,
              nationalId: nationalId,
              gender: _selectedGender,
            ),
          );
    }
  }

  /// Check if data has changed from original values
  bool _hasDataChanged() {
    final fullName = _fullNameController.text.trim();
    final dateOfBirth = _dateOfBirthController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    return fullName != _originalFullName ||
        dateOfBirth != _originalDateOfBirth ||
        nationalId != _originalNationalId ||
        _selectedGender != _originalGender;
  }

  /// Save profile updates
  Future<void> _saveProfileChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final fullName = _fullNameController.text.trim();
    final dateOfBirth = _dateOfBirthController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    // Parse full name to first, middle, last
    final nameParts = fullName.split(' ');
    String? firstName = nameParts.isNotEmpty ? nameParts[0] : null;
    String? middleName = nameParts.length > 2
        ? nameParts.sublist(1, nameParts.length - 1).join(' ')
        : (nameParts.length == 2 ? null : null);
    String? lastName = nameParts.length > 1 ? nameParts.last : null;

    // Set saving flag
    setState(() {
      _isSavingProfile = true;
    });

    // Dispatch UpdateProfileEvent
    context.read<AccountVerificationBloc>().add(
          UpdateProfileEvent(
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            nationalId: nationalId,
            gender: _selectedGender,
          ),
        );
  }
}

