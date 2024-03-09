import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/icons.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String time;
  final String location;

  const InfoContainer(
      {super.key,
      required this.title,
      required this.time,
      required this.location});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(time);
    String formattedTime = DateFormat('yyyy년 M월 d일 H시 m분').format(dateTime);

    return Center(
      child: Container(
        width: screenWidth * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(children: [
              AppIcon().getTimeIcon(
                  color: AppColors.darkGray, height: 15, width: 15),
              const SizedBox(width: 5),
              Text(formattedTime),
            ]),
            const SizedBox(height: 2),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: AppIcon().getLocationIcon(
                      color: AppColors.darkGray, height: 15.0, width: 9.0),
                ),
                const SizedBox(width: 5),
                Text(location)
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}