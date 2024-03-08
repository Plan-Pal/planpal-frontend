import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/widgets/common/calendar/edit_schedule_calendar/edit_schedule_calendar.dart';
import 'package:planpal_frontend/widgets/common/schedule/edit_schedule/change_personnel.dart';
import 'package:planpal_frontend/widgets/common/schedule/edit_schedule/text_inputer.dart';
import 'package:planpal_frontend/widgets/common/schedule/edit_schedule/time_picker.dart';

class EditSchedule extends StatefulWidget {
  @override
  _EditScheduleState createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  late Future<Map<String, dynamic>> futureSchedule;
  int _count = 0;
  bool _noLimit = false;

  @override
  void initState() {
    super.initState();
  }

  Text lightStyle(String text) {
    return Text(
      text,
      style: AppFonts.interRegular(color: AppColors.darkGray, fontsize: 15),
    );
  }

  SizedBox spaceshort() {
    return SizedBox(height: 5);
  }

  SizedBox spaceLong() {
    return SizedBox(height: 15);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              lightStyle('약속 제목'),
              spaceshort(),
              TextInputField(
                labelText: '약속 제목을 입력해주세요',
                height: 40,
                maxLength: 20,
              ),
              spaceLong(),
              lightStyle('짧은 제목'),
              spaceshort(),
              TextInputField(
                labelText: '요약된 약속 제목을 입력해주세요',
                height: 40,
                maxLength: 5,
              ),
              spaceLong(),
              lightStyle('메모'),
              spaceshort(),
              TextInputField(
                labelText: '메모를 입력해주세요',
                height: 100,
                maxLines: 100,
                maxLength: 100,
              ),
              spaceLong(),
              lightStyle('약속 날짜'),
              EditScheduleCalendar(
                onDateSelected: (date) {},
                schedules: [],
              ),
              SizedBox(height: 25),
              lightStyle('약속 시간'),
              spaceshort(),
              TimePicker(),
              spaceLong(),
              lightStyle('약속 장소'),
              spaceshort(),
              TextInputField(
                labelText: '약속 장소를 입력해주세요',
                height: 40,
                maxLength: 40,
              ),
              spaceLong(),
              LimitlessOption(),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
