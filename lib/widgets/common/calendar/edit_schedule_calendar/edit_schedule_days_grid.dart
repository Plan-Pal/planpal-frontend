import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class EditScheduleDaysGrid extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const EditScheduleDaysGrid({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  _EditScheduleDaysGridState createState() => _EditScheduleDaysGridState();
}

class _EditScheduleDaysGridState extends State<EditScheduleDaysGrid> {
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
          childAspectRatio: (daysInMonth + weekDayOfFirstDay) <= 35 ? 1 : 1.223,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
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

          return InkWell(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: isSelected
                  ? BoxDecoration(
                      color: AppColors.primaryPurple,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Text('${date.day}',
                  style: AppFonts.interExtraLight(
                      color: isSelected ? AppColors.white : AppColors.darkGray,
                      fontsize: 12)),
            ),
          );
        },
      ),
    );
  }
}
