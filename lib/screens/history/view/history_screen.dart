/*
 * Najaz Mobile App
 * History Screen View
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/show_message.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_repository.dart';
import '../bloc/history_state.dart';
import '../widgets/history_body.dart';
import '../widgets/history_app_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create:
          (context) =>
              HistoryBloc(repository: HistoryRepositoryImp())
                ..add(const FetchHistoryEvent()),
      child: const HistoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        int? unreadCount;
        if (state is HistoryLoaded) {
          unreadCount = state.unreadNotificationsCount;
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: HistoryAppBar(unreadNotificationsCount: unreadCount),
          body: const HistoryBlocContainer(),
        );
      },
    );
  }
}

class HistoryBlocContainer extends StatelessWidget {
  const HistoryBlocContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryError) {
          ShowMessage.errorNotification(state.message, context);
        }
      },
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(
            child: ShimmerContainer(
              width: 60,
              height: 60,
              borderRadius: 30,
            ),
          );
        }

        if (state is HistoryLoaded) {
          return HistoryBody(
            requests: state.requests,
            onRefresh: () {
              context.read<HistoryBloc>().add(const RefreshHistoryEvent());
            },
            selectedStatus: state.selectedStatus,
            onStatusSelected: (status) {
              context.read<HistoryBloc>().add(FetchHistoryEvent(status: status));
            },
            isLoading: state.isLoadingValue,
          );
        }

        if (state is HistoryError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HistoryBloc>().add(const FetchHistoryEvent());
                  },
                  child: Text(StringConstants.retry.localized()),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No requests available'));
      },
    );
  }
}

