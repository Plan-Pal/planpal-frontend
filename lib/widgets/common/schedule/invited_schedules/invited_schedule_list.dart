import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/schedule_service.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/widgets/common/schedule/invited_schedules/invited_schedule.dart';

class NewScheduleList extends StatelessWidget {
  final ScheduleService apiService = ScheduleService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.getInvitedSchedules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> schedules =
              List<Map<String, dynamic>>.from(
                  snapshot.data!['result']['schedules']);
          if (schedules.isEmpty) {
            return Container(
              height: 150.0,
              child: Center(
                child: Text(
                  '초대된 약속이\n없습니다...',
                  textAlign: TextAlign.center,
                  style: AppFonts.gemunuLibreRegular(
                      color: AppColors.lightGray, fontsize: 15),
                ),
              ),
            );
          } else {
            return Container(
              height: 200.0,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InvitedScheduleWidget(
                      backgroundColor: index % 2 == 0
                          ? AppColors.primaryLime
                          : AppColors.lightPurple,
                      title: schedule['title'],
                      time: schedule['appointed_time'],
                      location: schedule['place'],
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
