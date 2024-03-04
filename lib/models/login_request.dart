class LoginRequest {
  late int kakaoId;
  late String? nickname;

  LoginRequest({required this.kakaoId, required this.nickname});

  Map<String, dynamic> toMap() {
    return {'kakao_id': kakaoId, 'nickname': nickname};
  }
}
