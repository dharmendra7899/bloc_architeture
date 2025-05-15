import 'package:counter_demo_bloc/network/response_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<ResponseModel, String>> loginWithMobile({
    required String mobile,
  });
}
