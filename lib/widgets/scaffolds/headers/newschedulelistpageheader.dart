import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class NewScheduleListPageHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const NewScheduleListPageHeader({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Row(
        children: <Widget>[
          Text('새로운 약속',
              style: AppFonts.interSemiBold(
                  color: AppColors.darkGray, fontsize: 20)),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: AppIcon()
              .getReloadIcon(color: AppColors.darkGray, height: 20, width: 20),
          onPressed: () {},
        ),
      ],
    );
  }
}
