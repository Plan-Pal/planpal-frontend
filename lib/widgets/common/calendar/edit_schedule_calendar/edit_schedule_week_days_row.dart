import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class EditScheduleWeekDaysRow extends StatelessWidget {
  final _weekDays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _weekDays
          .map(
            (day) => Expanded(
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Center(
                    child: Text(day,
                        style: AppFonts.interLight(
                            color: AppColors.darkGray, fontsize: 14)),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
