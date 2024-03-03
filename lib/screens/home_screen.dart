import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/mock_api_service.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/widgets/common/calendar/home_calendar.dart';
import 'package:planpal_frontend/widgets/common/schedule/simple_schedule_info.dart';
import 'package:planpal_frontend/widgets/common/schedule/home_shcedule_list_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  List<InfoContainer> infoContainers = [];
  List<Map<String, dynamic>> schedules = [];

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSetSchedules();
  }

  Future<void> _fetchAndSetSchedules() async {
    final apiService = MockApiService();
    final scheduleData = await apiService.getSchedules();
    final scheduleList = scheduleData['result']['schedules'] as List;

    setState(() {
      infoContainers = scheduleList.map((schedule) {
        return InfoContainer(
          title: schedule['title'],
          time: schedule['appointed_time'],
          location: schedule['place'],
        );
      }).toList();
      schedules = List<Map<String, dynamic>>.from(scheduleList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.extraLightGray,
      body: SafeArea(
        child: ListView.builder(
          itemCount: infoContainers.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return CustomCalendar(
                onDateSelected: _onDateSelected,
                schedules: schedules,
              );
            } else if (index == 1) {
              return AnotherWidget(selectedDate: _selectedDate);
            } else {
              DateTime scheduleTime =
                  DateTime.parse(infoContainers[index - 2].time);
              if (_selectedDate.year == scheduleTime.year &&
                  _selectedDate.month == scheduleTime.month &&
                  _selectedDate.day == scheduleTime.day) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: infoContainers[index - 2],
                );
              } else {
                return Container();
              }
            }
          },
        ),
      ),
    );
  }
}
