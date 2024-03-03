import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class MonthAppBar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onMonthChanged;

  const MonthAppBar(
      {super.key, required this.selectedDate, required this.onMonthChanged});

  void _previousMonth() {
    onMonthChanged(DateTime(selectedDate.year, selectedDate.month - 1));
  }

  void _nextMonth() {
    onMonthChanged(DateTime(selectedDate.year, selectedDate.month + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: AppIcon().getLeftArrowIcon(
                  color: AppColors.darkGray, height: 17, width: 9),
              onPressed: _previousMonth,
            ),
            Text('${selectedDate.year}년 ${selectedDate.month}월',
                style: AppFonts.interSemiBold(
                    color: AppColors.darkGray, fontsize: 20)),
            IconButton(
              icon: AppIcon().getRightArrowIcon(
                  color: AppColors.darkGray, height: 17, width: 9),
              onPressed: _nextMonth,
            ),
          ],
        ),
      ),
    );
  }
}
