import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FakeResponseInterceptor extends InterceptorsWrapper {
  Dio dio;
  String data;
  FakeResponseInterceptor({@required this.dio, @required this.data});
  @override
  Future<Response> onRequest(RequestOptions options) async {
    return dio.resolve(data);
  }
}
