import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

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
    return const SizedBox(height: 5);
  }

  SizedBox spaceLong() {
    return const SizedBox(height: 15);
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
              spaceLong(),
              lightStyle('짧은 제목'),
              spaceLong(),
              lightStyle('메모'),
              spaceLong(),
              lightStyle('약속 날짜'),
              spaceLong(),
              lightStyle('약속 시간'),
              spaceLong(),
              lightStyle('약속 장소'),
              spaceLong(),
            ],
          ),
        ),
      ),
    );
  }
}
