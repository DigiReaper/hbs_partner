class Service {
  final int id;
  final int subcategoryId;
  final int categoryId;
  final String title;
  final double price;
  final double priceWithGst;
  final String imageUrl;
  final String serviceIncludes;
  final String serviceExcludes;

  Service({
    required this.id,
    required this.subcategoryId,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.serviceIncludes,
    required this.serviceExcludes,
    required this.priceWithGst,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      subcategoryId: json['subcategory'],
      categoryId: json['category'],
      title: json['sub_subcategory_name'],
      price: double.tryParse(json['rate'].toString()) ?? 0.0,
      priceWithGst: double.tryParse(json['ratewithgst'].toString()) ?? 0.0,
      imageUrl: json['sub_subcategory_image'],
      serviceIncludes: json['service_include'] ?? '',
      serviceExcludes: json['service_not_include'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subcategory': subcategoryId,
      'category': categoryId,
      'sub_subcategory_name': title,
      'rate': price,
      'rate_with_gst': priceWithGst,
      'sub_subcategory_image': imageUrl,
      'service_include': serviceIncludes,
      'service_not_include': serviceExcludes,
    };
  }
}
