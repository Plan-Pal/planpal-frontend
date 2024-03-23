import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/profile_service.dart';
import 'package:planpal_frontend/models/friend_model.dart';
import 'package:planpal_frontend/models/friend_request_model.dart';
import 'package:planpal_frontend/models/user_model.dart';
import 'package:planpal_frontend/screens/search_friend_screen.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/profilepageheader.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;

  late UserModel _user;
  late List<ListItemModel> _friendList;
  late List<ListItemModel> _friendRequestList;

  final ProfileService profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _user = UserModel(nickname: '닉네임', tagId: '0000', iconId: 1);
    _friendList = [];
    _friendRequestList = [];
    _fetchFromServer();
  }

  Future<void> _fetchFromServer() async {
    final user = await profileService.getUserInfo();
    final friendList = await profileService.getFriendList();
    final friendRequestList =
        await profileService.getReceivedFriendRequestList();
    setState(() {
      _user = user;
      _friendList = friendList
          .map((friend) => ListItemModel.fromFriendModel(friend))
          .toList();
      _friendRequestList = friendRequestList
          .map((request) => ListItemModel.fromFriendRequestModel(request))
          .toList();
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onRemoveItem(int index) {
    setState(() {
      _friendList.removeAt(index);
    });
  }

  void _onAcceptItem(int index, FriendModel friendModel) {
    setState(() {
      _friendRequestList.removeAt(index);
      _friendList.insert(0, ListItemModel.fromFriendModel(friendModel));
    });
  }

  void _reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: ProfilePageHeader(user: _user, reload: _reload),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: _profileContainer(screenWidth),
          ),
          Positioned(
              top: 80,
              left: 0,
              child: SizedBox(
                  width: screenWidth,
                  height: screenHeight - 210,
                  child: _friendContainer(context, screenWidth)))
        ],
      ),
    );
  }

  Container _profileContainer(double screenWidth) {
    return Container(
      color: AppColors.primaryPurple,
      width: screenWidth,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getUserIcon(_user.iconId, 0),
            const Padding(padding: EdgeInsets.all(8)),
            _userInfoBox()
          ]),
    );
  }

  SizedBox _userInfoBox() {
    final textStyle =
        AppFonts.interSemiBold(color: AppColors.white, fontsize: 19);

    return SizedBox(
      height: 63,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _user.nickname,
                  style: textStyle,
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text('#${_user.tagId}', style: textStyle.copyWith(fontSize: 16))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('현재 약속 가능한 친구',
                    style: AppFonts.interLight(
                        color: AppColors.white, fontsize: 15)),
                const Padding(padding: EdgeInsets.all(4)),
                Text('${_friendList.length}명', style: textStyle)
              ],
            )
          ]),
    );
  }

  Container _friendContainer(BuildContext context, double screenWidth) {
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
          _tabMenu(),
          const Padding(padding: EdgeInsets.all(15)),
          _tabScreen(context)
        ]));
  }

  Row _tabMenu() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TabItem(
          text: '친구 목록',
          isSelected: _selectedIndex == 0,
          onPressed: () => _onTabSelected(0)),
      TabItem(
          text: '친구 요청 목록',
          isSelected: _selectedIndex == 1,
          onPressed: () => _onTabSelected(1)),
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SearchFriendScreen()),
            );
          },
          icon: AppIcon().getAddFriendsIcon(
              color: AppColors.darkGray, height: 22, width: 22))
    ]);
  }

  Expanded _tabScreen(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final items = _selectedIndex == 0 ? _friendList : _friendRequestList;

    return Expanded(
        child: SingleChildScrollView(
            child: SizedBox(
                height: screenHeight - 343,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(
                        item: items[index],
                        index: index,
                        mode: _selectedIndex,
                        onRemoveItem: _onRemoveItem,
                        onAcceptItem: _onAcceptItem);
                  },
                ))));
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
            border: Border(
                bottom: isSelected
                    ? const BorderSide(color: AppColors.darkGray)
                    : BorderSide.none)),
        child: Text(
          text,
          style: AppFonts.interLight(color: AppColors.darkGray, fontsize: 20),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final ListItemModel item;
  final int index;
  final int mode;
  final Function(int) onRemoveItem;
  final Function(int, FriendModel) onAcceptItem;

  final borderSide = const BorderSide(width: 0.5, color: AppColors.gray);

  const ListItem(
      {Key? key,
      required this.item,
      required this.index,
      required this.mode,
      required this.onRemoveItem,
      required this.onAcceptItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        leading: getUserIcon(item.iconId, 1),
        title: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            item.nickname,
            style:
                AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 20),
          ),
          const Padding(padding: EdgeInsets.all(3)),
          Text(
            '#${item.tagId}',
            style:
                AppFonts.interSemiBold(color: AppColors.darkGray, fontsize: 17),
          ),
        ]),
        trailing: _button(context),
      ),
    );
  }

  TextButton _button(BuildContext context) {
    final buttonColor =
        mode == 0 ? AppColors.primaryRed : AppColors.primaryPurple;
    final buttonText = mode == 0 ? '삭제' : '승낙';

    return TextButton(
        onPressed: () {
          _showAlertDialog(context, buttonText);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: buttonColor,
        ),
        child: Text(
          buttonText,
          style: AppFonts.interLight(color: AppColors.white, fontsize: 15),
        ));
  }

  void _showAlertDialog(BuildContext context, String buttonText) {
    final dialogText = mode == 0 ? '친구 삭제' : '친구 추가';
    final dialogContextText = mode == 0 ? '친구에서 삭제' : '친구로 추가';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogText),
          content: Text('${item.nickname}님을 $dialogContextText하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () async {
                if (mode == 0) {
                  ProfileService().deleteFriend(item.id);
                  onRemoveItem(index);
                } else {
                  FriendModel friendModel =
                      await ProfileService().acceptFriend(item.id);
                  onAcceptItem(index, friendModel);
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(buttonText),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
          ],
        );
      },
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

  ListItemModel.fromFriendModel(FriendModel friendModel) {
    id = friendModel.userId;
    nickname = friendModel.nickname;
    tagId = friendModel.tagId;
    iconId = friendModel.iconId;
  }

  ListItemModel.fromFriendRequestModel(FriendRequestModel friendRequestModel) {
    id = friendRequestModel.friendRequestId;
    nickname = friendRequestModel.nickname;
    tagId = friendRequestModel.tagId;
    iconId = friendRequestModel.iconId;
  }
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
