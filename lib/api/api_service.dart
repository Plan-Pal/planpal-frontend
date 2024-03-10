abstract class ApiService {
  Future<Map<String, dynamic>> getSchedules();
  Future<Map<String, dynamic>> getInvitedSchedules();
  Future<Map<String, dynamic>> getAddedSchedules();
  Future<Map<String, dynamic>> getSpecificSchedule(int scheduleNumber);
  Future<Map<String, dynamic>> getFriendsList();
}
