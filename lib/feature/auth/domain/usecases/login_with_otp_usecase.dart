import 'package:counter_demo_bloc/core/usecases/usecase.dart';
import 'package:counter_demo_bloc/feature/auth/domain/repositories/auth_repository.dart';
import 'package:counter_demo_bloc/network/response_model.dart';
import 'package:fpdart/fpdart.dart';

class LoginWithMobileUseCase
    implements UseCase<String, LoginWithOtpUsecaseParams> {
  final AuthRepository authRepository;

  LoginWithMobileUseCase({required this.authRepository});

  @override
  Future<Either<ResponseModel, String>> call(
    LoginWithOtpUsecaseParams params,
  ) async {
    return await authRepository.loginWithMobile(mobile: params.mobile);
  }
}

class LoginWithOtpUsecaseParams {
  final String mobile;

  LoginWithOtpUsecaseParams({required this.mobile});
}
