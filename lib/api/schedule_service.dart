import 'package:dio/dio.dart';
import 'package:planpal_frontend/api/storage_service.dart';
import 'package:planpal_frontend/api/user_auth_service.dart';
import 'package:planpal_frontend/models/schedule_model/all_schedule_list_model.dart';
import 'package:planpal_frontend/models/jwt_model.dart';

class ScheduleService {
  static late Dio dio;

  StorageService storageService = StorageService();
  UserAuthService userAuthService = UserAuthService();

  ScheduleService() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.0.9:8080',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ));
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? accessToken = await storageService.readAccessToken();
      options.headers["Authorization"] = "Bearer $accessToken";
      handler.next(options);
    }, onError: (error, handler) async {
      final isStatus401 = error.response?.statusCode == 401;
      final isPathRefresh = error.requestOptions.path == "/refresh";

      if (isStatus401 && !isPathRefresh) {
        Dio dio = Dio();

        JwtModel? savedJwt = await storageService.readJwt();
        if (savedJwt == null) {
          return handler.reject(error);
        }

        JwtModel newJwt = await userAuthService.refresh(savedJwt: savedJwt);
        await storageService.writeJwt(newJwt);

        final options = error.requestOptions;
        options.headers["Authorization"] = "Bearer ${newJwt.accessToken}";

        Response newResponse = await dio.fetch(options);
        return handler.resolve(newResponse);
      }
      return handler.reject(error);
    }));
  }

  Future<AllScheduleListModel> getSchedules() async {
    Response response = await dio.get("/schedules");
    return AllScheduleListModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> getSpecificSchedule(int scheduleId) async {
    Response response = await dio.get("/schedules/$scheduleId");
    return response.data;
  }

  Future<Map<String, dynamic>> getInvitedSchedules() async {
    Response response = await dio.get("/schedules/invited");
    return response.data;
  }
}
