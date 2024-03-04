import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:planpal_frontend/models/login_request.dart';
import 'package:planpal_frontend/models/login_response.dart';

class UserApiService {
  static String serverUri =
      'http://localhost:8080'; // localhost -> 본인 IP로 변경 필요

  Future<LoginResponse> signUp(LoginRequest loginInfo) async {
    final response = await http.post(Uri.parse('$serverUri/signup'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(loginInfo.toMap()));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return LoginResponse.fromMap(data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
