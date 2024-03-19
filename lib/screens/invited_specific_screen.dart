import 'package:flutter/material.dart';
import 'package:planpal_frontend/widgets/common/button/schedule_button.dart';
import 'package:planpal_frontend/widgets/common/schedule/specific_schedules/specific_schedule_info.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/specificschedulepageheader.dart';

class InvitedSpecificScheduleScreen extends StatelessWidget {
  final int scheduleId;

  InvitedSpecificScheduleScreen({required this.scheduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecificSchedulePageHeader(),
      body: Column(
        children: <Widget>[
          SpecificScheduleInfo(scheduleId: scheduleId),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              scheduleAcceptButton(),
              scheduleRefuseButton(),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
