class AuthEntity {
  final bool success;
  final String message;
  final AuthDataEntity? authDataEntity;

  AuthEntity({
    required this.success,
    required this.message,
    this.authDataEntity,
  });
}

class AuthDataEntity {
  final String? token;
  final String? username;
  final String? email;
  final String? phoneNo;
  final int? userId;
  final String? name;
  final bool? isPhoneVerified;

  AuthDataEntity({
    this.token,
    this.username,
    this.email,
    this.phoneNo,
    this.userId,
    this.name,
    this.isPhoneVerified,
  });
}
