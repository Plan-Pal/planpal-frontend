import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:planpal_frontend/models/jwt_model.dart';

class StorageService {
  static const storage = FlutterSecureStorage();

  final accessTokenKey = "access_token";
  final refreshTokenKey = "refresh_token";

  Future<JwtModel?> readJwt() async {
    String? accessToken = await storage.read(key: accessTokenKey);
    String? refreshToken = await storage.read(key: refreshTokenKey);

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return JwtModel(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<String?> readAccessToken() async {
    return await storage.read(key: accessTokenKey);
  }

  Future<void> writeJwt(JwtModel jwtModel) async {
    await storage.write(key: accessTokenKey, value: jwtModel.accessToken);
    await storage.write(key: refreshTokenKey, value: jwtModel.refreshToken);
  }
}
