class UserModel {
  late String nickname;
  late String tagId;
  late int iconId;

  UserModel(
      {required this.nickname, required this.tagId, required this.iconId});

  UserModel.fromJson(Map<String, dynamic>? map) {
    nickname = map?['result']['nickname'];
    tagId = map?['result']['tag_id'];
    iconId = map?['result']['icon_id'];
  }
}
