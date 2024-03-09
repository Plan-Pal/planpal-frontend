class FriendModel {
  late BigInt userId;
  late String nickname;
  late String tagId;
  late int iconId;

  FriendModel({
    required this.userId,
    required this.nickname,
    required this.tagId,
    required this.iconId,
  });

  FriendModel.fromJson(Map<String, dynamic>? map) {
    userId = BigInt.from(map?['user_id']);
    nickname = map?['nickname'];
    tagId = map?['tag_id'];
    iconId = map?['icon_id'];
  }
}
