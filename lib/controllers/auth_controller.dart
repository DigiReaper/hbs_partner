import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/api/auth_api.dart';
import 'package:hbs_partner/model/api_response.dart';
import 'package:hbs_partner/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  final AuthApi _authApi = AuthApi();
  User? _user;
  bool _isAuthenticated = false;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  AuthController() {
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    print("Loading Auth Status");
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    if (_isAuthenticated) {
      print("User is authenticated");
      final userData = prefs.getString('user');
      if (userData != null) {
        _user = User.fromJson(jsonDecode(userData));
      }
    }
    notifyListeners();
  }

  Future<void> _saveAuthStatus() async {
    print("Saving Auth Status");
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', _isAuthenticated);
    if (_user != null) {
      print("Saving User");
      prefs.setString('user', jsonEncode(_user!.toJson()));
    } else {
      print("Removing User");
      prefs.remove('user');
    }
  }

  Future<ApiResponse> login(String mobileNumber, String otp) async {
    final response = await Api.post('users/login', {
      'mobileno': mobileNumber,
      'otp': otp,
    });

    if (response != null) {
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final user = User.fromJson(jsonResponse['responseObject']);
        _user = user;
        _isAuthenticated = true;
        await _saveAuthStatus();
        notifyListeners();
        return ApiResponse(success: true, message: "Login successful");
      } else {
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "Login failed");
      }
    } else {
      return ApiResponse(
          success: false, message: "Login failed, Please try again Later");
    }
  }

  Future<ApiResponse> register(String name, String email, String mobileNumber,
      String role, String otp) async {
    final response = await Api.post('users/create', {
      'name': name,
      'email': email,
      'mobileno': mobileNumber,
      'role': role,
      'otp': otp,
    });

    if (response != null) {
      if (response.statusCode == 201) {
        final jsonResponse = response.data;
        final user = User.fromJson(jsonResponse['responseObject']);
        _user = user;
        _isAuthenticated = true;
        await _saveAuthStatus();
        notifyListeners();

        return ApiResponse(success: true, message: "Registration successful");
      } else {
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "Registration failed");
      }
    } else {
      return ApiResponse(
          success: false,
          message: "Registration failed, Please try again Later");
    }
  }

  Future<ApiResponse> sendOtp(String mobileNumber) async {
    final response = await _authApi.sendOtp(mobileNumber);
    if (response.success) {
      return response;
    } else {
      return response;
    }
  }

  Future<ApiResponse> updateUser(User user) async {
    final response = await Api.put('users/update', {
      'id': user.id.toString(),
      'name': user.name,
      'email': user.email,
      'mobileno': user.mobileNumber,
      'role': user.role,
    });

    if (response != null) {
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final user = User.fromJson(jsonResponse['responseObject']);
        _user = user;
        await _saveAuthStatus();
        notifyListeners();
        return ApiResponse(success: true, message: "User updated successfully");
      } else {
        // Handle error
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "Failed to update user");
      }
    } else {
      // Handle error
      return ApiResponse(success: false, message: "Failed to update user");
    }
  }

  Future<void> getUser(String id) async {
    final user = await _authApi.getUser(id);
    if (user != null) {
      _user = user;
      await _saveAuthStatus();
      notifyListeners();
    } else {
      // Handle error
    }
  }

  void logout() async {
    _user = null;
    _isAuthenticated = false;
    await _saveAuthStatus();
    notifyListeners();
    // Clear session
  }
}
