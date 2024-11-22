import 'package:hbs_partner/api/api.dart';
import 'package:hbs_partner/model/category.dart';

class CategoriesApi {
  static Future<List<Category>?> fetchCategories() async {
    print("API Request");
    final response = await Api.get('categories');
    if (response != null && response.statusCode == 200) {
      final List<dynamic> data = response.data['responseObject'];
      print(data.toString());

      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      print("Error");
    }
    return null;
  }

  static Future<Category?> fetchCategoryById(int id) async {
    final response = await Api.get('categories/$id');
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Category.fromJson(data);
    }
    return null;
  }

  static Future<Category?> createCategory(String title, String imageUrl) async {
    final response = await Api.post('categories/create', {
      'title': title,
      'image_url': imageUrl,
    });
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Category.fromJson(data);
    }
    return null;
  }

  static Future<Category?> updateCategory(
      int id, String title, String imageUrl) async {
    final response = await Api.put('categories/update', {
      'id': id,
      'title': title,
      'image_url': imageUrl,
    });
    if (response != null && response.statusCode == 200) {
      final data = response.data['responseObject'];
      return Category.fromJson(data);
    }
    return null;
  }

  static Future<bool> deleteCategory(int id) async {
    final response = await Api.delete('categories/$id');
    if (response != null && response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
