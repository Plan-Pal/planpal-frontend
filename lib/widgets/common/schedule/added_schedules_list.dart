import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/schedule_service.dart';
import 'package:planpal_frontend/models/schedule_model/all_schedule_list_model.dart';
import 'package:planpal_frontend/widgets/common/row/new_schedule_row.dart';
import 'package:planpal_frontend/widgets/common/schedule/simple_schedule_info.dart';

class AddedScheduleList extends StatefulWidget {
  const AddedScheduleList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<AddedScheduleList> {
  final ScheduleService apiService = ScheduleService();
  int _selectedSection = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionSelector(
          onSectionSelected: (index) {
            setState(() {
              _selectedSection = index;
            });
          },
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: FutureBuilder<AllScheduleListModel>(
            future: apiService.getSchedules(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final schedules = snapshot.data!.schedules;
                final now = DateTime.now();
                final pastSchedules = schedules
                    .where((schedule) => schedule.appointedTime.isAfter(now))
                    .toList();
                final upcomingSchedules = schedules
                    .where((schedule) => schedule.appointedTime.isBefore(now))
                    .toList();
                final displaySchedules =
                    _selectedSection == 1 ? upcomingSchedules : pastSchedules;
                return ListView.separated(
                  itemCount: displaySchedules.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (context, index) {
                    final schedule = displaySchedules[index];
                    return InfoContainer(
                      scheduleId: schedule.scheduleId,
                      title: schedule.title,
                      time: schedule.appointedTime.toIso8601String(),
                      location: schedule.place,
                    );
                  },
                );
              }
            },
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
