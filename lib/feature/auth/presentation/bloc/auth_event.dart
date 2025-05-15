abstract class AuthEvent {
  AuthEvent();
}

class OnSendOtpEvent extends AuthEvent {
  final String mobile;
  OnSendOtpEvent({required this.mobile});
}
