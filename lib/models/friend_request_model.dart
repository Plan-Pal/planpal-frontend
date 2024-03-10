class FriendRequestModel {
  late BigInt friendRequestId;
  late String nickname;
  late String tagId;
  late int iconId;

  FriendRequestModel({
    required this.friendRequestId,
    required this.nickname,
    required this.tagId,
    required this.iconId,
  });

  FriendRequestModel.fromJson(Map<String, dynamic>? map) {
    friendRequestId = BigInt.from(map?['friend_request_id']);
    nickname = map?['sender_nickname'];
    tagId = map?['sender_tag_id'];
    iconId = map?['sender_icon_id'];
  }
}
