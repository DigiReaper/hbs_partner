import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/model/service.dart';

class ServicesApi {
  static Future<List<Service>?> fetchServices() async {
    final response = await Api.get('services');
    if (response != null && response.statusCode == 200) {
      final List<dynamic> data = response.data['responseObject'];
      return data.map((json) => Service.fromJson(json)).toList();
    }
    return null;
  }

  static Future<Service?> fetchServiceById(int id) async {
    final response = await Api.get('services/$id', out: false);
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Service.fromJson(data);
    }
    return null;
  }

  static Future<Service?> createService(
      int subcategoryId,
      String title,
      double price,
      String imageUrl,
      String serviceIncludes,
      String serviceExcludes) async {
    final response = await Api.post('services/create', {
      'subcategory_id': subcategoryId,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      'service_includes': serviceIncludes,
      'service_excludes': serviceExcludes,
    });
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Service.fromJson(data);
    }
    return null;
  }

  static Future<Service?> updateService(
      int id,
      int subcategoryId,
      String title,
      double price,
      String imageUrl,
      String serviceIncludes,
      String serviceExcludes) async {
    final response = await Api.put('services/update', {
      'id': id,
      'subcategory_id': subcategoryId,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      'service_includes': serviceIncludes,
      'service_excludes': serviceExcludes,
    });
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Service.fromJson(data);
    }
    return null;
  }

  static Future<bool> deleteService(int id) async {
    final response = await Api.delete('services/$id');
    if (response != null && response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
