class User {
  // ! this should be changed
  final String token;
  final String role;
  final String name;

  User({required this.role, required this.name, required this.token});

  factory User.fromJson(Map<String, dynamic> json, String token) {
    return User(
      token: token,
      role: "ejecutivo",
      name: json['body'][0]["Nombre"],
    );
  }
}
