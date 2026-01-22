/*
 * Najaz Mobile App
 * Sign-Up BLoC
 * 
 * This file implements the business logic for the Sign-Up screen.
 * Follows Bagisto's sign-up BLoC pattern, tailored for Najaz.
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/auth_models/sign_up_model.dart';
import 'sign_up_event.dart';
import 'sign_up_repository.dart';
import 'sign_up_state.dart';

/// Sign-Up BLoC
///
/// Handles sign-up business logic and state management
class SignUpBloc extends Bloc<SignUpBaseEvent, SignUpBaseState> {
  SignUpRepository? repository;

  SignUpBloc({this.repository}) : super(InitialSignUpState()) {
    on<FetchSignUpEvent>(_mapFetchSignUpEventToState);
  }

  /// Maps FetchSignUpEvent to state
  Future<void> _mapFetchSignUpEventToState(
    FetchSignUpEvent event,
    Emitter<SignUpBaseState> emit,
  ) async {
    emit(SignUpLoadingState());

    try {
      SignUpModel? signUpResponseModel = await repository?.callSignUpApi(
        firstName: event.firstName ?? "",
        middleName: event.middleName ?? "",
        lastName: event.lastName ?? "",
        gender: event.gender ?? "MALE",
        phone: event.phone ?? "",
        nationalId: event.nationalId ?? "",
        dateOfBirth: event.dateOfBirth ?? "",
        citizenTypeId: event.citizenTypeId ?? 1,
        password: event.password ?? "",
        passwordConfirmation: event.passwordConfirmation ?? "",
      );

      if (signUpResponseModel?.isSuccess == true) {
        emit(
          FetchSignUpState.success(
            signUpModel: signUpResponseModel,
            successMsg: signUpResponseModel?.message,
          ),
        );
      } else {
        emit(
          FetchSignUpState.fail(
            error: signUpResponseModel?.errorMessage ?? "Sign-up failed",
          ),
        );
      }
    } catch (e) {
      emit(FetchSignUpState.fail(error: e.toString()));
    }
  }
}
