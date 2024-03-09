import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class MyBottomSheet {
  void show(BuildContext context, List<Map<String, dynamic>> friendsList,
      Function onInvite, Map<String, bool> invitedFriends) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('초대할 친구 선택하기',
                        style: AppFonts.interSemiBold(
                            color: AppColors.darkGray, fontsize: 20)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: friendsList.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(
                        friendsList[index],
                        onInvite,
                        invitedFriends[friendsList[index]['nickname']] ??
                            false);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomListTile extends StatefulWidget {
  final Map<String, dynamic> friend;
  final Function onInvite;
  final bool isInvited;

  CustomListTile(this.friend, this.onInvite, this.isInvited);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late bool _isInvited;

  @override
  void initState() {
    super.initState();
    _isInvited = widget.isInvited;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: AppIcon()
            .getFace1Icon(color: AppColors.darkGray, height: 40, width: 40),
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: '${widget.friend['nickname']} ',
                  style: AppFonts.interSemiBold(
                      color: AppColors.darkGray, fontsize: 20)),
              TextSpan(
                  text: '#${widget.friend['tag_id']}',
                  style: AppFonts.interSemiBold(
                      color: AppColors.lightGray, fontsize: 15)),
            ],
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              _isInvited = !_isInvited;
              widget.onInvite(widget.friend, _isInvited);
            });
          },
          child: Icon(
            _isInvited ? Icons.check : Icons.person_add,
            color: AppColors.white,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                _isInvited ? AppColors.primaryLime : AppColors.primaryPurple),
          ),
        ));
  }
}
