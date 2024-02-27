import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '0dc9cce5c664b187ff3e641c6fb94334');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plan Pal',
      theme: ThemeData(
        primaryColor: Color(0xff4b2b80),
      ),
      home: const LoginScreen(),
    );
  }
}
