import 'package:flutter/material.dart';
import 'package:hbs_partner/api/subcategories_api.dart';
import 'package:hbs_partner/model/subcategory.dart';

class SubcategoryController with ChangeNotifier {
  List<Subcategory> _subcategories = [];
  bool _isLoading = false;

  List<Subcategory> get subcategories => _subcategories;
  bool get isLoading => _isLoading;

  Future<void> fetchSubcategories() async {
    _isLoading = true;
    notifyListeners();

    final subcategories = await SubcategoriesApi.fetchSubcategories();
    if (subcategories != null) {
      _subcategories = subcategories;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSubcategoryById(int id) async {
    _isLoading = true;
    notifyListeners();

    final subcategory = await SubcategoriesApi.fetchSubcategoryById(id);
    if (subcategory != null) {
      _subcategories = [subcategory];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createSubcategory(
      int categoryId, String title, String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    final subcategory =
        await SubcategoriesApi.createSubcategory(categoryId, title, imageUrl);
    if (subcategory != null) {
      _subcategories.add(subcategory);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateSubcategory(
      int id, int categoryId, String title, String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    final updatedSubcategory = await SubcategoriesApi.updateSubcategory(
        id, categoryId, title, imageUrl);
    if (updatedSubcategory != null) {
      final index =
          _subcategories.indexWhere((subcategory) => subcategory.id == id);
      if (index != -1) {
        _subcategories[index] = updatedSubcategory;
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteSubcategory(int id) async {
    _isLoading = true;
    notifyListeners();

    final success = await SubcategoriesApi.deleteSubcategory(id);
    if (success) {
      _subcategories.removeWhere((subcategory) => subcategory.id == id);
    }

    _isLoading = false;
    notifyListeners();
  }
}
