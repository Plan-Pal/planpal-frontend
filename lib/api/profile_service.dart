import 'package:dio/dio.dart';
import 'package:planpal_frontend/api/storage_service.dart';
import 'package:planpal_frontend/api/user_auth_service.dart';
import 'package:planpal_frontend/models/friend_model.dart';
import 'package:planpal_frontend/models/friend_request_model.dart';
import 'package:planpal_frontend/models/jwt_model.dart';
import 'package:planpal_frontend/models/user_model.dart';

class ProfileService {
  static late Dio dio;

  StorageService storageService = StorageService();
  UserAuthService userAuthService = UserAuthService();

  ProfileService() {
    dio = Dio(BaseOptions(baseUrl: 'http://172.30.1.32:8080'));
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
        // 로직 검증 필요
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

  Future<UserModel> getUserInfo() async {
    Response response = await dio.get("/users/profile");
    return UserModel.fromJson(response.data);
  }

  Future<List<FriendModel>> getFriendList() async {
    Response response = await dio.get("/friends");
    List<dynamic> jsonList = response.data['result'];
    return jsonList.map((json) => FriendModel.fromJson(json)).toList();
  }

  Future<List<FriendRequestModel>> getFriendRequestList() async {
    Response response = await dio.get("/friends/request/received");
    List<dynamic> jsonList = response.data['result'];
    return jsonList.map((json) => FriendRequestModel.fromJson(json)).toList();
  }
}
