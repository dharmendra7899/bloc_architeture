import 'package:counter_demo_bloc/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:counter_demo_bloc/feature/auth/domain/repositories/auth_repository.dart';
import 'package:counter_demo_bloc/network/response_model.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImp({required this.authDataSource});

  @override
  Future<Either<ResponseModel, String>> loginWithMobile({
    required String mobile,
  }) async {
    // try {
    await authDataSource.sendOTP(mobile);
    return Right(mobile);
    // } on ServerError catch (e) {
    //   return Left(e.message ?? Messages.WRONG);
    // } catch (e) {
    //   return Left(ResponseModel(msg: e.toString()));
    // }
  }
}
