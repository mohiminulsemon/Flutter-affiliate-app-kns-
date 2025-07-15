class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String contactNumber;
  final String role;
  final String status;
  final String referralCode;
  final String placeholderCode;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.contactNumber,
    required this.role,
    required this.status,
    required this.referralCode,
    required this.placeholderCode,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      role: json['role'],
      status: json['status'],
      referralCode: json['referralCode'],
      placeholderCode: json['placeholderCode'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
