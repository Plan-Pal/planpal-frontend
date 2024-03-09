import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class AddSchedulePageHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AddSchedulePageHeader({Key? key}) : super(key: key);

  @override
  final Size preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: AppIcon()
                .getBackIcon(color: AppColors.darkGray, height: 15, width: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text('약속 만들기',
              style: AppFonts.interSemiBold(
                  color: AppColors.darkGray, fontsize: 20)),
          SizedBox(width: 50),
        ],
      ),
    );
  }
}
