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
    dio = Dio(BaseOptions(
      baseUrl: 'http://172.30.1.28:8080',
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
    return jsonList.map((json) => FriendModel.fromJsonList(json)).toList();
  }

  Future<List<FriendRequestModel>> getReceivedFriendRequestList() async {
    Response response = await dio.get("/friends/request/received");
    List<dynamic> jsonList = response.data['result'];
    return jsonList
        .map((json) => FriendRequestModel.fromReceivedJson(json))
        .toList();
  }

  Future<List<FriendRequestModel>> getSentFriendRequestList() async {
    Response response = await dio.get("/friends/request/sent");
    List<dynamic> jsonList = response.data['result'];
    return jsonList
        .map((json) => FriendRequestModel.fromSentJson(json))
        .toList();
  }

  Future<void> deleteFriendRequest(BigInt friendRequestId) async {
    await dio.delete('/friends/request',
        data: {'friend_request_id': '$friendRequestId'});
  }

  Future<String> sendFriendRequest(BigInt friendId) async {
    try {
      await dio.post('/friends/request', data: {'user_id': '$friendId'});
      return "친구 신청이 완료되었습니다.";
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['message'];
      }
      return "친구 신청이 불가합니다. 다음에 다시 시도해주세요.";
    } catch (e) {
      return "친구 신청이 불가합니다. 다음에 다시 시도해주세요.";
    }
  }

  Future<FriendModel> acceptFriend(BigInt friendRequestId) async {
    Response response = await dio
        .post('/friends', data: {'friend_request_id': '$friendRequestId'});
    return FriendModel.fromJson(response.data);
  }

  Future<void> deleteFriend(BigInt userId) async {
    await dio.delete('/friends', data: {'user_id': '$userId'});
  }

  Future<void> updateUser(String nickname, int iconId) async {
    await dio.patch('/users', data: {'nickname': nickname, 'icon_id': iconId});
  }
}
