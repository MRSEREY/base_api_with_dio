import 'package:base_api_with_dio/interceptors/default_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseNetwork {
  Dio http;
  String baseUrl;
  BaseNetwork({@required this.baseUrl}) {
    this.http = Dio();
    this.http.interceptors.add(DefaultInterceptor(baseUrl: baseUrl));
  }

  addInterceptor(InterceptorsWrapper interceptor) {
    this.http.interceptors.add(interceptor);
  }

  removeInterceptor(InterceptorsWrapper interceptor) {
    this.http.interceptors.remove(interceptor);
  }
}
