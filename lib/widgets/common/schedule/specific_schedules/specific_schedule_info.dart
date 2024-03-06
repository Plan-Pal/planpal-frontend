import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planpal_frontend/api/mock_api_service.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/widgets/common/user/simple_user_container.dart';

class SpecificScheduleInfo extends StatefulWidget {
  @override
  _SpecificScheduleInfoState createState() => _SpecificScheduleInfoState();
}

class _SpecificScheduleInfoState extends State<SpecificScheduleInfo> {
  late Future<Map<String, dynamic>> futureSchedule;

  @override
  void initState() {
    super.initState();
    futureSchedule = MockApiService().getSpecificSchedule(1);
  }

  Text lightStyle(String text) {
    return Text(
      text,
      style: AppFonts.interRegular(color: AppColors.darkGray, fontsize: 13),
    );
  }

  Text semiBoldStyle(String text) {
    return Text(
      text,
      style: AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 16),
    );
  }

  SizedBox space() {
    return SizedBox(height: 20);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: futureSchedule,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var schedule = snapshot.data?['result'];
          DateTime appointedTime = DateTime.parse(schedule['appointed_time']);
          String formattedDate =
              DateFormat('yyyy년 M월 d일 H시 m분').format(appointedTime);

          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  lightStyle('약속 제목'),
                  semiBoldStyle('${schedule['long_title']}'),
                  space(),
                  lightStyle('메모'),
                  semiBoldStyle('${schedule['memo']}'),
                  space(),
                  lightStyle('시간'),
                  semiBoldStyle(formattedDate),
                  space(),
                  lightStyle('장소'),
                  semiBoldStyle('${schedule['place']}'),
                  space(),
                  lightStyle('약속 참여자'),
                  SizedBox(height: 3),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: schedule['participating_user_list'].length,
                      itemBuilder: (context, index) {
                        var user = schedule['participating_user_list'][index];
                        return ProfileContainer(
                          nickname: user['user_nickname'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
