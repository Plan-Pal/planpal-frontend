class LoginResponse {
  late String accessToken;
  late String refreshToken;

  LoginResponse({required this.accessToken, required this.refreshToken});

  LoginResponse.fromMap(Map<dynamic, dynamic>? map) {
    accessToken = map?['result']['access_token'];
    refreshToken = map?['result']['refresh_token'];
  }
}
