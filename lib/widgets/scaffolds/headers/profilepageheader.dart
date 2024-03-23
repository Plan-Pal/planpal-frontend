import 'package:flutter/material.dart';
import 'package:planpal_frontend/models/user_model.dart';
import 'package:planpal_frontend/screens/setting_screen.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class ProfilePageHeader extends StatelessWidget implements PreferredSizeWidget {
  const ProfilePageHeader({required this.user, Key? key, required this.reload})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  final UserModel user;
  final VoidCallback reload;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      shape: const Border(
          bottom: BorderSide(color: AppColors.primaryPurple, width: 0)),
      backgroundColor: AppColors.primaryPurple,
      title: Row(
        children: <Widget>[
          Text('프로필',
              style:
                  AppFonts.interSemiBold(color: AppColors.white, fontsize: 20)),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: AppIcon()
              .getSettingIcon(color: AppColors.white, height: 20, width: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingScreen(user: user)),
            ).then((value) => reload());
          },
        ),
      ],
    );
  }
}
