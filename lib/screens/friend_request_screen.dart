import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/profile_service.dart';
import 'package:planpal_frontend/screens/profile_screen.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/appliedfriendslistpageheader.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({super.key});

  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  late List<ListItemModel> _friendRequestList;

  @override
  void initState() {
    super.initState();
    _friendRequestList = [];
    _fetchFromServer();
  }

  Future<void> _fetchFromServer() async {
    final friendRequestList = await ProfileService().getSentFriendRequestList();
    setState(() {
      _friendRequestList = friendRequestList
          .map((request) => ListItemModel.fromFriendRequestModel(request))
          .toList();
    });
  }

  void onRemoveItem(int index) {
    setState(() {
      _friendRequestList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const AppliedFriendsListPageHeader(),
        body: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _tabScreen(context),
        ));
  }

  Expanded _tabScreen(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
        child: SingleChildScrollView(
            child: SizedBox(
                height: screenHeight - 100,
                child: ListView.builder(
                  itemCount: _friendRequestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(
                      item: _friendRequestList[index],
                      index: index,
                      onRemoveItem: onRemoveItem,
                    );
                  },
                ))));
  }
}

class ListItem extends StatelessWidget {
  final ListItemModel item;
  final int index;
  final Function(int) onRemoveItem;

  final borderSide = const BorderSide(width: 0.5, color: AppColors.gray);

  const ListItem(
      {Key? key,
      required this.item,
      required this.index,
      required this.onRemoveItem})
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
    return TextButton(
        onPressed: () {
          _showAlertDialog(context, '삭제');
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.primaryRed,
        ),
        child: Text(
          '삭제',
          style: AppFonts.interLight(color: AppColors.white, fontsize: 15),
        ));
  }

  void _showAlertDialog(BuildContext context, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('친구 신청 삭제'),
          content: Text('${item.nickname}님에 대한 친구 신청 요청을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                ProfileService().deleteFriendRequest(item.id);
                onRemoveItem(index);
                Navigator.pop(context);
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
