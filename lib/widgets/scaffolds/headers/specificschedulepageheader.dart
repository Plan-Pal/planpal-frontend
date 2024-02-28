import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class SpecificSchedulePageHeader extends StatefulWidget
    implements PreferredSizeWidget {
  final int year;
  final int month;
  final int day;

  const SpecificSchedulePageHeader({
    Key? key,
    required this.year,
    required this.month,
    required this.day,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  // ignore: library_private_types_in_public_api
  _SpecificSchedulePageHeaderState createState() =>
      _SpecificSchedulePageHeaderState();
}

class _SpecificSchedulePageHeaderState
    extends State<SpecificSchedulePageHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('${widget.year}년 ${widget.month}월 ${widget.day}일 약속',
          style:
              AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 20)),
      leading: IconButton(
        icon: AppIcon()
            .getBackIcon(color: AppColors.darkGray, height: 15, width: 18),
        onPressed: () {},
      ),
      actions: const <Widget>[],
    );
  }
}
