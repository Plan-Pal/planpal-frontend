import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/profile_service.dart';
import 'package:planpal_frontend/api/user_get_service.dart';
import 'package:planpal_frontend/screens/profile_screen.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/searchfriendspageheader.dart';

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({super.key});

  @override
  State<SearchFriendScreen> createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  int _selectedIndex = 0;
  List<ListItemModel> _userList = [];

  final UserGetService userGetService = UserGetService();

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _fetchUserFromServer(String param) async {
    final userList =
        await userGetService.getUsers(mode: _selectedIndex, param: param);

    setState(() {
      _userList.clear();
      _userList =
          userList.map((user) => ListItemModel.fromFriendModel(user)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const SearchFriendsPageHeader(),
        body: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _tabMenu(),
              const SizedBox(height: 5),
              TextInputField(
                  mode: _selectedIndex, onSubmitted: _fetchUserFromServer),
              const SizedBox(height: 5),
              _tabScreen(context)
            ],
          ),
        ));
  }

  Row _tabMenu() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TabItem(
          text: '이름으로 검색',
          isSelected: _selectedIndex == 0,
          onPressed: () => _onTabSelected(0)),
      const SizedBox(width: 12),
      TabItem(
          text: '아이디로 검색',
          isSelected: _selectedIndex == 1,
          onPressed: () => _onTabSelected(1)),
    ]);
  }

  Expanded _tabScreen(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
        child: SingleChildScrollView(
            child: SizedBox(
                height: screenHeight - 195,
                child: ListView.builder(
                  itemCount: _userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(
                      item: _userList[index],
                      index: index,
                    );
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
      child: Text(
        '\u2022 $text',
        style: isSelected
            ? AppFonts.interRegular(color: AppColors.darkGray, fontsize: 13)
            : AppFonts.interRegular(color: AppColors.lightGray, fontsize: 13),
      ),
    );
  }
}

class TextInputField extends StatefulWidget {
  final int mode;
  final ValueSetter<String> onSubmitted;

  const TextInputField(
      {super.key, required this.mode, required this.onSubmitted});

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
  void didUpdateWidget(TextInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mode != oldWidget.mode) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.lightGray),
    );
    final maxLength = widget.mode == 0 ? 10 : 4;

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            controller: _controller,
            maxLines: 1,
            maxLength: maxLength,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              labelText: '친구를 찾아보세요',
              labelStyle: AppFonts.interRegular(
                  color: AppColors.lightGray, fontsize: 14),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              counterText: '',
              alignLabelWithHint: true,
            ),
            style: const TextStyle(fontSize: 12),
            onSubmitted: (value) =>
                {if (value.isNotEmpty) widget.onSubmitted(value)},
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${_controller.text.length}/$maxLength',
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final ListItemModel item;
  final int index;

  final borderSide = const BorderSide(width: 0.5, color: AppColors.gray);

  const ListItem({Key? key, required this.item, required this.index})
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
          _showAlertDialog(context, '신청');
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.primaryPurple,
        ),
        child: Text(
          '신청',
          style: AppFonts.interLight(color: AppColors.white, fontsize: 15),
        ));
  }

  void _showAlertDialog(BuildContext context, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('친구 신청'),
          content: Text('${item.nickname}님께 친구 신청을 보내시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () async {
                String msg = await ProfileService().sendFriendRequest(item.id);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                    duration: const Duration(seconds: 3),
                  ));
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
