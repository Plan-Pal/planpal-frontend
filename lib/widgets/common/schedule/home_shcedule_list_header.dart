import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:planpal_frontend/screens/add_schedule_screen.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class AnotherWidget extends StatefulWidget {
  final DateTime selectedDate;

  const AnotherWidget({super.key, required this.selectedDate});

  @override
  // ignore: library_private_types_in_public_api
  _AnotherWidgetState createState() => _AnotherWidgetState();
}

class _AnotherWidgetState extends State<AnotherWidget> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d일').format(widget.selectedDate);

    return Container(
      color: AppColors.extraLightGray,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '$formattedDate 약속',
                style: AppFonts.interSemiBold(
                    color: AppColors.darkGray, fontsize: 18),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 5),
              icon: AppIcon().getPlusIcon(
                  color: AppColors.darkGray, height: 20, width: 18),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddScheduleScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
