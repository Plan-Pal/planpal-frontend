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

  FriendRequestModel.fromReceivedJson(Map<String, dynamic>? map) {
    friendRequestId = BigInt.from(map?['friend_request_id']);
    nickname = map?['sender_nickname'];
    tagId = map?['sender_tag_id'];
    iconId = map?['sender_icon_id'];
  }

  FriendRequestModel.fromSentJson(Map<String, dynamic>? map) {
    friendRequestId = BigInt.from(map?['friend_request_id']);
    nickname = map?['receiver_nickname'];
    tagId = map?['receiver_tag_id'];
    iconId = map?['receiver_icon_id'];
  }
}
