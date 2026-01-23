/*
 * Najaz Mobile App
 * Service Description Screen View
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/show_message.dart';
import '../bloc/service_description_bloc.dart';
import '../bloc/service_description_event.dart';
import '../bloc/service_description_repository.dart';
import '../bloc/service_description_state.dart';
import '../widgets/service_description_body.dart';

class ServiceDescriptionScreen extends StatelessWidget {
  final String? serviceId;
  final String? serviceName;
  final String? serviceDescription;
  final String? serviceImage;

  const ServiceDescriptionScreen({
    super.key,
    this.serviceId,
    this.serviceName,
    this.serviceDescription,
    this.serviceImage,
  });

  static Widget builder(
    BuildContext context, {
    String? serviceId,
    String? serviceName,
    String? serviceDescription,
    String? serviceImage,
  }) {
    return BlocProvider<ServiceDescriptionBloc>(
      create:
          (context) => ServiceDescriptionBloc(
            repository: ServiceDescriptionRepositoryImp(),
          )..add(FetchServiceDescriptionEvent(serviceId: serviceId)),
      child: ServiceDescriptionScreen(
        serviceId: serviceId,
        serviceName: serviceName,
        serviceDescription: serviceDescription,
        serviceImage: serviceImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ServiceDescriptionBloc>().state;

    if (state is ServiceDescriptionLoading ||
        state is ServiceDescriptionInitial) {
      return Scaffold(
        backgroundColor: AppColors.backgroundLight,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShimmerContainer(width: 60, height: 60, borderRadius: 30),
              const SizedBox(height: 16),
              Text(
                StringConstants.pleaseWaitMoment.localized(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocConsumer<ServiceDescriptionBloc, ServiceDescriptionState>(
      listener: (context, state) {
        if (state is ServiceDescriptionError) {
          ShowMessage.errorNotification(state.message, context);
        }
      },
      builder: (context, state) {
        String title = '...';
        int? unreadCount;

        if (state is ServiceDescriptionLoaded) {
          title = state.serviceForm?.name ?? serviceName ?? '';
          unreadCount = state.unreadNotificationsCount;
        }

        return Scaffold(
          //  backgroundColor: AppColors.backgroundLight,
          extendBodyBehindAppBar: true,
          appBar: CommonAppBar(
            title,
            centerTitle: true,
            showNotifications: true,
            unreadNotificationsCount: unreadCount,
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleStyle: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                // child: Container(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ServiceDescriptionState state) {
    if (state is ServiceDescriptionLoading ||
        state is ServiceDescriptionInitial) {
      return const Center(
        child: ShimmerContainer(width: 60, height: 60, borderRadius: 30),
      );
    }

    if (state is ServiceDescriptionLoaded) {
      return ServiceDescriptionBody(
        serviceId: serviceId,
        serviceForm: state.serviceForm,
        fallbackName: serviceName,
        fallbackDescription: serviceDescription,
        fallbackImage: serviceImage,
      );
    }

    if (state is ServiceDescriptionError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ServiceDescriptionBloc>().add(
                  FetchServiceDescriptionEvent(serviceId: serviceId),
                );
              },
              child: Text(StringConstants.retry.localized()),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
