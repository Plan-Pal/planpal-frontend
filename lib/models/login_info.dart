class LoginInfo {
  late int kakaoId;
  late String? nickname;

  LoginInfo({required this.kakaoId, required this.nickname});

  Map<String, dynamic> toMap() {
    return {'kakao_id': kakaoId, 'nickname': nickname};
  }
}
