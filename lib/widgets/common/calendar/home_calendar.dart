import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/widgets/common/calendar/days_grid.dart';
import 'package:planpal_frontend/widgets/common/calendar/month_app_bar.dart';
import 'package:planpal_frontend/widgets/common/calendar/week_days_row.dart';

class CustomCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final List<Map<String, dynamic>> schedules;

  CustomCalendar({required this.onDateSelected, required this.schedules});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();

  void _onMonthChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          MonthAppBar(
            selectedDate: _selectedDate,
            onMonthChanged: _onMonthChanged,
          ),
          WeekDaysRow(),
          DaysGrid(
            selectedDate: _selectedDate,
            onDateSelected: widget.onDateSelected,
            schedules: widget.schedules,
          ),
        ],
      ),
    );
  }
}
