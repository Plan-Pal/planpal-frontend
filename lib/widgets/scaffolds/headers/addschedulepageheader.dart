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
    return AppBar(
      centerTitle: true,
      title: Text('약속 만들기',
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
