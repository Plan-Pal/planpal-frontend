import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/widgets/common/schedule/added_schedules_list.dart';
import 'package:planpal_frontend/widgets/common/schedule/invited_schedules/invited_schedule_list.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/newschedulelistpageheader.dart';

class NewScheduleListScreen extends StatefulWidget {
  const NewScheduleListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewScheduleListScreenState createState() => _NewScheduleListScreenState();
}

class _NewScheduleListScreenState extends State<NewScheduleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const NewScheduleListPageHeader().preferredSize,
        child: const SafeArea(
          child: NewScheduleListPageHeader(),
        ),
      ),
      backgroundColor: AppColors.extraLightGray,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: NewScheduleList(),
          ),
          Expanded(
            child: AddedScheduleList(),
          ),
        ],
      ),
    );
  }
}
