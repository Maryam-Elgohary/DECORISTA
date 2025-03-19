import 'package:dio/dio.dart';
import 'package:furniture_app/core/sensetive_data.dart';

class ApiServices {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://wdgpfhefvzknfoeaxizj.supabase.co/rest/v1/",
      headers: {
        "apikey": anonKey_supabase,
        "Authorizaion": authorization_anonKey
      }));

  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
