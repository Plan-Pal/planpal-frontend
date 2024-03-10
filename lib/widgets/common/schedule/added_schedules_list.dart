import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/mock_api_service.dart';
import 'package:planpal_frontend/widgets/common/row/new_schedule_row.dart';
import 'package:planpal_frontend/widgets/common/schedule/simple_schedule_info.dart';

class AddedScheduleList extends StatefulWidget {
  const AddedScheduleList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<AddedScheduleList> {
  final MockApiService apiService = MockApiService();
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
          child: FutureBuilder<Map<String, dynamic>>(
            future: apiService.getAddedSchedules(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final schedules = snapshot.data!['result']['schedules'];
                final now = DateTime.now();
                final upcomingSchedules = schedules
                    .where((schedule) =>
                        DateTime.parse(schedule['appointed_time']).isAfter(now))
                    .toList();
                final pastSchedules = schedules
                    .where((schedule) =>
                        DateTime.parse(schedule['appointed_time'])
                            .isBefore(now))
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
                      title: schedule['title'],
                      time: schedule['appointed_time'],
                      location: schedule['place'],
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
