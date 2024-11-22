import 'package:flutter/material.dart';
import 'package:hbs_partner/api/services_api.dart';
import 'package:hbs_partner/model/service.dart';

class ServiceController with ChangeNotifier {
  List<Service> _services = [];
  bool _isLoading = false;

  List<Service> get services => _services;
  bool get isLoading => _isLoading;

  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();

    final services = await ServicesApi.fetchServices();
    if (services != null) {
      _services = services;
    }

    _isLoading = false;
    notifyListeners();
  }

//remove in prod
  // Future<void> fetchServiceById(int id) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final service = await ServicesApi.fetchServiceById(id);
  //   if (service != null) {
  //     _services = [service];
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  //Get service by id
  Future<Service?> getServiceById(int id) async {
    try {
      final service = await ServicesApi.fetchServiceById(id);
      if (service != null) {
        return service;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> createService(int subcategoryId, String title, double price,
      String imageUrl, String serviceIncludes, String serviceExcludes) async {
    _isLoading = true;
    notifyListeners();

    final service = await ServicesApi.createService(subcategoryId, title, price,
        imageUrl, serviceIncludes, serviceExcludes);
    if (service != null) {
      _services.add(service);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateService(
      int id,
      int subcategoryId,
      String title,
      double price,
      String imageUrl,
      String serviceIncludes,
      String serviceExcludes) async {
    _isLoading = true;
    notifyListeners();

    final updatedService = await ServicesApi.updateService(id, subcategoryId,
        title, price, imageUrl, serviceIncludes, serviceExcludes);
    if (updatedService != null) {
      final index = _services.indexWhere((service) => service.id == id);
      if (index != -1) {
        _services[index] = updatedService;
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteService(int id) async {
    _isLoading = true;
    notifyListeners();

    final success = await ServicesApi.deleteService(id);
    if (success) {
      _services.removeWhere((service) => service.id == id);
    }

    _isLoading = false;
    notifyListeners();
  }
}
