import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:intl/intl.dart';
import 'package:planpal_frontend/themes/icons.dart';

class InvitedScheduleWidget extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String time;
  final String location;

  InvitedScheduleWidget({
    required this.backgroundColor,
    required this.title,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time);
    String formattedTime = DateFormat('M월 d일 HH시').format(dateTime);

    return Align(
      child: Stack(
        children: <Widget>[
          Container(
            width: 230.0,
            height: 150.0,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(formattedTime,
                    style: AppFonts.interSemiBold(
                        color: AppColors.white, fontsize: 15)),
                SizedBox(height: 3.0),
                Text(title,
                    style: AppFonts.interSemiBold(
                        color: AppColors.white, fontsize: 20)),
              ],
            ),
          ),
          Positioned(
            bottom: -31,
            right: 18,
            child: ClipRect(
              child: AppIcon()
                  .getFace1Icon(color: AppColors.white, height: 90, width: 90),
            ),
          ),
        ],
      ),
    );
  }
}
