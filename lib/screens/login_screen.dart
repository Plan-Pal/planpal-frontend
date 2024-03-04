import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:planpal_frontend/models/login_request.dart';
import 'package:planpal_frontend/models/login_response.dart';
import 'package:planpal_frontend/api/user_api_service.dart';

import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/api/kakao_api.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final KakaoApi kakaoApi = KakaoApi();
  final UserApiService userProvider = UserApiService();
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextStyle defaultTextStyle = AppFonts.gemunuLibreRegular(
        color: Colors.white, fontsize: screenHeight * 0.02);

    return Scaffold(
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.only(top: screenHeight * 0.4),
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            planpalText(defaultTextStyle, screenHeight),
            descriptionText(defaultTextStyle),
            Padding(padding: EdgeInsets.all(screenHeight * 0.1)),
            loginButton(),
            Padding(padding: EdgeInsets.all(screenHeight * 0.035)),
            versionText(defaultTextStyle)
          ],
        ),
      ),
    );
  }

  RichText planpalText(TextStyle defaultTextStyle, double screenHeight) {
    return RichText(
        text: TextSpan(
            style: defaultTextStyle.copyWith(fontSize: screenHeight * 0.08),
            children: const <TextSpan>[
          TextSpan(text: 'Plan'),
          TextSpan(
            text: 'Pal',
            style: TextStyle(color: AppColors.primaryLime),
          )
        ]));
  }

  RichText descriptionText(TextStyle defaultTextStyle) {
    return RichText(
        text: TextSpan(style: defaultTextStyle, children: const <TextSpan>[
      TextSpan(text: '약속의 '),
      TextSpan(
        text: '처음',
        style: TextStyle(color: AppColors.primaryLime),
      ),
      TextSpan(text: '과 '),
      TextSpan(
        text: '끝',
        style: TextStyle(color: AppColors.primaryLime),
      ),
      TextSpan(text: '을 한번에'),
    ]));
  }

  IconButton loginButton() {
    return IconButton(
        onPressed: () async {
          if (!await kakaoApi.callKakaoLogin()) {
            return;
          }

          LoginRequest loginInfo = await kakaoApi.getUserInfo();
          LoginResponse loginResult = await userProvider.signUp(loginInfo);
          // 수정 필요
          await storage.write(
              key: 'accessToken', value: loginResult.accessToken);
          await storage.write(
              key: 'refreshToken', value: loginResult.refreshToken);
        },
        icon: Image.asset('images/kakao_login_medium_wide.png'));
  }

  Text versionText(TextStyle defaultTextStyle) {
    return Text(
      'Version 0.0.1',
      style: defaultTextStyle,
    );
  }
}
