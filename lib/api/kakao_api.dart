import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:planpal_frontend/models/login_request.dart';

class KakaoApi {
  Future<bool> callKakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        return true;
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
      }
    }

    try {
      await UserApi.instance.loginWithKakaoAccount();
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<LoginRequest> getUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      return LoginRequest(
          kakaoId: user.id, nickname: user.kakaoAccount?.profile?.nickname);
    } catch (error) {
      rethrow;
    }
  }
}
