import 'package:counter_demo_bloc/feature/auth/data/model/login_response_data_model.dart';
import 'package:counter_demo_bloc/helper/session_manager.dart';
import 'package:counter_demo_bloc/network/api_client.dart';
import 'package:counter_demo_bloc/network/server_error.dart';
import 'package:counter_demo_bloc/res/app_urls.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthDataSource {
  SessionManager get sessionManager;

  // Future<AuthDataModel> sendOTP(String mobile);
  Future<Either<String, AuthDataModel>> sendOTP(String mobile);
}

class AuthDataSourceImp implements AuthDataSource {
  final ApiClient apiClient;
  @override
  final SessionManager sessionManager;

  AuthDataSourceImp({required this.apiClient, required this.sessionManager});

  @override
  Future<Either<String, AuthDataModel>> sendOTP(String mobile) async {
    try {
      final res = await apiClient.postApi(
        url: AppUrls.sendOTPEndPoint,
        body: {'mobile': mobile},
      );
      if (res?.data == null) {
        throw ServerError(500, 'Unexpected null response');
      }
      final data = AuthDataModel.fromJson(res!.data);
      return Right(data);
    } on ServerError catch (e) {
      return Left(e.message);
    } catch (e) {
      throw ServerError(500, e.toString());
    }
  }
}
