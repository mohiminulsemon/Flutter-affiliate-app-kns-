class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String role;
  final String status;
  final String referralCode;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.role,
    required this.status,
    required this.referralCode,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      referralCode: json['referralCode'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
