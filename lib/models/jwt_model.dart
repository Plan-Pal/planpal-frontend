class JwtModel {
  late String accessToken;
  late String refreshToken;

  JwtModel({required this.accessToken, required this.refreshToken});

  JwtModel.fromMap(Map<dynamic, dynamic>? map) {
    accessToken = map?['result']['access_token'];
    refreshToken = map?['result']['refresh_token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
