import 'package:flutter/material.dart';
import 'package:hbs_partner/api/categories_api.dart';
import 'package:hbs_partner/model/category.dart';

class CategoryController with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    print("Fetch Categories");
    _isLoading = true;
    notifyListeners();

    final categories = await CategoriesApi.fetchCategories();
    if (categories != null) {
      _categories = categories;
    }

    print(categories);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategoryById(int id) async {
    _isLoading = true;
    notifyListeners();

    final category = await CategoriesApi.fetchCategoryById(id);
    if (category != null) {
      _categories = [category];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createCategory(String title, String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    final category = await CategoriesApi.createCategory(title, imageUrl);
    if (category != null) {
      _categories.add(category);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateCategory(int id, String title, String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    final updatedCategory =
        await CategoriesApi.updateCategory(id, title, imageUrl);
    if (updatedCategory != null) {
      final index = _categories.indexWhere((category) => category.id == id);
      if (index != -1) {
        _categories[index] = updatedCategory;
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteCategory(int id) async {
    _isLoading = true;
    notifyListeners();

    final success = await CategoriesApi.deleteCategory(id);
    if (success) {
      _categories.removeWhere((category) => category.id == id);
    }

    _isLoading = false;
    notifyListeners();
  }
}
