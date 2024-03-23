import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/profile_service.dart';
import 'package:planpal_frontend/models/user_model.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/settingpageheader.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({required this.user, super.key});
  final UserModel user;

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final borderSide = const BorderSide(width: 0.5, color: AppColors.gray);
  late int _iconId;
  late String _nickname;

  @override
  void initState() {
    super.initState();
    _iconId = widget.user.iconId;
    _nickname = widget.user.nickname;
  }

  void _updateIconId(int iconId) {
    setState(() {
      _iconId = iconId;
    });
  }

  void _updateNickname(String nickname) {
    if (nickname.isEmpty) {
      nickname = widget.user.nickname;
    }

    setState(() {
      _nickname = nickname;
    });
  }

  void _updateUser() {
    setState(() {
      widget.user.iconId = _iconId;
      widget.user.nickname = _nickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const SettingPageHeader(),
        body: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [userInfo(), saveButton(screenWidth)],
          ),
        ));
  }

  Column userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('프로필 선택',
            style: AppFonts.interSemiBold(
                color: AppColors.darkGray, fontsize: 20)),
        const Padding(padding: EdgeInsets.all(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getUserIcon(_iconId, 90)],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabItem(
                  iconId: 1,
                  isSelected: _iconId == 1,
                  onPressed: () => _updateIconId(1)),
              TabItem(
                  iconId: 2,
                  isSelected: _iconId == 2,
                  onPressed: () => _updateIconId(2)),
              TabItem(
                  iconId: 3,
                  isSelected: _iconId == 3,
                  onPressed: () => _updateIconId(3)),
              TabItem(
                  iconId: 4,
                  isSelected: _iconId == 4,
                  onPressed: () => _updateIconId(4)),
              TabItem(
                  iconId: 5,
                  isSelected: _iconId == 5,
                  onPressed: () => _updateIconId(5)),
              TabItem(
                  iconId: 6,
                  isSelected: _iconId == 6,
                  onPressed: () => _updateIconId(6))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          decoration: BoxDecoration(
            border: Border(bottom: borderSide, top: borderSide),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('이름 변경',
                style: AppFonts.interSemiBold(
                    color: AppColors.darkGray, fontsize: 18)),
            TextInputField(nickname: _nickname, onSubmitted: _updateNickname)
          ]),
        )
      ],
    );
  }

  Container saveButton(double screenWidth) {
    final changed =
        (widget.user.iconId != _iconId) || (widget.user.nickname != _nickname);

    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextButton(
          onPressed: () async {
            if (changed) {
              await ProfileService().updateUser(_nickname, _iconId);
              _updateUser();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('변경 내용이 저장되었습니다'),
                  duration: Duration(seconds: 3),
                ));
              }
            }
          },
          style: TextButton.styleFrom(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: screenWidth - 268, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor:
                  changed ? AppColors.primaryPurple : AppColors.lightPurple),
          child: Text(
            '설정 저장',
            style: AppFonts.interSemiBold(color: AppColors.white, fontsize: 15),
          )),
    );
  }
}

class TabItem extends StatelessWidget {
  final int iconId;
  final bool isSelected;
  final VoidCallback onPressed;

  const TabItem(
      {super.key,
      required this.iconId,
      required this.onPressed,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: isSelected
                    ? const BorderSide(color: AppColors.darkGray)
                    : BorderSide.none)),
        child: getUserIcon(iconId, 40),
      ),
    );
  }
}

class TextInputField extends StatefulWidget {
  final String nickname;
  final ValueSetter<String> onSubmitted;

  const TextInputField(
      {super.key, required this.nickname, required this.onSubmitted});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        controller: _controller,
        maxLines: 1,
        maxLength: 10,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            label: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(widget.nickname,
                  style: AppFonts.interSemiBold(
                      color: AppColors.lightGray, fontsize: 18))
            ]),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            counterText: '',
            alignLabelWithHint: true,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
        style: AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 18),
        onSubmitted: (value) => {widget.onSubmitted(value)},
      ),
    );
  }
}

Widget getUserIcon(int iconId, double size) {
  final AppIcon appIcon = AppIcon();
  const color = AppColors.darkGray;

  Widget userIcon;
  switch (iconId) {
    case 1:
      userIcon = appIcon.getFace1Icon(color: color, height: size, width: size);
      break;
    case 2:
      userIcon = appIcon.getFace2Icon(color: color, height: size, width: size);
      break;
    case 3:
      userIcon = appIcon.getFace3Icon(color: color, height: size, width: size);
      break;
    case 4:
      userIcon = appIcon.getFace4Icon(color: color, height: size, width: size);
      break;
    case 5:
      userIcon = appIcon.getFace5Icon(color: color, height: size, width: size);
      break;
    case 6:
      userIcon = appIcon.getFace6Icon(color: color, height: size, width: size);
      break;
    default:
      userIcon = appIcon.getFace1Icon(color: color, height: size, width: size);
      break;
  }
  return userIcon;
}
