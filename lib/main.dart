import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:planpal_frontend/screens/home_screen.dart';
import 'package:planpal_frontend/screens/caculation_screen.dart';
import 'package:planpal_frontend/screens/new_schedule_list_screen.dart';
import 'package:planpal_frontend/screens/profile_screen.dart';
import 'package:planpal_frontend/themes/colors.dart';

import 'package:planpal_frontend/widgets/scaffolds/navigator/navigator.dart';

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
          primaryColor: AppColors.primaryPurple,
        ),
        home: const CustomNavigator(
          pages: [
            HomeScreen(),
            NewScheduleListScreen(),
            CalculationScreen(),
            ProfileScreen(),
          ],
        ));
  }
}
