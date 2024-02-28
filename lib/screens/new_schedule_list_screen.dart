import 'package:flutter/material.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/newschedulelistpageheader.dart';

class NewScheduleListScreen extends StatelessWidget {
  const NewScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NewScheduleListPageHeader(),
      body: Center(
        child: Text('약속 페이지'),
      ),
    );
  }
}
