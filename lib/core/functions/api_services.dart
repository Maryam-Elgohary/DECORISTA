import 'package:dio/dio.dart';
import 'package:furniture_app/core/sensetive_data.dart';

class ApiServices {
  // Static instance variable to hold the single instance
  static final ApiServices _instance = ApiServices._internal();

  // Dio instance that will be reused
  late final Dio _dio;

  // Factory constructor to return the singleton instance
  factory ApiServices() {
    return _instance;
  }

  // Private constructor to initialize Dio
  ApiServices._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://wdgpfhefvzknfoeaxizj.supabase.co/rest/v1/",
        headers: {
          "apikey": anonKey_supabase,
          // "Authorization": authorization_anonKey // Uncomment if needed
        },
      ),
    );
  }

  // Method to perform GET requests
  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  // Method to perform POST requests
  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  // Method to perform PATCH requests
  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }

  // Method to perform DELETE requests
  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
