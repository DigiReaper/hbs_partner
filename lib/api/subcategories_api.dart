import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/model/subcategory.dart';

class SubcategoriesApi {
  static Future<List<Subcategory>?> fetchSubcategories() async {
    final response = await Api.get('subcategories');
    if (response != null && response.statusCode == 200) {
      final List<dynamic> data = response.data['responseObject'];
      return data.map((json) => Subcategory.fromJson(json)).toList();
    }
    return null;
  }

  static Future<Subcategory?> fetchSubcategoryById(int id) async {
    final response = await Api.get('subcategories/$id');
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Subcategory.fromJson(data);
    }
    return null;
  }

  static Future<Subcategory?> createSubcategory(
      int categoryId, String title, String imageUrl) async {
    final response = await Api.post('subcategories/create', {
      'category_id': categoryId,
      'title': title,
      'image_url': imageUrl,
    });
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Subcategory.fromJson(data);
    }
    return null;
  }

  static Future<Subcategory?> updateSubcategory(
      int id, int categoryId, String title, String imageUrl) async {
    final response = await Api.put('subcategories/update', {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'image_url': imageUrl,
    });
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Subcategory.fromJson(data);
    }
    return null;
  }

  static Future<bool> deleteSubcategory(int id) async {
    final response = await Api.delete('/subcategories/$id');
    if (response != null && response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
