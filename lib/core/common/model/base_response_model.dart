import 'package:counter_demo_bloc/core/common/entity/base_response_entity.dart';

class BaseResponseModel extends BaseResponseEntity {
  BaseResponseModel({required super.success, required super.message});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }
}
