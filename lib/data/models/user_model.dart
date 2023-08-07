class User {
  // ! this should be changed
  final String token;
  final String name;

  User({required this.token, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      name: json['message'],
    );
  }
}
