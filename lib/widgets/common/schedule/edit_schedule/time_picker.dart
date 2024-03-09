import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class TimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 70,
            child: CupertinoPicker(
              diameterRatio: 1.5,
              offAxisFraction: -0.5,
              itemExtent: 50,
              onSelectedItemChanged: (int index) {},
              children: List<Widget>.generate(24, (int index) {
                return Center(
                    child: Text(
                  '$index시',
                  style: AppFonts.interLight(
                      color: AppColors.darkGray, fontsize: 13),
                ));
              }),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 70,
            child: CupertinoPicker(
              diameterRatio: 1.5,
              offAxisFraction: -0.5,
              itemExtent: 50,
              onSelectedItemChanged: (int index) {},
              children: List<Widget>.generate(12, (int index) {
                return Center(
                    child: Text(
                  '${index * 5}분',
                  style: AppFonts.interLight(
                      color: AppColors.darkGray, fontsize: 13),
                ));
              }),
            ),
          ),
        ),
      ],
    );
  }
}
