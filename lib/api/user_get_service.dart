import 'package:dio/dio.dart';
import 'package:planpal_frontend/models/friend_model.dart';

class UserGetService {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://172.30.1.28:8080',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));

  Future<List<FriendModel>> getUsers(
      {required int mode, required String param}) async {
    final parameterKey = ["name", "id"];

    Response response =
        await dio.get("/users", queryParameters: {parameterKey[mode]: param});
    List<dynamic> jsonList = response.data['result'];
    return jsonList.map((json) => FriendModel.fromJsonList(json)).toList();
  }
}
