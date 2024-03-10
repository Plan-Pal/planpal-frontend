import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/storage_service.dart';
import 'package:planpal_frontend/api/user_auth_service.dart';

import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/api/kakao_api.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.mainPage});

  final KakaoApi kakaoApi = KakaoApi();
  final UserAuthService userAuthService = UserAuthService();
  final StorageService storageService = StorageService();

  final TextStyle whiteColorTextStyle =
      AppFonts.gemunuLibreRegular(color: AppColors.white, fontsize: 20);
  final TextStyle limeColorTextStyle =
      const TextStyle(color: AppColors.primaryLime);

  final Widget mainPage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.only(top: screenHeight * 0.4),
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleText(screenHeight),
            descriptionText(screenHeight),
            SizedBox(height: screenHeight * 0.1),
            loginButton(context),
            SizedBox(height: screenHeight * 0.035),
            versionText(screenHeight)
          ],
        ),
      ),
    );
  }

  RichText titleText(double screenHeight) {
    return RichText(
        text: TextSpan(
            style: whiteColorTextStyle.copyWith(fontSize: screenHeight * 0.08),
            children: [
          const TextSpan(text: 'Plan'),
          TextSpan(
            text: 'Pal',
            style: limeColorTextStyle,
          )
        ]));
  }

  RichText descriptionText(double screenHeight) {
    return RichText(
        text: TextSpan(
            style: whiteColorTextStyle.copyWith(fontSize: screenHeight * 0.02),
            children: [
          const TextSpan(text: '약속의 '),
          TextSpan(
            text: '처음',
            style: limeColorTextStyle,
          ),
          const TextSpan(text: '과 '),
          TextSpan(
            text: '끝',
            style: limeColorTextStyle,
          ),
          const TextSpan(text: '을 한번에'),
        ]));
  }

  IconButton loginButton(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await _login(context);
        },
        icon: Image.asset('images/kakao_login_medium_wide.png'));
  }

  Text versionText(double screenHeight) {
    return Text(
      'Version 0.0.1',
      style: whiteColorTextStyle.copyWith(fontSize: screenHeight * 0.02),
    );
  }

  Future<void> _login(BuildContext context) async {
    try {
      final isLogIn = await _callLoginApi();
      if (isLogIn && context.mounted) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => mainPage));
      } else {
        throw Exception('로그인 실패');
      }
    } catch (e) {
      print('로그인 실패');
    }
  }

  Future<bool> _callLoginApi() async {
    await kakaoApi.callKakaoLogin();
    final loginInfo = await kakaoApi.getUserInfo();

    final jwtModel = await userAuthService.signUp(loginInfo: loginInfo);
    await storageService.writeJwt(jwtModel);

    return true;
  }
}
