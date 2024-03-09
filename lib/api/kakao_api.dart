import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:planpal_frontend/models/login_request.dart';

class KakaoApi {
  Future<void> callKakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          rethrow;
        }

        await UserApi.instance.loginWithKakaoAccount();
      }
    } else {
      await UserApi.instance.loginWithKakaoAccount();
    }
  }

  Future<LoginRequest> getUserInfo() async {
    User user = await UserApi.instance.me();
    return LoginRequest(
        kakaoId: user.id, nickname: user.kakaoAccount?.profile?.nickname);
  }
}
