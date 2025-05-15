import 'dart:convert';

import 'package:counter_demo_bloc/feature/auth/data/model/login_response_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SessionManager {
  Future<void> setUserId(String userId);

  Future<String> getUserId();

  Future<void> setToken(String token);

  Future<String> getToken();

  Future<AuthDataModel?> getSession();

  Future<void> setSession(AuthDataModel userData);

  Future<void> setWalkThrough();

  Future<bool> isWalkThrough();

  Future<void> clearSession();
}

class SessionManagerImp implements SessionManager {
  final SharedPreferences sharedPreferences;

  SessionManagerImp({required this.sharedPreferences});

  @override
  Future<AuthDataModel?> getSession() async {
    var data = sharedPreferences.getString(Keys.userDetails.toString());
    if (data != null) {
      try {
        return AuthDataModel.fromJson(jsonDecode(data));
      } catch (e) {
        debugPrint('Error decoding session data: $e');
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> setSession(AuthDataModel userData) async {
    await sharedPreferences.setString(
      Keys.userDetails.toString(),
      jsonEncode(userData.toJson()),
    );
  }

  @override
  Future<void> setWalkThrough() async {
    sharedPreferences.setBool(Keys.walkThrough.toString(), false);
  }

  @override
  Future<bool> isWalkThrough() async {
    return sharedPreferences.getBool(Keys.walkThrough.toString()) ?? true;
  }

  @override
  Future<String> getUserId() async {
    return sharedPreferences.getString(Keys.userId.toString()) ?? '';
  }

  @override
  Future<void> setUserId(String userId) async {
    await sharedPreferences.setString(Keys.userId.toString(), userId);
  }

  @override
  Future<void> clearSession() async {
    await sharedPreferences.remove(Keys.userId.toString());
    await sharedPreferences.remove(Keys.userDetails.toString());
    await sharedPreferences.remove(Keys.authToken.toString());
  }

  @override
  Future<String> getToken() async {
    return sharedPreferences.getString(Keys.authToken.toString()) ?? '';
  }

  @override
  Future<void> setToken(String token) async {
    sharedPreferences.setString(Keys.authToken.toString(), token);
  }
}

enum Keys { authToken, userDetails, walkThrough, userId }
