import 'package:dio/dio.dart';

import 'package:planpal_frontend/models/login_request.dart';
import 'package:planpal_frontend/models/jwt_model.dart';

class UserAuthService {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://172.30.1.30:8080',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));

  Future<JwtModel> signUp({required LoginRequest loginInfo}) async {
    Response response = await dio.post("/signup", data: loginInfo.toMap());
    return JwtModel.fromMap(response.data);
  }

  Future<JwtModel> refresh({required JwtModel savedJwt}) async {
    Response response = await dio.post("/refresh", data: savedJwt.toMap());
    return JwtModel.fromMap(response.data);
  }
}
