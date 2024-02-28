import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class SendMoneyPageHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const SendMoneyPageHeader({Key? key})
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
          Text('보내야 할 금액',
              style: AppFonts.interSemiBold(
                  color: AppColors.darkGray, fontsize: 20)),
        ],
      ),
    );
  }
}
