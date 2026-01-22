/*
 * Najaz Mobile App
 * Home Screen View
 * 
 * This file contains the home screen UI with GraphQL query integration.
 * Uses BLoC pattern for state management.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/show_message.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';
import '../../home/bloc/home_repository.dart';
import '../../home/bloc/home_state.dart';
import '../../home/widgets/home_body.dart';

/// Home Screen
///
/// Displays home screen with:
/// - App bar with citizen name, verification status, notification badge, and search bar
/// - Current Requests (الطلبات الحالية) section
/// - Services section
/// - Bottom navigation bar
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create:
          (context) =>
              HomeBloc(repository: HomeRepositoryImp())
                ..add(const FetchHomePageEvent()),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight, // #FCFBF8 from SVG
      // appBar: const _HomeAppBar(),
      body: HomeBlocContainer(),
    );
  }
}

/// Home App Bar Widget
///
/// Custom AppBar that implements PreferredSizeWidget and uses BlocBuilder
/// to reactively update based on home page state

/// BLoC Container for Home Screen
///
/// Handles BLoC state listening and UI rendering
class HomeBlocContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeBaseState>(
      listener: (BuildContext context, HomeBaseState state) {
        if (state is FetchHomePageState) {
          if (state.status == HomeStatus.fail) {
            ShowMessage.errorNotification(
              state.error ?? StringConstants.somethingWentWrong.localized(),
              context,
            );
          }
        }
      },
      builder: (BuildContext context, HomeBaseState state) {
        if (state is HomeLoadingState) {
          return const HomeBody(isLoading: true);
        }

        if (state is FetchHomePageState) {
          return HomeBody(
            homePageData: state.homePageModel,
            serviceRequests: state.serviceRequests,
            services: state.services,
            isLoading: false,
            onRefresh: () {
              context.read<HomeBloc>().add(const RefreshHomeDataEvent());
            },
          );
        }

        // Initial or unknown state - show loading
        return const HomeBody(isLoading: true);
      },
    );
  }
}
