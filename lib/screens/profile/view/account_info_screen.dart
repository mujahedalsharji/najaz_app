/*
 * Najaz Mobile App
 * Account Info (Personal Information) Screen
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/show_message.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_repository.dart';
import '../bloc/profile_state.dart';
import '../widgets/account_info_body.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  static Widget builder(BuildContext context, Object? arguments) {
    return BlocProvider<ProfileBloc>(
      create:
          (context) =>
              ProfileBloc(repository: ProfileRepositoryImp())
                ..add(const FetchProfileEvent()),
      child: const AccountInfoScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(StringConstants.personalInfo.localized()),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ShowMessage.errorNotification(state.message, context);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: ShimmerContainer(
                width: 60,
                height: 60,
                borderRadius: 30,
              ),
            );
          }

          if (state is ProfileLoaded) {
            final profile = state.profile;
            if (profile == null) {
              return Center(
                child: Text(StringConstants.error.localized()),
              );
            }
            return AccountInfoBody(profile: profile);
          }

          if (state is ProfileError) {
            return Center(
              child: Text(StringConstants.error.localized()),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

