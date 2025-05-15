import 'package:counter_demo_bloc/feature/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.success,
    required super.message,
    super.authDataEntity,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['status'] ?? false,
      message: json['msg'] ?? '',
      authDataEntity:
          json['data'] != null ? AuthDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': success,
      'msg': message,
      'data':
          authDataEntity != null
              ? (authDataEntity as AuthDataModel).toJson()
              : null,
    };
  }
}

class AuthDataModel extends AuthDataEntity {
  AuthDataModel({
    super.token,
    super.username,
    super.email,
    super.phoneNo,
    super.userId,
    super.name,
    super.isPhoneVerified,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      token: json['token'],
      username: json['username'],
      email: json['email'],
      phoneNo: json['phone_no'],
      userId: json['user_id'],
      name: json['name'],
      isPhoneVerified: json['is_phone_verifed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'email': email,
      'phone_no': phoneNo,
      'user_id': userId,
      'name': name,
      'is_phone_verifed': isPhoneVerified,
    };
  }
}
