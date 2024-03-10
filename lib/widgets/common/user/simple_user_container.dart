import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/icons.dart';

class ProfileContainer extends StatelessWidget {
  final String nickname;

  ProfileContainer({required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: 75,
        decoration: BoxDecoration(
          color: AppColors.middleLightGray,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Spacer(flex: 2),
            AppIcon()
                .getFace2Icon(color: AppColors.darkGray, width: 53, height: 53),
            Spacer(flex: 2),
            Text(nickname,
                style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
