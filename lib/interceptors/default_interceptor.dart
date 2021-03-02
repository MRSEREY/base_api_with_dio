import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DefaultInterceptor extends InterceptorsWrapper {
  String baseUrl;
  DefaultInterceptor({@required this.baseUrl});
  @override
  Future<RequestOptions> onRequest(RequestOptions options) async {
    options.baseUrl = this.baseUrl;
    return options;
  }
}
