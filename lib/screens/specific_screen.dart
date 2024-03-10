import 'package:flutter/material.dart';
import 'package:planpal_frontend/widgets/common/button/schedule_button.dart';
import 'package:planpal_frontend/widgets/common/schedule/specific_schedules/specific_schedule_info.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/specificschedulepageheader.dart';

class SpecificScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecificSchedulePageHeader(),
      body: Column(
        children: <Widget>[
          SpecificScheduleInfo(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              scheduleEditButton(),
              scheduleDeleteButton(),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
