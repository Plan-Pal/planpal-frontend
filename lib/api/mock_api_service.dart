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

  @override
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

  @override
  Future<Map<String, dynamic>> getAddedSchedules() async {
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
          },
          {
            "short_title": "짧은제목3",
            "title": "초대일정수락테스트",
            "appointed_time": "2024-03-24T13:30:00",
            "place": "회의실 A33"
          },
          {
            "short_title": "짧은제목3",
            "title": "초대일정수락테스트",
            "appointed_time": "2024-03-24T13:30:00",
            "place": "회의실 A33"
          },
          {
            "short_title": "짧은제목3",
            "title": "초대일정수락테스트",
            "appointed_time": "2024-03-24T13:30:00",
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

  @override
  Future<Map<String, dynamic>> getSpecificSchedule(int scheduleNumber) async {
    return {
      "is_success": true,
      "code": "COMMON200",
      "message": "성공입니다",
      "result": {
        "short_title": "초대 일정",
        "long_title": "초대일정수락테스트",
        "memo": "프로젝트 진행 상황 논의33",
        "appointed_time": "2024-02-24T13:30:00",
        "place": "회의실 A33",
        "schedule_state": "PUBLIC",
        "participating_user_list": [
          {"user_nickname": "테스터1"},
          {"user_nickname": "테스터2"},
          {"user_nickname": "테스터3"},
          {"user_nickname": "테스터4"},
          {"user_nickname": "테스터5"},
          {"user_nickname": "테스터6"},
          {"user_nickname": "테스터7"}
        ]
      }
    };
  }

  @override
  Future<Map<String, dynamic>> getFriendsList() async {
    return {
      "is_success": true,
      "code": "COMMON200",
      "message": "성공입니다",
      "result": [
        {"user_id": 1, "nickname": "user2", "tag_id": "6fa5"},
        {"user_id": 2, "nickname": "user3", "tag_id": "6fa5"},
        {"user_id": 3, "nickname": "user4", "tag_id": "6fa5"},
        {"user_id": 4, "nickname": "user5", "tag_id": "6fa5"},
        {"user_id": 5, "nickname": "user6", "tag_id": "6fa5"},
        {"user_id": 6, "nickname": "user7", "tag_id": "b709"}
      ]
    };
  }
}
