/*
 * Najaz Mobile App
 * Profile Screen View
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/show_message.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_repository.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create:
          (context) =>
              ProfileBloc(repository: ProfileRepositoryImp())
                ..add(const FetchProfileEvent()),
      child: const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        int? unreadCount;
        if (state is ProfileLoaded) {
          unreadCount = state.unreadNotificationsCount;
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(StringConstants.profile.localized()),
            actions: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      AppNavigation.navigateTo(
                        context,
                        RouteConstants.notifications,
                      );
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                  if (unreadCount != null && unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFB300),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          body: const ProfileBlocContainer(),
        );
      },
    );
  }
}

class ProfileBlocContainer extends StatelessWidget {
  const ProfileBlocContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
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
          return ProfileBody(
            profile: state.profile,
            onRefresh: () {
              context.read<ProfileBloc>().add(const RefreshProfileEvent());
            },
          );
        }

        if (state is ProfileError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(const FetchProfileEvent());
                  },
                  child: Text(StringConstants.retry.localized()),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No profile data'));
      },
    );
  }
}

