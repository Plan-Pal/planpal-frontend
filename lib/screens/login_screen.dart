import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 350),
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
                text: const TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    children: <TextSpan>[
                  TextSpan(text: 'Plan'),
                  TextSpan(
                    text: 'Pal',
                    style: TextStyle(color: Color(0xFFA2C835)),
                  )
                ])),
            const Padding(padding: EdgeInsets.all(5)),
            RichText(
                text: const TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    children: <TextSpan>[
                  TextSpan(text: '약속의 '),
                  TextSpan(
                    text: '처음',
                    style: TextStyle(color: Color(0xFFA2C835)),
                  ),
                  TextSpan(text: '과 '),
                  TextSpan(
                    text: '끝',
                    style: TextStyle(color: Color(0xFFA2C835)),
                  ),
                  TextSpan(text: '을 한번에'),
                ])),
            const Padding(padding: EdgeInsets.all(100)),
            IconButton(
                onPressed: callKakaoLoginApi,
                icon: Image.asset('images/kakao_login_medium_wide.png')),
            const Padding(padding: EdgeInsets.all(5)),
            const Text(
              'Version 0.0.1',
              style: TextStyle(color: Colors.white, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

void callKakaoLoginApi() async {
  var temp = await KakaoSdk.origin;
  print('KakaoSdk=$temp');
  // 카카오 로그인 구현 예제

  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        getUserInfo();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}

void getUserInfo() async {
  try {
    User user = await UserApi.instance.me();
    print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
  }
}
