import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/icons.dart';

class InviteParticipantsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: 75,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.middleLightGray,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon()
                .getPlusIcon(color: AppColors.darkGray, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
