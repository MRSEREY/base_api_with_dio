import 'package:base_api_with_dio/models/network_error_model.dart';
import 'package:dio/dio.dart';

class NetWorkException {
  final DioError error;

  NetWorkException(this.error);

  translateException() {
    switch (this.error.type) {
      case DioErrorType.CANCEL:
        return NetWorkErrorModel(
          title: 'cancelled',
          description: 'yourRequestHasBeenCancelled',
          statusCode: null,
        );
      case DioErrorType.CONNECT_TIMEOUT:
        return NetWorkErrorModel(
          title: 'connectionTimeOut',
          description: 'yourConnectionIsTimeout',
          statusCode: null,
        );
      case DioErrorType.RECEIVE_TIMEOUT:
        return NetWorkErrorModel(
          title: 'recieveTimeout',
          description: 'yourRecievingDataIsTimeout',
          statusCode: null,
        );
      case DioErrorType.RESPONSE:
        switch (error.response.statusCode) {
          case 400:
            return NetWorkErrorModel(
              title: 'badRequest',
              description: 'sorryThisIsAnIllegalRequest',
              statusCode: 400,
            );
          case 401:
            return NetWorkErrorModel(
              title: 'unauthorize',
              description: 'youAreNotAllowToAccessThisResource',
              statusCode: 401,
            );
          case 404:
            return NetWorkErrorModel(
              title: 'notFound',
              description: 'yourRequestedUrlWasNotFound',
              statusCode: 404,
            );
          case 422:
            return NetWorkErrorModel(
              title: 'badRequest',
              description: 'sorryThisIsAnIllegalRequest',
              statusCode: 422,
            );
          case 429:
            return NetWorkErrorModel(
              title: 'tooManyRequests',
              description: 'sorryYouHaveSentManyRequest',
              statusCode: 429,
            );
          case 500:
            return NetWorkErrorModel(
              title: 'serverError',
              description: 'sorrySomethingWentWrongFromOurServer',
              statusCode: 404,
            );
          case 503:
            return NetWorkErrorModel(
              title: 'serviceUnavailable',
              description: 'sorryTheServerIsUnavailable',
              statusCode: 503,
            );
          default:
            return NetWorkErrorModel(
              title: 'unexpectedError',
              description: 'sorryThisISAnUnexpectedError',
              statusCode: error.response.statusCode,
            );
        }
        break;
      default:
        return NetWorkErrorModel(
          title: 'unexpectedError',
          description: 'sorryThisISAnUnexpectedError',
          statusCode: null,
        );
    }
  }
}
