import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class SearchFriendsPageHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchFriendsPageHeader({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('친구 찾기',
          style:
              AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 20)),
      leading: IconButton(
        icon: AppIcon()
            .getBackIcon(color: AppColors.darkGray, height: 15, width: 18),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: AppIcon()
              .getMailIcon(color: AppColors.darkGray, height: 22, width: 25),
          onPressed: () {},
        ),
      ],
    );
  }
}
