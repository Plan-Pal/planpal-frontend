abstract class ApiService {
  Future<Map<String, dynamic>> getSchedules();
  Future<Map<String, dynamic>> getInvitedSchedules();
  Future<Map<String, dynamic>> getAddedSchedules();
}
