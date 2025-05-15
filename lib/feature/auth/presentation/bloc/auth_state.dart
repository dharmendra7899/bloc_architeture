class AuthState {
  AuthState();
}

final class AuthInitState extends AuthState {
  AuthInitState();
}

final class AuthLoadingState extends AuthState {
  AuthLoadingState();
}

class SendOtpSuccessState extends AuthState {
  final String mobile;

  SendOtpSuccessState({required this.mobile});
}

class SendOtpFailureState extends AuthState {
  final String message;

  SendOtpFailureState({required this.message});
}
