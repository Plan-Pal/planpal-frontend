import 'package:planpal_frontend/api/api_service.dart';

class MockApiService implements ApiService {
  @override
  Future<Map<String, dynamic>> getSchedules() async {
    return {
      "is_success": true,
      "code": "COMMON200",
      "message": "성공입니다",
      "result": {
        "schedule_count": 3,
        "schedules": [
          {
            "short_title": "짧은제목1",
            "title": "프로젝트 회의",
            "appointed_time": "2024-02-22T10:30:00",
            "place": "회의실 A"
          },
          {
            "short_title": "짧은제목2",
            "title": "프로젝트 회의33",
            "appointed_time": "2024-02-22T10:30:00",
            "place": "회의실 A33"
          },
          {
            "short_title": "짧은제목3",
            "title": "초대일정수락테스트",
            "appointed_time": "2024-02-24T13:30:00",
            "place": "회의실 A33"
          },
          {
            "short_title": "짧은제목3",
            "title": "초대일정수락테스트",
            "appointed_time": "2024-03-01T13:30:00",
            "place": "회의실 A33"
          }
        ]
      },
    };
  }
}
