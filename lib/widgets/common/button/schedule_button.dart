import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

Container scheduleEditButton() {
  return Container(
    width: 170,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text('약속 수정',
            style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
      ),
    ),
  );
}

Container scheduleDeleteButton() {
  return Container(
    width: 170,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text('약속 삭제',
            style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
      ),
    ),
  );
}

Container scheduleAddButton() {
  return Container(
    width: 330,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text('약속 생성 완료',
            style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
      ),
    ),
  );
}

Container scheduleAcceptButton() {
  return Container(
    width: 170,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryLime,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text('약속 수락',
            style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
      ),
    ),
  );
}

Container scheduleRefuseButton() {
  return Container(
    width: 170,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text('약속 거절',
            style: AppFonts.interRegular(color: AppColors.white, fontsize: 14)),
      ),
    ),
  );
}
