import 'package:base_api_with_dio/models/user_model.dart';
import 'package:base_api_with_dio/services/base_api.dart';

class UserService extends BaseApi {
  objectType(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  String objectUrlName() {
    return 'users';
  }
}
