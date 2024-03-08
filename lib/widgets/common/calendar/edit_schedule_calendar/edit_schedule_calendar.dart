import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/widgets/common/calendar/edit_schedule_calendar/edit_schedule_days_grid.dart';
import 'package:planpal_frontend/widgets/common/calendar/edit_schedule_calendar/edit_schedule_month_app_bar.dart';
import 'package:planpal_frontend/widgets/common/calendar/edit_schedule_calendar/edit_schedule_week_days_row.dart';

class EditScheduleCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final List<Map<String, dynamic>> schedules;

  EditScheduleCalendar({required this.onDateSelected, required this.schedules});

  @override
  _EditScheduleCalendarState createState() => _EditScheduleCalendarState();
}

class _EditScheduleCalendarState extends State<EditScheduleCalendar> {
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
          EditScheduleMonthAppBar(
            selectedDate: _selectedDate,
            onMonthChanged: _onMonthChanged,
          ),
          EditScheduleWeekDaysRow(),
          EditScheduleDaysGrid(
            selectedDate: _selectedDate,
            onDateSelected: widget.onDateSelected,
          ),
        ],
      ),
    );
  }
}
