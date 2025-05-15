import 'package:counter_demo_bloc/network/response_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<ResponseModel, SuccessType>> call(Params params);
}
