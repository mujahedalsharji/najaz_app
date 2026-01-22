/*
 * Najaz Mobile App
 * Account Info Body
 */

import 'package:flutter/material.dart';

import '../../../models/profile_models/my_profile_model.dart';
import '../../../screens/account_verification/bloc/account_verification_repository.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/show_message.dart';

class AccountInfoBody extends StatefulWidget {
  final MyProfileModel profile;

  const AccountInfoBody({super.key, required this.profile});

  @override
  State<AccountInfoBody> createState() => _AccountInfoBodyState();
}

class _AccountInfoBodyState extends State<AccountInfoBody> {
  final _fullNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _repository = AccountVerificationRepositoryImp();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _fullNameController.text = _fullName(widget.profile);
    _nationalIdController.text = widget.profile.nationalId ?? '';
    _phoneController.text = widget.profile.phone ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          _buildAvatarHeader(),
          const SizedBox(height: 40),
          _buildDisplayField(
            label: StringConstants.fullName.localized(),
            controller: _fullNameController,
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 24),
          _buildDisplayField(
            label: StringConstants.nationalIdLabel.localized(),
            controller: _nationalIdController,
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 40),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildAvatarHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.brandAccent, width: 2),
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF4F3EF),
            child: Icon(
              Icons.person_rounded,
              size: 64,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          right: 6,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF2EAD9),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.brandAccent, width: 1),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 16,
              color: AppColors.brandAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisplayField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      enabled: false,
      style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        prefixIcon: Icon(icon, color: AppColors.textSecondary),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.textPrimary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 48,
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                labelText: StringConstants.phoneNumberLabel.localized(),
                labelStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                prefixIcon: const Icon(
                  Icons.phone,
                  color: AppColors.textSecondary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child:
                  _isSaving
                      ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : Text(
                        StringConstants.saveChanges.localized(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isSaving = true;
    });

    final profile = widget.profile;
    final response = await _repository.updateProfile(
      firstName: profile.firstName,
      middleName: profile.middleName,
      lastName: profile.lastName,
      nationalId: profile.nationalId,
      dateOfBirth: profile.dateOfBirth,
      gender: profile.gender,
      phone: _phoneController.text,
    );

    if (!mounted) return;
    setState(() {
      _isSaving = false;
    });

    final success = response?['success'] == true;
    final message =
        response?['message']?.toString() ?? StringConstants.error.localized();

    if (success) {
      ShowMessage.successNotification(message, context);
    } else {
      ShowMessage.errorNotification(message, context);
    }
  }

  String _fullName(MyProfileModel profile) {
    final parts =
        [
          profile.firstName,
          profile.middleName,
          profile.lastName,
        ].where((part) => part != null && part.trim().isNotEmpty).toList();
    return parts.map((e) => e!.trim()).join(' ');
  }
}
