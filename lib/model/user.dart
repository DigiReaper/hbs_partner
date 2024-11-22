class User {
  final int id;
  final String name;
  final String email;
  final String mobileNumber;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileno'],
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileno': mobileNumber,
      'role': role,
    };
  }
}