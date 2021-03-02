import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UnauthoriseInterceptor extends InterceptorsWrapper {
  Dio dio;
  UnauthoriseInterceptor({@required this.dio});
  @override
  Future<Response> onRequest(RequestOptions options) async {
    Response response = await dio.resolve('unauthorise');
    response.statusCode = 401;
    return response;
  }
}
