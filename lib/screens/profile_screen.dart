import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/profile_service.dart';
import 'package:planpal_frontend/models/friend_model.dart';
import 'package:planpal_frontend/models/friend_request_model.dart';
import 'package:planpal_frontend/models/user_model.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/profilepageheader.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
  UserModel _user = UserModel(nickname: '닉네임', tagId: '0000', iconId: 1);
  List<ListItemModel> _friendList = [];
  List<ListItemModel> _friendRequestList = [];
  final AppIcon appIcon = AppIcon();
  final ProfileService profileService = ProfileService();

  void onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFromServer();
  }

  Future<void> _fetchFromServer() async {
    UserModel fetchedUserModel = await profileService.getUserInfo();
    List<FriendModel> fetchedFriendModelList =
        await profileService.getFriendList();
    List<FriendRequestModel> fetchedFriendRequestModelList =
        await profileService.getFriendRequestList();
    setState(() {
      _user = fetchedUserModel;
      _friendList = fetchedFriendModelList
          .map((friend) => ListItemModel(
              id: friend.userId,
              nickname: friend.nickname,
              tagId: friend.tagId,
              iconId: friend.iconId))
          .toList();
      _friendRequestList = fetchedFriendRequestModelList
          .map((request) => ListItemModel(
              id: request.friendRequestId,
              nickname: request.nickname,
              tagId: request.tagId,
              iconId: request.iconId))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const ProfilePageHeader(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: profileContainer(screenWidth, _user, _friendList.length),
          ),
          Positioned(
              top: 80,
              left: 0,
              child: SizedBox(
                  width: screenWidth,
                  height: screenHeight - 210,
                  child: friendContainer(context, screenWidth, screenHeight,
                      _friendList, _friendRequestList)))
        ],
      ),
    );
  }

  Container profileContainer(
      double screenWidth, UserModel user, int friendNum) {
    Widget userIcon = getUserIcon(user.iconId, 0);

    return Container(
      color: AppColors.primaryPurple,
      width: screenWidth,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userIcon,
            const Padding(padding: EdgeInsets.all(8)),
            userTextBox(user, friendNum)
          ]),
    );
  }

  SizedBox userTextBox(UserModel user, int friendNum) {
    TextStyle whiteInterSemiBoldTextStyle =
        AppFonts.interSemiBold(color: AppColors.white, fontsize: 19);

    return SizedBox(
      height: 63,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: userInfoTextList(user, whiteInterSemiBoldTextStyle),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  friendInfoTextList(friendNum, whiteInterSemiBoldTextStyle),
            )
          ]),
    );
  }

  List<Widget> userInfoTextList(
      UserModel user, TextStyle whiteInterSemiBoldTextStyle) {
    return [
      Text(
        user.nickname,
        style: whiteInterSemiBoldTextStyle,
      ),
      const Padding(padding: EdgeInsets.all(5)),
      Text('#${user.tagId}',
          style: whiteInterSemiBoldTextStyle.copyWith(fontSize: 16))
    ];
  }

  List<Widget> friendInfoTextList(
      int friendNum, TextStyle whiteInterSemiBoldTextStyle) {
    return [
      Text('현재 약속 가능한 친구',
          style: AppFonts.interLight(color: AppColors.white, fontsize: 15)),
      const Padding(padding: EdgeInsets.all(4)),
      Text('$friendNum명', style: whiteInterSemiBoldTextStyle)
    ];
  }

  Container friendContainer(
      BuildContext context,
      double screenWidth,
      double screenHeight,
      List<ListItemModel> friendList,
      List<ListItemModel> friendRequestList) {
    return Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(children: [
          friendTabMenu(),
          const Padding(padding: EdgeInsets.all(15)),
          friendTabScreen(context, screenHeight, friendList, friendRequestList)
        ]));
  }

  Row friendTabMenu() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TabItem(
          text: '친구 목록',
          isSelected: _selectedIndex == 0,
          onPressed: () {
            onTabSelected(0);
          }),
      TabItem(
          text: '친구 요청 목록',
          isSelected: _selectedIndex == 1,
          onPressed: () {
            onTabSelected(1);
          }),
      appIcon.getAddFriendsIcon(
          color: AppColors.darkGray, height: 22, width: 22)
    ]);
  }

  Expanded friendTabScreen(BuildContext context, double screenHeight,
      List<ListItemModel> friendList, List<ListItemModel> friendRequestList) {
    List<Widget> listViews = [
      TabScreen(itemList: friendList, mode: 0),
      TabScreen(itemList: friendRequestList, mode: 1)
    ];

    return Expanded(
        child: SingleChildScrollView(
            child: SizedBox(
      height: screenHeight - 343,
      child: listViews[_selectedIndex],
    )));
  }

  void showAcceptDialog(BuildContext context, String friendName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('친구 추가'),
          content: Text('$friendName을/를 친구로 추가하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                // 친구 추가 api 호출
                Navigator.pop(context);
              },
              child: Text('승낙'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }
}

class TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const TabItem(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: isSelected
                ? const Border(bottom: BorderSide(color: AppColors.darkGray))
                : const Border(bottom: BorderSide.none)),
        child: Text(
          text,
          style: AppFonts.interLight(color: AppColors.darkGray, fontsize: 20),
        ),
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final List<ListItemModel> itemList;
  final int mode;

  const TabScreen({super.key, required this.itemList, required this.mode});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return listItem(context, index, itemList[index], mode);
      },
    );
  }

  Container listItem(
      BuildContext context, int index, ListItemModel user, int mode) {
    final grayInterSemiBoldTextStyle =
        AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 20);
    const borderSide = BorderSide(width: 0.5, color: AppColors.gray);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: borderSide,
          top: index == 0 ? borderSide : BorderSide.none,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: getUserIcon(user.iconId, 1),
        title: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            user.nickname,
            style: grayInterSemiBoldTextStyle,
          ),
          const Padding(padding: EdgeInsets.all(3)),
          Text(
            '#${user.tagId}',
            style: grayInterSemiBoldTextStyle.copyWith(fontSize: 17),
          ),
        ]),
        trailing: button(mode),
      ),
    );
  }

  TextButton button(int mode) {
    List<Color> colorList = [AppColors.primaryRed, AppColors.primaryPurple];
    List<String> stringList = ['삭제', '승낙'];

    return TextButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorList[mode],
        ),
        child: Text(
          stringList[mode],
          style: AppFonts.interLight(color: AppColors.white, fontsize: 15),
        ),
      ),
    );
  }
}

class ListItemModel {
  late BigInt id;
  late String nickname;
  late String tagId;
  late int iconId;

  ListItemModel({
    required this.id,
    required this.nickname,
    required this.tagId,
    required this.iconId,
  });
}

Widget getUserIcon(int iconId, int mode) {
  final AppIcon appIcon = AppIcon();
  List<Color> colorList = [AppColors.white, AppColors.darkGray];
  Widget userIcon;
  switch (iconId) {
    case 1:
      userIcon =
          appIcon.getFace1Icon(color: colorList[mode], height: 63, width: 63);
      break;
    case 2:
      userIcon =
          appIcon.getFace2Icon(color: colorList[mode], height: 63, width: 63);
      break;
    case 3:
      userIcon =
          appIcon.getFace3Icon(color: colorList[mode], height: 63, width: 63);
      break;
    case 4:
      userIcon =
          appIcon.getFace4Icon(color: colorList[mode], height: 63, width: 63);
      break;
    case 5:
      userIcon =
          appIcon.getFace5Icon(color: colorList[mode], height: 63, width: 63);
      break;
    case 6:
      userIcon =
          appIcon.getFace6Icon(color: colorList[mode], height: 63, width: 63);
      break;
    default:
      userIcon =
          appIcon.getFace1Icon(color: colorList[mode], height: 63, width: 63);
      break;
  }
  return userIcon;
}
