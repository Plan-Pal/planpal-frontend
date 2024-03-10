import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/storage_service.dart';
import 'package:planpal_frontend/api/user_auth_service.dart';
import 'package:planpal_frontend/models/jwt_model.dart';
import 'package:planpal_frontend/screens/caculation_screen.dart';
import 'package:planpal_frontend/screens/home_screen.dart';
import 'package:planpal_frontend/screens/login_screen.dart';
import 'package:planpal_frontend/screens/new_schedule_list_screen.dart';
import 'package:planpal_frontend/screens/profile_screen.dart';
import 'package:planpal_frontend/widgets/scaffolds/navigator/navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _userAuthService = UserAuthService();
  final _storageService = StorageService();

  Widget mainPage = const CustomNavigator(
    pages: [
      HomeScreen(),
      NewScheduleListScreen(),
      CalculationScreen(),
      ProfileScreen(),
    ],
  );

  @override
  void initState() {
    super.initState();
    moveScreen();
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) {
      if (isLogin) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => mainPage));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(mainPage: mainPage)));
      }
    });
  }

  Future<bool> checkLogin() async {
    JwtModel? savedJwt = await _storageService.readJwt();

    if (savedJwt == null) {
      return false;
    }

    try {
      JwtModel newToken = await _userAuthService.refresh(savedJwt: savedJwt);
      await _storageService.writeJwt(newToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
