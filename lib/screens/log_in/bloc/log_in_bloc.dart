/*
 * Najaz Mobile App
 * Log-In BLoC
 * 
 * This file contains the BLoC for log-in screen business logic.
 * Follows Bagisto's SignInBloc pattern, tailored for Najaz.
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/auth_models/log_in_model.dart';
import 'log_in_event.dart';
import 'log_in_repository.dart';
import 'log_in_state.dart';

/// BLoC for log-in screen
class LogInBloc extends Bloc<LogInBaseEvent, LogInBaseState> {
  /// Repository for log-in operations
  final LogInRepository repository;

  LogInBloc({required this.repository}) : super(InitialLogInState()) {
    on<FetchLogInEvent>(_mapFetchLogInEventToState);
  }

  /// Handles FetchLogInEvent
  Future<void> _mapFetchLogInEventToState(
    FetchLogInEvent event,
    Emitter<LogInBaseState> emit,
  ) async {
    emit(LogInLoadingState());

    try {
      final logInModel = await repository.callLogInApi(
        event.emailOrNationalId ?? '',
        event.password ?? '',
        event.remember,
      );

      if (logInModel.isSuccess == true) {
        emit(
          FetchLogInState.success(
            logInModel: logInModel,
            successMsg: logInModel.message ?? '',
          ),
        );
      } else {
        emit(
          FetchLogInState.fail(
            error: logInModel.graphqlErrors ?? logInModel.message ?? 'Login failed',
          ),
        );
      }
    } catch (e) {
      emit(
        FetchLogInState.fail(
          error: e.toString(),
        ),
      );
    }
  }
}

