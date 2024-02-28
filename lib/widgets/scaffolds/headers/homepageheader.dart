import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class HomePageHeader extends StatefulWidget implements PreferredSizeWidget {
  HomePageHeader({Key? key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  DateTime selectedDate = DateTime(2024, 3);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: AppIcon().getLeftArrowIcon(
                  color: AppColors.darkGray, height: 17, width: 9),
              onPressed: () {
                setState(() {
                  selectedDate =
                      DateTime(selectedDate.year, selectedDate.month - 1);
                });
              },
            ),
            Text('${selectedDate.year}년 ${selectedDate.month}월',
                style: AppFonts.interSemiBold(
                    color: AppColors.darkGray, fontsize: 20)),
            IconButton(
              icon: AppIcon().getRightArrowIcon(
                  color: AppColors.darkGray, height: 17, width: 9),
              onPressed: () {
                setState(() {
                  selectedDate =
                      DateTime(selectedDate.year, selectedDate.month + 1);
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[],
    );
  }
}
