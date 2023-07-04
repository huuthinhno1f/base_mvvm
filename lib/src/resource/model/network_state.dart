import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../configs/configs.dart';

class NetworkState<T> {
  int? status;
  String? message;
  T? data;

  NetworkState({this.message, this.data, this.status});

  factory NetworkState.fromResponse(Response response, {converter, value, String? prefix}) {
    try {
      return NetworkState._fromJson(jsonDecode(jsonEncode(response.data)),
          converter: converter, prefix: prefix, value: value);
    } catch (e) {
      log("Error NetworkResponse.fromResponse: $e");
      return NetworkState.withErrorConvert(e);
    }
  }

  NetworkState._fromJson(dynamic json, {converter, value, String? prefix}) {
    status = json['status'];
    message = json['message'];
    if (value != null) {
      data = value;
    } else if (prefix != null) {
      if (prefix.trim().isEmpty) {
        data = converter != null && json != null ? converter(json) : json;
      } else {
        data = converter != null && json[prefix] != null ? converter(json[prefix]) : json[prefix];
      }
    } else {
      data =
      converter != null && json["data"] != null ? converter(json["data"]) : json["data"];
    }
  }

  NetworkState.fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.status = json['status'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }

  NetworkState.withError(DioError error) {
    String message;
    int? code;
    Response? response = error.response;
    if (response != null) {
      code = response.statusCode;
      message = response.data["message"];
    } else {
      code = AppEndpoint.ERROR_SERVER;
      message = "Không thể kết nối đến máy chủ!";
    }
    this.message = message;
    this.status = code;
    this.data = null;
  }

  NetworkState.withDisconnect() {
    this.message = "Mất kết nối internet, vui lòng kiểm tra wifi/3g và thử lại!";
    this.status = AppEndpoint.ERROR_DISCONNECT;
    this.data = null;
  }

  NetworkState.withErrorConvert(error) {
    this.data = null;
  }

  bool get isSuccess => status == AppEndpoint.SUCCESS;

  bool get isError => status != AppEndpoint.SUCCESS;
}
