import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/model/api_response.dart';
import 'package:hbs_partner/model/user.dart';

class AuthApi {
  Future<User?> login(String mobileNumber, String otp) async {
    final response = await Api.post('users/login', {
      'mobileno': mobileNumber,
      'otp': otp,
    });

    if (response != null && response.statusCode == 200) {
      final jsonResponse = response.data;
      return User.fromJson(jsonResponse['responseObject']);
    } else {
      // Handle error
      return null;
    }
  }

  Future<User?> register(String name, String email, String mobileNumber,
      String role, String otp) async {
    final response = await Api.post('users/create', {
      'name': name,
      'email': email,
      'mobileno': mobileNumber,
      'role': role,
      'otp': otp,
    });

    if (response != null && response.statusCode == 201) {
      final jsonResponse = response.data;
      return User.fromJson(jsonResponse['responseObject']);
    } else {
      // Handle error
      return null;
    }
  }

  Future<ApiResponse> sendOtp(String mobileNumber) async {
    print("Sending OTP to $mobileNumber");
    final response = await Api.post('users/send-otp', {
      'mobileno': mobileNumber,
    });
    if (response != null) {
      final jsonResponse = response.data;
      return ApiResponse(
        success: jsonResponse['success'],
        message: jsonResponse['message'],
      );
    } else {
      // Handle error

      return ApiResponse(
        success: false,
        message: "Error Requesting OTP",
      );
    }
  }

  Future<User?> updateUser(String id, String name, String email,
      String mobileNumber, String role) async {
    final response = await Api.post('users/update', {
      'id': id,
      'name': name,
      'email': email,
      'mobileno': mobileNumber,
      'role': role,
    });

    if (response != null && response.statusCode == 200) {
      final jsonResponse = response.data;
      return User.fromJson(jsonResponse['responseObject']);
    } else {
      // Handle error
      return null;
    }
  }

  Future<User?> getUser(String id) async {
    final response = await Api.get('users/$id');

    if (response != null && response.statusCode == 200) {
      final jsonResponse = response.data;
      return User.fromJson(jsonResponse['responseObject']);
    } else {
      // Handle error
      return null;
    }
  }
}
