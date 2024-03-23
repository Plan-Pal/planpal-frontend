import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class AppliedFriendsListPageHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AppliedFriendsListPageHeader({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text('친구 신청 목록',
          style:
              AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 20)),
      leading: IconButton(
        icon: AppIcon()
            .getBackIcon(color: AppColors.darkGray, height: 15, width: 18),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: const <Widget>[],
    );
  }
}
