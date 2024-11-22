class Subcategory {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrl,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'],
      categoryId: json['category'],
      title: json['subcategory_name'],
      imageUrl: json['subcategory_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': categoryId,
      'subcategory_name': title,
      'subcategory_image': imageUrl,
    };
  }
}