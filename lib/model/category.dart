class Category {
  final int id;
  final String title;
  final String imageUrl;

  Category({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['category_name'],
      imageUrl: json['category_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': title,
      'category_image': imageUrl,
    };
  }
}

// List<Category> homeCatetories = [
//   Category(title: 'Plumber', image: 'assets/images/home/plumber.webp'),
//   Category(title: 'Electrician', image: 'assets/images/home/electrician.webp'),
//   Category(title: 'Carpenter', image: 'assets/images/home/carpenter.webp'),
//   Category(title: 'Pest Control', image: 'assets/images/home/pestcontrol.webp'),
//   Category(title: 'Painting', image: 'assets/images/home/painting.webp'),
//   Category(title: 'Interiors', image: 'assets/images/home/interiors.webp'),
// ];

// List<Category> appliancesCatetories = [
//   Category(title: 'Air Conditioner', image: 'assets/images/appliances/airconditioner.webp'),
//   Category(title: 'Refrigerator', image: 'assets/images/appliances/refrigerator.webp'),
//   Category(title: 'Washing Machine', image: 'assets/images/appliances/washingmachine.webp'),
//   Category(title: 'Microwave Oven', image: 'assets/images/appliances/microwaveoven.webp'),
//   Category(title: 'Geyser', image: 'assets/images/appliances/geyser.webp'),
// ];

