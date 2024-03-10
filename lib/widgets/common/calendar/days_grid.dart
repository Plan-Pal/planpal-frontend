import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class DaysGrid extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final List<Map<String, dynamic>> schedules;

  const DaysGrid({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.schedules,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DaysGridState createState() => _DaysGridState();
}

class _DaysGridState extends State<DaysGrid> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 0)
            .day;
    int weekDayOfFirstDay =
        DateTime(widget.selectedDate.year, widget.selectedDate.month, 1)
                .weekday %
            7;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: daysInMonth + weekDayOfFirstDay,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio:
              (daysInMonth + weekDayOfFirstDay) <= 35 ? 0.6 : 0.72,
        ),
        itemBuilder: (context, index) {
          if (index < weekDayOfFirstDay) {
            return Container();
          }
          final date = DateTime(widget.selectedDate.year,
              widget.selectedDate.month, index - weekDayOfFirstDay + 1);
          final isSelected = date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;
          final isWeekend = date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday;

          List<String> shortTitles = [];
          for (var schedule in widget.schedules) {
            final scheduleDate = DateTime.parse(schedule['appointed_time']);
            if (scheduleDate.year == date.year &&
                scheduleDate.month == date.month &&
                scheduleDate.day == date.day) {
              shortTitles.add(schedule['short_title']);
            }
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: isWeekend ? AppColors.extraLightPurple : AppColors.white,
                border: Border.all(
                  color: isSelected ? AppColors.darkGray : AppColors.lightGray,
                  width: isSelected ? 0.5 : 0.3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(top: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${date.day}',
                      style: AppFonts.interExtraLight(
                          color: AppColors.darkGray, fontsize: 12)),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 1.0),
                      itemCount: shortTitles.length,
                      itemBuilder: (context, index) => Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            shortTitles[index],
                            style: AppFonts.interExtraLight(
                                color: AppColors.white, fontsize: 10.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
