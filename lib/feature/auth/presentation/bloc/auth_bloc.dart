import 'package:counter_demo_bloc/feature/auth/domain/usecases/login_with_otp_usecase.dart';
import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_event.dart';
import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_state.dart';
import 'package:counter_demo_bloc/network/response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithMobileUseCase _loginWithMobileUseCase;

  AuthBloc({required LoginWithMobileUseCase loginWithMobileUseCase})
    : _loginWithMobileUseCase = loginWithMobileUseCase,

      super(AuthState()) {
    on<OnSendOtpEvent>(_onSendOtpEvent);
  }

  _onSendOtpEvent(OnSendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    var res = await _loginWithMobileUseCase.call(
      LoginWithOtpUsecaseParams(mobile: event.mobile),
    );
    res.fold(
      (ResponseModel failure) {
        emit(SendOtpFailureState(message: failure.msg.toString()));
      },
      (String mobile) {
        emit(SendOtpSuccessState(mobile: mobile));
      },
    );
  }
}
