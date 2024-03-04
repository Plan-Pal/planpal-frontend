import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:planpal_frontend/models/login_info.dart';
import 'package:planpal_frontend/models/login_result.dart';

class UserProvider {
  static String serverUri =
      'http://172.30.1.28:8080'; // localhost -> 본인 IP로 변경 필요

  Future<LoginResult> signUp(LoginInfo loginInfo) async {
    final response = await http.post(Uri.parse('$serverUri/signup'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(loginInfo.toMap()));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return LoginResult.fromMap(data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
