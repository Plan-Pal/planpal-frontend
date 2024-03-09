import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/storage_service.dart';
import 'package:planpal_frontend/models/login_request.dart';
import 'package:planpal_frontend/models/jwt_model.dart';
import 'package:planpal_frontend/api/user_auth_service.dart';

import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/api/kakao_api.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.mainPage});

  final KakaoApi kakaoApi = KakaoApi();
  final UserAuthService userAuthService = UserAuthService();
  final StorageService storageService = StorageService();

  final Widget mainPage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextStyle whiteColorTextStyle = AppFonts.gemunuLibreRegular(
        color: AppColors.white, fontsize: screenHeight * 0.02);
    TextStyle limeColorTextStyle =
        const TextStyle(color: AppColors.primaryLime);

    return Scaffold(
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.only(top: screenHeight * 0.4),
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleText(whiteColorTextStyle, limeColorTextStyle, screenHeight),
            descriptionText(whiteColorTextStyle, limeColorTextStyle),
            Padding(padding: EdgeInsets.all(screenHeight * 0.1)),
            loginButton(context, mainPage),
            Padding(padding: EdgeInsets.all(screenHeight * 0.035)),
            versionText(whiteColorTextStyle)
          ],
        ),
      ),
    );
  }

  RichText titleText(TextStyle defaultTextStyle, TextStyle limeColorTextStyle,
      double screenHeight) {
    return RichText(
        text: TextSpan(
            style: defaultTextStyle.copyWith(fontSize: screenHeight * 0.08),
            children: <TextSpan>[
          const TextSpan(text: 'Plan'),
          TextSpan(
            text: 'Pal',
            style: limeColorTextStyle,
          )
        ]));
  }

  RichText descriptionText(
      TextStyle defaultTextStyle, TextStyle limeColorTextStyle) {
    return RichText(
        text: TextSpan(style: defaultTextStyle, children: <TextSpan>[
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

  IconButton loginButton(BuildContext context, Widget mainPage) {
    return IconButton(
        onPressed: () async {
          await kakaoApi.callKakaoLogin();

          LoginRequest loginInfo = await kakaoApi.getUserInfo();

          JwtModel jwtModel =
              await userAuthService.signUp(loginInfo: loginInfo);

          await storageService.writeJwt(jwtModel);
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => mainPage));
          }
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
