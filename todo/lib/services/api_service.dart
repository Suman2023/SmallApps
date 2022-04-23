import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApiService {
  final Dio _dio = Dio();
  final Box _box = Hive.box('accounts');
  final _baseUrl = 'https://all-task-manager.herokuapp.com/api/';

  Future<Map<dynamic, dynamic>?> getToken(
      {required String username, required String password}) async {
    Map<dynamic, dynamic>? result;

    print(username + " " + password);
    try {
      Response response = await _dio.post(_baseUrl + 'account/login/',
          data: {'username': username, 'password': password});
      result = response.data;
    } on DioError catch (e) {
      print(e.message);
    }
    return result;
  }

  Future<List<Map<String, String>>> getAllHabits() async {
    List<Map<String, String>> result = [];
    try {
      print("Hello from all habits");
      String? token = _box.get('token');
      print(token);
      Response response = await _dio.get(_baseUrl + 'all-habits/',
          options: Options(headers: {'authorization': "Token $token"}));

      for (var item in response.data) {
        result.add({'habit_name': item['habit_name']});
      }
      print(response.data);
    } on DioError catch (e) {
      print(e.message);
    }

    return result;
  }
}
