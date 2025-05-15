import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  final int? statusCode;
  final bool? status;
  final String? msg;
  final dynamic data;
  final dynamic currentTimeStamp;

  ResponseModel({
    this.statusCode,
    this.status,
    this.msg,
    this.data,
    this.currentTimeStamp,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    statusCode: json["status_code"],
    status: json["status"],
    msg: json["msg"],
    data: json["data"],
    currentTimeStamp: json["currentTimeStamp"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "msg": msg,
    "currentTimeStamp": currentTimeStamp,
    "data": data,
  };
}
