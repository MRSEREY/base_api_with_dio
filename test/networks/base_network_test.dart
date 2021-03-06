import 'package:base_api_with_dio/interceptors/fake_response_interceptor.dart';
import 'package:base_api_with_dio/interceptors/unauthorise_interceptor.dart';
import 'package:base_api_with_dio/networks/base_network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("BaseNetwork", () {
    test('success', () async {
      String data = 'any';

      var baseNetwork = BaseNetwork(baseUrl: 'https://base_url.com');
      var interceptor = FakeResponseInterceptor(
        dio: baseNetwork.http,
        data: data,
      );
      baseNetwork.addInterceptor(interceptor);
      var response = await baseNetwork.http.get('/locations');

      expect(response.request.baseUrl, 'https://base_url.com');
      expect(response.request.uri.toString(), 'https://base_url.com/locations');
      expect(response.data, data);
    });

    test('unauthorise', () async {
      var baseNetwork = BaseNetwork(baseUrl: 'https://base_url.com');
      var interceptor = UnauthoriseInterceptor(
        dio: baseNetwork.http,
      );
      baseNetwork.addInterceptor(interceptor);
      var response = await baseNetwork.http.get('/locations');

      expect(response.statusCode, 401);
      expect(response.data, 'unauthorise');
    });
  });
}
