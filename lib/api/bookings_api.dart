import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/model/booking.dart';

class BookingsApi {
  static Future<Booking?> fetchBookingById(int id) async {
    final response = await Api.get('bookings/$id');
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Booking.fromJson(data);
    }
    return null;
  }

  static Future<bool> deleteBooking(int id) async {
    final response = await Api.delete('bookings/$id');
    if (response != null && response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<Booking?> createBooking(
      Map<String, dynamic> bookingData) async {
    final response = await Api.post('bookings/create', bookingData);
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Booking.fromJson(data);
    }
    return null;
  }

  static Future<Booking?> updateBooking(
      Map<String, dynamic> bookingData) async {
    final response = await Api.put('bookings/update', bookingData);
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Booking.fromJson(data);
    }
    return null;
  }

  static Future<List<Booking>> fetchBookingsByUserId(String userId) async {
    final response = await Api.get('bookings?user_id=$userId');
    if (response != null && response.statusCode == 200) {
      final List<dynamic> data = response.data['responseObject'];
      return data.map((json) => Booking.fromJson(json)).toList();
    }
    return [];
  }
}
