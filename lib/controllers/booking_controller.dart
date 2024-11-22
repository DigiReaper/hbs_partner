import 'package:flutter/material.dart';
import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/api/bookings_api.dart';
import 'package:hbs_partner/model/api_response.dart';
import 'package:hbs_partner/model/booking.dart';

class BookingController with ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = false;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<ApiResponse> fetchBookingsByUserId(String userId) async {
    _isLoading = true;
    notifyListeners();
    // final bookings = await BookingsApi.fetchBookingsByUserId(userId);
    final response = await Api.get('bookings?user_id=$userId');
    if (response != null) {
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['responseObject'];
        _bookings = data.map((json) => Booking.fromJson(json)).toList();
        _isLoading = false;
        notifyListeners();
        return ApiResponse(success: true, message: "Bookings Fetched");
      } else {
        _isLoading = false;
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "No Bookings Found");
      }
    } else {
      _isLoading = false;
      return ApiResponse(
          success: false,
          message: "Fetching Bookings failed, Please try again Later");
    }
  }

  Future<void> fetchBookingById(int id) async {
    _isLoading = true;
    notifyListeners();
    final booking = await BookingsApi.fetchBookingById(id);
    if (booking != null) {
      _bookings = [booking];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<ApiResponse> createBooking(Map<String, dynamic> bookingData) async {
    _isLoading = true;
    notifyListeners();
    print("Booking Data: $bookingData");
    final response = await Api.post('bookings/create', bookingData);
    if (response != null) {
      if (response.statusCode == 201) {
        final data = response.data['responseObject'];
        _bookings.add(Booking.fromJson(data));
        _isLoading = false;
        notifyListeners();
        return ApiResponse(success: true, message: "Booking Created");
      } else {
        _isLoading = false;
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "Booking Creation Failed");
      }
    } else {
      _isLoading = false;
      return ApiResponse(
          success: false,
          message: "Booking Creation failed, Please try again Later");
    }
  }

  Future<ApiResponse> cancelBooking(int id) async {
    _isLoading = true;
    notifyListeners();
    final response = await Api.put('bookings/update', {
      'id': id,
      'status': 1,
    });
    if (response != null) {
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        return ApiResponse(success: true, message: "Booking Cancelled");
      } else {
        _isLoading = false;
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "Booking Cancellation Failed");
      }
    } else {
      _isLoading = false;
      return ApiResponse(
          success: false,
          message: "Booking Cancellation failed, Please try again Later");
    }
  }

  Future<ApiResponse> rescheduleBooking(
      Map<String, dynamic> bookingData) async {
    _isLoading = true;
    notifyListeners();
    print(bookingData);
    final response = await Api.put('bookings/update', bookingData);
    if (response != null) {
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        return ApiResponse(success: true, message: "Booking Rescheduled");
      } else {
        _isLoading = false;
        return ApiResponse(
            success: false,
            message: response.data['message'] ?? "Booking Reschedule Failed");
      }
    } else {
      _isLoading = false;
      return ApiResponse(
          success: false,
          message: "Booking Reschedule failed, Please try again Later");
    }
  }

  Future<void> deleteBooking(int id) async {
    _isLoading = true;
    notifyListeners();
    final success = await BookingsApi.deleteBooking(id);
    if (success) {
      _bookings.removeWhere((booking) => booking.id == id);
    }
    _isLoading = false;
    notifyListeners();
  }
}
