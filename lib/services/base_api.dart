import 'dart:async';
import 'dart:convert';

import 'package:base_api_with_dio/networks/base_network.dart';
import 'package:dio/dio.dart';

class BaseApi {
  BaseNetwork network = BaseNetwork(
    baseUrl: 'https://reqres.in/api/',
  );
  Response<dynamic> response;

  Future<List> fetchAll({Map<String, dynamic> queryParameters}) async {
    var endpoint = this.objectUrlName();

    response = await this.network.http.get(
          endpoint,
          queryParameters: queryParameters,
        );

    var json = jsonDecode(response.toString());

    if (json == null) {
      return [];
    }

    List<dynamic> items = json['data'];
    return items.map((item) {
      return objectType(item);
    }).toList();
  }

  success() {
    if (this.response != null) {
      return this.response.statusCode >= 200 && this.response.statusCode < 300;
    }
    return false;
  }

  objectType(Map<String, dynamic> json) {
    throw 'missing model type';
  }

  String objectUrlName() {
    throw 'missing url name';
  }
}
