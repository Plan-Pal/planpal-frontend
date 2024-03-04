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

  Future<Map<String, dynamic>> getInvitedSchedules() async {
    return {
      "is_success": true,
      "code": "COMMON200",
      "message": "성공입니다",
      "result": {
        "schedule_count": 6,
        "schedules": [
          {
            "title": "새로운 일정 1개",
            "appointed_time": "2024-02-24T13:30:00",
            "place": "회의실 A33"
          },
          {
            "title": "술 마시는 약속",
            "appointed_time": "2024-02-24T13:30:00",
            "place": "어디역 여기술집"
          },
          {
            "title": "프로젝트 회의 약속",
            "appointed_time": "2024-02-24T13:30:00",
            "place": "어디역 무슨카페"
          },
          {
            "title": "동아리 회식 약속",
            "appointed_time": "2024-02-24T13:30:00",
            "place": "어떤대학교 여기술집"
          },
        ]
      }
    };
  }

  Future<Map<String, dynamic>> getAddedchedules() async {
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
            "appointed_time": "2024-03-24T13:30:00",
            "place": "회의실 A33"
          }
        ]
      }
    };
  }
}
