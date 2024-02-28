import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class CustomNavigator extends StatefulWidget {
  final List<Widget> pages;

  const CustomNavigator({super.key, required this.pages});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator> {
  int _currentIndex = 0;
  final AppIcon appIcon = AppIcon();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.darkGray,
          unselectedItemColor: AppColors.lightGray,
          selectedLabelStyle:
              AppFonts.interRegular(color: AppColors.darkGray, fontsize: 13),
          unselectedLabelStyle:
              AppFonts.interRegular(color: AppColors.darkGray, fontsize: 13),
          items: [
            BottomNavigationBarItem(
              icon: appIcon.getHomeIcon(
                  color: _currentIndex == 0
                      ? AppColors.darkGray
                      : AppColors.lightGray,
                  height: 32,
                  width: 32),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: appIcon.getCalendarIcon(
                  color: _currentIndex == 1
                      ? AppColors.darkGray
                      : AppColors.lightGray,
                  height: 32,
                  width: 32),
              label: '일정',
            ),
            BottomNavigationBarItem(
              icon: appIcon.getCoinIcon(
                  color: _currentIndex == 2
                      ? AppColors.darkGray
                      : AppColors.lightGray,
                  height: 32,
                  width: 32),
              label: '정산',
            ),
            BottomNavigationBarItem(
              icon: appIcon.getProfileIcon(
                  color: _currentIndex == 3
                      ? AppColors.darkGray
                      : AppColors.lightGray,
                  height: 32,
                  width: 32),
              label: '프로필',
            ),
          ],
        ),
      ),
    );
  }
}
