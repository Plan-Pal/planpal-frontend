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

  FriendModel.fromJsonList(Map<String, dynamic>? map) {
    userId = BigInt.from(map?['user_id']);
    nickname = map?['nickname'];
    tagId = map?['tag_id'];
    iconId = map?['icon_id'];
  }

  FriendModel.fromJson(Map<String, dynamic>? map) {
    userId = BigInt.from(map?['result']['user_id']);
    nickname = map?['result']['nickname'];
    tagId = map?['result']['tag_id'];
    iconId = map?['result']['icon_id'];
  }
}
