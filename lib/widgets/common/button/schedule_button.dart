import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

Container scheduleEditButton() {
  return Container(
    width: 170,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightPurple,
        backgroundColor: AppColors.primaryPurple,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text('약속 수정',
          style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
    ),
  );
}

Container scheduleDeleteButton() {
  return Container(
    width: 170,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightRed,
        backgroundColor: AppColors.primaryRed,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text('약속 삭제',
          style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
    ),
  );
}
