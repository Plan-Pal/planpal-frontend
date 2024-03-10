import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:planpal_frontend/api/api_service.dart';

class RealApiService extends ApiService {
  final String _baseUrl = '';

  @override
  Future<Map<String, dynamic>> getSchedules() async {
    final response = await http.get(Uri.parse('$_baseUrl/schedules'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Future<Map<String, dynamic>> getInvitedSchedules() async {
    final response = await http.get(Uri.parse('$_baseUrl/schedules/invited'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load invited schedules');
    }
  }

  @override
  Future<Map<String, dynamic>> getAddedSchedules() async {
    final response = await http.get(Uri.parse('$_baseUrl/schedules'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load invited schedules');
    }
  }

  @override
  Future<Map<String, dynamic>> getSpecificSchedule(int scheduleNumber) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/schedules/$scheduleNumber'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load invited schedules');
    }
  }

  @override
  Future<Map<String, dynamic>> getFriendsList() async {
    final response = await http.get(Uri.parse('$_baseUrl/friends'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load friends list');
    }
  }
}
