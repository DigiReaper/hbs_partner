import 'dart:convert';
import 'package:dio/dio.dart';

class Api {
  static const String baseUrl = 'http://13.233.153.17/';
  // static const String baseUrl = 'http://10.0.2.2/';

  static final Dio dio = Dio();

  static Future<Response?> post(String endpoint, Map<String, dynamic> data,
      {bool out = true}) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode(data),
      );
      if (out) print(const JsonEncoder.withIndent('  ').convert(response.data));
      return response;
    } on DioException catch (e) {
      // Handle error
      if (e.type == DioExceptionType.badResponse) {
        print("API Error: ${e.response?.data}");
        return e.response;
      }
      print("API Error: $e");
      return null;
    }
  }

  static Future<Response?> put(String endpoint, Map<String, dynamic> data,
      {bool out = true}) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await dio.put(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode(data),
      );
      if (out) print(const JsonEncoder.withIndent('  ').convert(response.data));
      return response;
    } on DioException catch (e) {
      // Handle error
      if (e.type == DioExceptionType.badResponse) {
        print("API Error: ${e.response?.data}");
        return e.response;
      }
      print("API Error: $e");
      return null;
    }
  }

  static Future<Response?> get(String endpoint, {bool out = true, Map<String, dynamic>? params}) async {
    final url = '$baseUrl$endpoint';
    print('GET Request to $url');
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (out) print(const JsonEncoder.withIndent('  ').convert(response.data));
      return response;
    } on DioException catch (e) {
      // Handle error
      if (e.type == DioExceptionType.badResponse) {
        print("API Error: ${e.response?.data}");
        return e.response;
      }

      print(e);
      return null;
    }
  }

  static Future<Response?> delete(String endpoint, {bool out = true, Map<String, dynamic>? params}) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await dio.delete(
        url,
        queryParameters: params,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (out) print(const JsonEncoder.withIndent('  ').convert(response.data));
      return response;
    } on DioException catch (e) {
      // Handle error
      if (e.type == DioExceptionType.badResponse) {
        print("API Error: ${e.response?.data}");
        return e.response;
      }
      print("API Error: $e");
      return null;
    }
  }
}
