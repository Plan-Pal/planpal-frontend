class LoginResult {
  late String accessToken;
  late String refreshToken;

  LoginResult({required this.accessToken, required this.refreshToken});

  LoginResult.fromMap(Map<dynamic, dynamic>? map) {
    accessToken = map?['result']['access_token'];
    refreshToken = map?['result']['refresh_token'];
  }
}
