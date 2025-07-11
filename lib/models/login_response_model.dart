class LoginData {
  final String accessToken;
  final User user;

  LoginData({required this.accessToken, required this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['accessToken'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String email;
  final String userName;

  User({
    required this.id,
    required this.email,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
    );
  }
}
