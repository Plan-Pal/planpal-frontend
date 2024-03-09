import 'package:flutter/material.dart';
import 'package:planpal_frontend/api/mock_api_service.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';
import 'package:planpal_frontend/widgets/common/schedule/edit_schedule/schedule_participants/invited_friends_button.dart';
import 'package:planpal_frontend/widgets/common/schedule/edit_schedule/schedule_participants/search_friends.dart';
import 'package:planpal_frontend/widgets/common/user/simple_user_container.dart';

class AddParticipantsWidget extends StatefulWidget {
  @override
  _AddParticipantsWidget createState() => _AddParticipantsWidget();
}

class _AddParticipantsWidget extends State<AddParticipantsWidget> {
  bool _isPublic = false;
  List<Widget> participants = [];
  final apiService = MockApiService();
  Map<String, bool> invitedFriends = {};

  void onInvite(Map<String, dynamic> friend, bool isInvited) {
    setState(() {
      invitedFriends[friend['nickname']] = isInvited;
      if (isInvited) {
        participants.add(ProfileContainer(nickname: friend['nickname']));
      } else {
        participants.removeWhere((widget) =>
            widget is ProfileContainer &&
            (widget as ProfileContainer).nickname == friend['nickname']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.getFriendsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var data = snapshot.data;
          List<Map<String, dynamic>> friendsList = data != null
              ? List<Map<String, dynamic>>.from(data['result'] as List)
              : [];
          return Container(
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Text('초대할 사람',
                      style: AppFonts.interRegular(
                          color: AppColors.darkGray, fontsize: 15)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isPublic = !_isPublic;
                        if (!_isPublic) {
                          participants.clear();
                          invitedFriends.clear();
                        }
                      });
                    },
                    child: Row(
                      children: [
                        AppIcon().getCheckIcon(
                            color: _isPublic
                                ? AppColors.darkGray
                                : AppColors.lightGray,
                            height: 8,
                            width: 8),
                        const SizedBox(width: 3),
                        Text(
                          'Public',
                          style: AppFonts.interMedium(
                              color: _isPublic
                                  ? AppColors.darkGray
                                  : AppColors.lightGray,
                              fontsize: 10),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: participants.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: _isPublic
                            ? () {
                                MyBottomSheet().show(context, friendsList,
                                    onInvite, invitedFriends);
                              }
                            : null,
                        child: Container(
                          height: 100,
                          child: InviteParticipantsButton(),
                        ),
                      );
                    } else if (index == 1) {
                      return Container(
                        height: 100,
                        child: ProfileContainer(nickname: '초대자'),
                      );
                    } else {
                      return participants[index - 2];
                    }
                  },
                ),
              ),
            ]),
          );
        }
      },
    );
  }
}
