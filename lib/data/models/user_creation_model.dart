class UserCreation {
  final String name;
  final String password;
  final String email;

  UserCreation({
    required this.name,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': name,
      'password': password,
      'email': email,
    };
  }
}
