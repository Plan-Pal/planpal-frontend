import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/widgets/common/schedule/edit_schedule/edit_schedule.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/addschedulepageheader.dart';

class AddScheduleScreen extends StatelessWidget {
  const AddScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: AddSchedulePageHeader(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            EditSchedule(),
          ],
        ),
      ),
    );
  }
}
